import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haight_puzzle_hunt/sign-up/domain/game.dart';

import '../../config/app_globals.dart';

class GameRepository {
  final FirebaseFirestore _firestore;

  GameRepository(this._firestore);

  static const _activeStates = ['gameBooked', 'verified', 'inProgress'];

  Future<void> submitGame({
    required String? phoneNumber,
    required DateTime? timeSlot,
  }) async {
    if (phoneNumber == null || timeSlot == null) {
      throw ArgumentError("phoneNumber and timeSlot cannot be null");
    }

    // 1) Client-side guard: max 1 active bookings for this phone
    final activeAgg =
        await _firestore
            .collection('games')
            .where('phoneNumber', isEqualTo: phoneNumber)
            .where('gameState', whereIn: _activeStates)
            .count()
            .get();

    final activeCount = activeAgg.count ?? 0;
    if (activeCount >= maxActiveGames) {
      throw Exception('You can only have one active booking at a time.');
    }

    // 2) Transaction: check the slot uniqueness, then create
    final newGame = Game(
      phoneNumber: phoneNumber,
      bookingSubmissionAt: DateTime.now(),
      bookedGameDateTime: timeSlot,
      gameState: GameState.gameBooked,
    );

    final gamesRef = _firestore.collection('games');
    //await _firestore.collection('games').add(game.toJson());

    await _firestore.runTransaction((transaction) async {
      // Check if slot is already taken by any active booking
      final slotSnap =
          await gamesRef
              .where('bookedGameDateTime', isEqualTo: Timestamp.fromDate
            (timeSlot))
              .where('gameState', whereIn: _activeStates)
              .limit(1)
              .get();

      if (slotSnap.docs.isNotEmpty) {
        throw Exception('That time slot is already booked.');
      }

      transaction.set(gamesRef.doc(), newGame.toJson());
    });
  }

  Future<void> cancelGame({required String? phoneNumber}) async {
    final e164 = _toE164Us(phoneNumber);
    if (e164 == null) {
      throw ArgumentError('Please enter a valid US phone number');
    }

    //gameStates which allow cancellation
    const cancellableStates = ['gameBooked', 'verified'];

    final canceledDoc =
        await _firestore
            .collection('games')
            .where('phoneNumber', isEqualTo: e164) // <-- match stored value
            .where('gameState', whereIn: cancellableStates)
            .orderBy('bookingSubmissionAt', descending: true)
            .limit(1)
            .get();

    if (canceledDoc.docs.isEmpty) {
      // Optional: small diagnostic to help you debug in logs
      // debugPrint useful info
      // debugPrint('Probe for $e164 -> ${probe.size}: ${probe.docs.map((d)=>d.get('gameState'))}');
      throw StateError('No active booking found to cancel.');
    }
    final doc = canceledDoc.docs.first;
    final gameId = doc.id;
    final bookedGameDateTime = (doc['bookedGameDateTime'] as Timestamp).toDate();
    final bookingSubmissionAt = (doc['bookingSubmissionAt'] as Timestamp).toDate();
    final docRef = canceledDoc.docs.first.reference;

    await _firestore.runTransaction((tx) async {
      final snap = await tx.get(docRef);
      if (!snap.exists) throw StateError('Booking no longer exists.');

      final data = snap.data() as Map<String, dynamic>;
      final state = data['gameState'] as String?;
      if (state != 'gameBooked' && state != 'verified') {
        throw StateError('Game is no longer cancelable.');
      }

      tx.update(docRef, {'gameState': 'canceled'});
    });
    // Create a cancellation event (idempotent by using gameId)
    await _firestore
        .collection('cancellation_events')
        .doc(gameId) // deterministic id → avoids duplicates
        .set({
          'gameId': gameId,
          'phoneNumber': e164,
          'bookedGameDateTime': Timestamp.fromDate(bookedGameDateTime),
          'bookingSubmissionAt': Timestamp.fromDate(bookingSubmissionAt),
          'deletedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: false));
  }

  String? _toE164Us(String? raw) {
    final s = (raw ?? '').trim();
    // already E.164?
    if (RegExp(r'^\+\d{11,15}$').hasMatch(s)) return s;
    final digits = s.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 11 && digits.startsWith('1')) return '+$digits';
    if (digits.length == 10) return '+1$digits';
    return null;
  }

  Stream<List<TimeOfDay>> watchBookedSlotsForDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return _firestore
        .collection('games')
        .where(
          'bookedGameDateTime',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
        )
        .where(
          'bookedGameDateTime',
          isLessThanOrEqualTo: Timestamp.fromDate(endOfDay),
        )
        .where(
          'gameState',
          whereIn: ['verified', 'gameBooked'], // filter for only these states
        )
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final ts = doc['bookedGameDateTime'] as Timestamp;
            final date = ts.toDate();
            return TimeOfDay(hour: date.hour, minute: date.minute);
          }).toList();
        });
  }
}

final gameRepositoryProvider = Provider((ref) {
  return GameRepository(FirebaseFirestore.instance);
});

final bookedSlotsProvider = StreamProvider.family<List<TimeOfDay>, DateTime>((
  ref,
  date,
) {
  final repo = ref.watch(gameRepositoryProvider);
  return repo.watchBookedSlotsForDate(date);
});
