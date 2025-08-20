import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haight_puzzle_hunt/sign-up/presentation/cancel_screen_controller.dart';
import 'package:haight_puzzle_hunt/sign-up/presentation/phone_input.dart';
import 'package:haight_puzzle_hunt/sign-up/presentation/title.dart';

class CancelScreen extends ConsumerStatefulWidget {
  const CancelScreen({super.key});

  @override
  ConsumerState<CancelScreen> createState() => _CancelScreenState();
}

class _CancelScreenState extends ConsumerState<CancelScreen> {
  final TextEditingController phoneController = TextEditingController();
  String? cleanedPhoneNumber;

  Widget build(BuildContext context) {
    final cancelState = ref.watch(cancelControllerProvider);
    ref.listen(cancelControllerProvider, (prev, next) {
      next.when(
        data: (_) {
          // only show on transition from loading -> data
          if (prev?.isLoading == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Game was successfully canceled')),
            );
            // optional: clear state so it doesn’t retrigger
            ref.read(cancelControllerProvider.notifier).reset();
          }
        },
        loading: () {}, // no-op
        error: (e, _) {
          final msg =
              (e is FormatException && e.message.isNotEmpty)
                  ? e.message
                  : e.toString();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to cancel: $msg')));
          ref.read(cancelControllerProvider.notifier).reset();
        },
      );
    });
    return Scaffold(
      appBar: AppBar(title: const Text("Modify existing booking")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TitleName(text: "Haight Spirit Trail"),
            const SizedBox(height: 24),
            Text(
              "Enter the phone number used for booking to start a "
              "cancellation request. If there is an active booking for the entered phone number a cancellation request will be send via text.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            PhoneInputField(
              controller: phoneController,
              onValidNumber: (value) {
                setState(() {
                  cleanedPhoneNumber = value.isNotEmpty ? value : null;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  cancelState.isLoading
                      ? null
                      : () {
                        ref
                            .read(cancelControllerProvider.notifier)
                            .cancel(phoneNumber: cleanedPhoneNumber);
                      },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade200,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child:
                  cancelState.isLoading
                      ? const CircularProgressIndicator()
                      : const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text("Submit Cancellation"),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
