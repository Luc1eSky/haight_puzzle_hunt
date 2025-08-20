import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/game_repository.dart';

/// PROVIDER
final cancelControllerProvider =
    StateNotifierProvider<CancelController, AsyncValue<void>>(
      (ref) => CancelController(ref),
    );

/// CONTROLLER
class CancelController extends StateNotifier<AsyncValue<void>> {
  CancelController(this.ref) : super(const AsyncData(null));

  final Ref ref;

  Future<void> cancel({required String? phoneNumber}) async {
    // quick guard
    final digits = _digitsOnly(phoneNumber);
    if (digits == null) {
      state = const AsyncError(
        FormatException('Enter your phone number first.'),
        StackTrace.empty,
      );
      return;
    }

    state = const AsyncLoading();

    final repo = ref.read(gameRepositoryProvider);
    state = await AsyncValue.guard(() async {
      await repo.cancelGame(phoneNumber: digits);
    });
  }

  void reset() => state = const AsyncData(null);

  String? _digitsOnly(String? raw) {
    final d = (raw ?? '').replaceAll(RegExp(r'\D'), '');
    return d.isEmpty ? null : d;
  }
}
