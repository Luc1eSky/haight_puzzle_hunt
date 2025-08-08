import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haight_puzzle_hunt/sign-up/domain/game.dart';

class GameRepository {
  final FirebaseFirestore _firestore;

  GameRepository(this._firestore);

  Future<void> submitGame({
    required String? phoneNumber,
    required DateTime? timeSlot,
  }) async {
    if (phoneNumber == null || timeSlot == null) {
      throw ArgumentError("phoneNumber and timeSlot cannot be null");
    }

    final newGame = Game(
      phoneNumber: phoneNumber,
      createdAt: DateTime.now(),
      bookedDateTime: timeSlot,
      gameState: GameState.gameBooked,
    );

    //await _firestore.collection('games').add(game.toJson());

    await _firestore.runTransaction((transaction) async {
      //throw Exception('exception transaction');
      final gamesRef = _firestore.collection('games');
      final query =
          await gamesRef
              .where('bookedDateTime', isEqualTo: Timestamp.fromDate(timeSlot))
              .get();

      if (query.docs.isNotEmpty) {
        // Slot already booked
        throw Exception('Time slot already booked.');
      }

      // Safe to add the new game
      transaction.set(gamesRef.doc(), newGame.toJson());
    });
  }

  Stream<List<TimeOfDay>> watchBookedSlotsForDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return _firestore
        .collection('games')
        .where(
          'bookedDateTime',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
        )
        .where(
          'bookedDateTime',
          isLessThanOrEqualTo: Timestamp.fromDate(endOfDay),
        )
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final ts = doc['bookedDateTime'] as Timestamp;
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
