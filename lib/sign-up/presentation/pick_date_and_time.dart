import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haight_puzzle_hunt/sign-up/data/game_repository.dart';
import 'package:haight_puzzle_hunt/sign-up/presentation/cancel_screen.dart';
import 'package:haight_puzzle_hunt/sign-up/presentation/confirmation_screen.dart';
import 'package:haight_puzzle_hunt/sign-up/presentation/phone_input.dart';
import 'package:haight_puzzle_hunt/sign-up/presentation/submit_button_controller.dart';
import 'package:intl/intl.dart';

import '../../config/app_globals.dart';
import '../config/booking_time_config.dart';
import '../config/date_booking_limits.dart';

class PickDateAndTime extends StatefulWidget {
  const PickDateAndTime({super.key});

  @override
  State<PickDateAndTime> createState() => _PickDateAndTimeState();
}

class _PickDateAndTimeState extends State<PickDateAndTime> {
  final TextEditingController phoneController = TextEditingController();
  DateTime? selectedDate;
  String? cleanedPhoneNumber;
  TimeOfDay? selectedTimeSlot;
  DateTime? pickedDate;

  Future<void> pickDateTime() async {
    final now = DateTime.now();
    final threeMonthsLater = DateTime(now.year, now.month + 3, now.day);

    DateTime initialDate = now;
    while (initialDate.weekday < 4 || initialDate.weekday > 7) {
      initialDate = initialDate.add(const Duration(days: 1));
    }

    DateTime? date = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: threeMonthsLater,
      initialDate: initialDate,
      selectableDayPredicate:
          (date) => date.weekday >= 4 && date.weekday <= 7, // Thu–Sun
    );

    if (date == null) return;

    setState(() {
      pickedDate = date;
      selectedTimeSlot = null;
      selectedDate = null; // reset full datetime until both are selected
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PhoneInputField(
          controller: phoneController,
          onValidNumber: (value) {
            setState(() {
              cleanedPhoneNumber = value.isNotEmpty ? value : null;
            });
          },
        ),
        SizedBox(height: 24),
        _DateSelector(
          pickedDate: pickedDate,
          onDateChanged: (newDate) {
            setState(() {
              pickedDate = newDate;
              selectedTimeSlot = null;
              selectedDate = null;
            });
          },
        ),
        if (pickedDate != null)
          _TimeSlotSelector(
            selectedTime: selectedTimeSlot,
            pickedDate: pickedDate!,
            onTimeSelected: (time, fullDateTime) {
              setState(() {
                selectedTimeSlot = time;
                selectedDate = fullDateTime;
              });
            },
          ),
        const SizedBox(height: 24),
        SubmitButton(
          phoneNumber: cleanedPhoneNumber,
          selectedDate: selectedDate,
        ),
        const SizedBox(height: 12),
        CancelButton(
          phoneNumber: cleanedPhoneNumber,
          selectedDate: selectedDate,
        ),
      ],
    );
  }
}

class _DateSelector extends StatelessWidget {
  final DateTime? pickedDate;
  final ValueChanged<DateTime> onDateChanged;

  const _DateSelector({required this.pickedDate, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    final minDate = getMinBookingDate();
    final maxDate = getMaxBookingDate();
    final picked = pickedDate != null ? toMidnight(pickedDate!) : null;

    final canGoBack = picked != null && picked.isAfter(minDate);
    final canGoForward = picked != null && picked.isBefore(maxDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_left),
          onPressed:
              canGoBack
                  ? () {
                    final prev = previousAvailable(picked);
                    onDateChanged(prev.isBefore(minDate) ? minDate : prev);
                  }
                  : null,
        ),
        const Icon(Icons.calendar_month, color: Colors.black),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: picked ?? minDate,
              firstDate: minDate,
              lastDate: maxDate,
              selectableDayPredicate: isThuSun,
            );
            if (date != null) onDateChanged(date);
          },
          child: Text(
            picked != null
                ? DateFormat('EEEE, MMM d').format(picked)
                : "Choose a date",
            style: const TextStyle(
              fontFamily: 'RockSalt',
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_right),
          onPressed:
              canGoForward
                  ? () {
                    final next = nextAvailable(picked);
                    onDateChanged(next.isAfter(maxDate) ? maxDate : next);
                  }
                  : null,
        ),
      ],
    );
  }
}

class _TimeSlotSelector extends ConsumerWidget {
  final TimeOfDay? selectedTime;
  final DateTime pickedDate;
  final void Function(TimeOfDay, DateTime) onTimeSelected;

  const _TimeSlotSelector({
    required this.selectedTime,
    required this.pickedDate,
    required this.onTimeSelected,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookedSlotsAsync = ref.watch(bookedSlotsProvider(pickedDate));

    final now = DateTime.now();
    final cutoff = now.add(Duration(hours: sameDayCutoffHours));
    final isSameDay = DateUtils.isSameDay(pickedDate, now);

    final baseSlots = generateBaseSlots();

    final visibleSlots =
        baseSlots.where((t) {
          if (!isSameDay) return true;
          final slotDT = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            t.hour,
            t.minute,
          );
          // keep if slot >= cutoff
          return !slotDT.isBefore(cutoff);
        }).toList();

    return bookedSlotsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Error loading slots: $e'),
      data: (bookedSlots) {
        if (visibleSlots.isEmpty) {
          return const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text("No time slots left today. Please pick another day."),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text(
              "Choose a time:",
              style: TextStyle(fontFamily: 'RockSalt', fontSize: 16),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    visibleSlots.map((time) {
                      final label = time.format(context);
                      final isBooked = bookedSlots.contains(time);
                      final isSelected = selectedTime == time;

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text(label),
                          selected: isSelected,
                          onSelected:
                              isBooked
                                  ? null
                                  : (_) {
                                    final combinedDate = DateTime(
                                      pickedDate.year,
                                      pickedDate.month,
                                      pickedDate.day,
                                      time.hour,
                                      time.minute,
                                    );
                                    onTimeSelected(time, combinedDate);
                                  },
                          selectedColor: Colors.deepPurple.shade100,
                          disabledColor: Colors.grey.shade300,
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SubmitButton extends ConsumerWidget {
  final String? phoneNumber;
  final DateTime? selectedDate;

  const SubmitButton({
    super.key,
    required this.phoneNumber,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingControllerProvider);

    // Centralized SnackBars for errors (optional, nice UX)
    ref.listen(bookingControllerProvider, (prev, next) {
      next.whenOrNull(
        error: (e, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.toString())));
        },
      );
    });

    return ElevatedButton(
      onPressed:
          bookingState.isLoading
              ? null
              : () async {
                final ok = await ref
                    .read(bookingControllerProvider.notifier)
                    .submit(
                      phoneNumber: phoneNumber,
                      selectedDate: selectedDate,
                    );

                if (!ok) {
                  if (!context.mounted) return;
                  final errMsg = bookingState.maybeWhen(
                    error: (e, _) => e.toString(),
                    orElse: () => 'Failed to book game',
                  );
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(errMsg)));
                  return; // 🚫 don’t navigate
                }

                if (!context.mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => ConfirmationScreen(
                          phone: phoneNumber!,
                          date: selectedDate!,
                        ),
                  ),
                );
              },

      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple.shade200,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child:
          bookingState.isLoading
              ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: const Text("Confirm Signup"),
              ),
    );
  }
}

class CancelButton extends ConsumerWidget {
  final String? phoneNumber;
  final DateTime? selectedDate;

  const CancelButton({
    super.key,
    required this.phoneNumber,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 250, // set your max width here
      ),
      child: TextButton(
        onPressed: () {
          print('Pushed cancel button');
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CancelScreen()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          //backgroundColor: Colors.deepPurple.shade200,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: const Text(
            "Modify existing booking",
            style: TextStyle(fontFamily: 'RockSalt', fontSize: 14),
          ),
        ),
      ),
    );
  }
}
