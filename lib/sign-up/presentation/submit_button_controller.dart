import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/game_repository.dart';

final bookingControllerProvider =
    AsyncNotifierProvider<BookingController, void>(() => BookingController());

class BookingController extends AsyncNotifier<void> {
  @override
  void build() {}

  Future<bool> submit({
    required String? phoneNumber,
    required DateTime? selectedDate,
  }) async {
    final e164 = _normalizeUsPhoneToE164(phoneNumber);
    if (e164 == null) {
      state = const AsyncError(
        FormatException('Please enter a valid 10-digit US phone number'),
        StackTrace.empty,
      );
      return false;
    }

    if (selectedDate == null) {
      state = const AsyncError(
        FormatException('Please choose a date and time'),
        StackTrace.empty,
      );
      return false;
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref
          .read(gameRepositoryProvider)
          .submitGame(phoneNumber: e164, timeSlot: selectedDate);
    });
    return state.hasError ? false : true;
  }

  /// Accepts `415-555-1234`, `14155551234`, or `+14155551234` and returns `+14155551234`.
  String? _normalizeUsPhoneToE164(String? raw) {
    final digits = (raw ?? '').replaceAll(RegExp(r'\D'), '');
    if (digits.length == 10) return '+1$digits';
    if (digits.length == 11 && digits.startsWith('1')) return '+$digits';
    if (RegExp(r'^\+\d{11,15}$').hasMatch((raw ?? '').trim()))
      return (raw ?? '').trim();
    return null;
  }
}
