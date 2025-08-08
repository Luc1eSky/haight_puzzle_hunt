import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haight_puzzle_hunt/sign-up/data/game_repository.dart';
import 'package:haight_puzzle_hunt/sign-up/presentation/confirmation_screen.dart';
import 'package:intl/intl.dart';

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _PhoneInputField(
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
      ],
    );
  }
}

class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 0) buffer.write('(');
      if (i == 3) buffer.write(') ');
      if (i == 6) buffer.write('-');
      if (i >= 10) break;
      buffer.write(digitsOnly[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class _PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onValidNumber;

  const _PhoneInputField({
    required this.controller,
    required this.onValidNumber,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _UsNumberTextInputFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        hintText: '(123) 456-7890',
        labelStyle: TextStyle(fontFamily: 'RockSalt', color: Colors.black),
        border: OutlineInputBorder(),
      ),
      style: const TextStyle(fontFamily: 'RockSalt', color: Colors.black),
      onChanged: (value) {
        final digits = value.replaceAll(RegExp(r'[^\d]'), '');
        if (digits.length == 10) {
          onValidNumber('+1$digits');
        } else {
          onValidNumber('');
        }
      },
    );
  }
}

class _DateSelector extends StatelessWidget {
  final DateTime? pickedDate;
  final ValueChanged<DateTime> onDateChanged;

  const _DateSelector({required this.pickedDate, required this.onDateChanged});

  // Returns the next available Thu–Sun
  DateTime _nextAvailable(DateTime from) {
    DateTime next = from.add(const Duration(days: 1));
    while (next.weekday < 4 || next.weekday > 7) {
      next = next.add(const Duration(days: 1));
    }
    return next;
  }

  // Returns the previous available Thu–Sun
  DateTime _previousAvailable(DateTime from) {
    DateTime prev = from.subtract(const Duration(days: 1));
    while (prev.weekday < 4 || prev.weekday > 7) {
      prev = prev.subtract(const Duration(days: 1));
    }
    return prev;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final threeMonthsLater = DateTime(today.year, today.month + 3, today.day);

    // Find the earliest and latest available dates (Thu–Sun only)
    DateTime? minDate;
    DateTime tempMin = today;
    while (tempMin.weekday < 4 || tempMin.weekday > 7) {
      tempMin = tempMin.add(const Duration(days: 1));
    }
    minDate = tempMin;

    DateTime? maxDate;
    DateTime tempMax = threeMonthsLater;
    while (tempMax.weekday < 4 || tempMax.weekday > 7) {
      tempMax = tempMax.subtract(const Duration(days: 1));
    }
    maxDate = tempMax;

    final canGoBack = pickedDate != null && pickedDate!.isAfter(minDate);
    final canGoForward = pickedDate != null && pickedDate!.isBefore(maxDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_left),
          onPressed:
              canGoBack
                  ? () {
                    final prev = _previousAvailable(pickedDate!);
                    if (!prev.isBefore(minDate!)) {
                      onDateChanged(prev);
                    }
                  }
                  : null,
        ),
        const Icon(Icons.calendar_month, color: Colors.black),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () async {
            DateTime initial = pickedDate ?? minDate!;
            final date = await showDatePicker(
              context: context,
              initialDate: initial,
              firstDate: minDate!,
              lastDate: maxDate!,
              selectableDayPredicate: (d) => d.weekday >= 4 && d.weekday <= 7,
            );
            if (date != null) {
              onDateChanged(date);
            }
          },
          child: Text(
            pickedDate != null
                ? DateFormat('EEEE, MMM d').format(pickedDate!)
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
                    final next = _nextAvailable(pickedDate!);
                    if (!next.isAfter(maxDate!)) {
                      onDateChanged(next);
                    }
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

    return bookedSlotsAsync.when(
      loading: () => Center(child: const CircularProgressIndicator()),
      error: (e, _) => Text('Error loading slots: $e'),
      data: (bookedSlots) {
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
                children: List.generate(5, (i) {
                  final time = TimeOfDay(hour: 12 + i, minute: 0);
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
                }),
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
    return ElevatedButton(
      onPressed: () async {
        if (phoneNumber == null || phoneNumber!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please enter a valid 10-digit US phone number"),
            ),
          );
          return;
        }

        if (selectedDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please choose a date and time")),
          );
          return;
        }

        try {
          //throw Exception('test exception');
          await ref
              .read(gameRepositoryProvider)
              .submitGame(phoneNumber: phoneNumber, timeSlot: selectedDate);

          // Navigate after successful submission
          if (context.mounted) {
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
          }
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to submit: $e')));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF005AA7),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: const Text(
        "Confirm Signup",
        style: TextStyle(fontFamily: 'RockSalt', fontSize: 18),
      ),
    );
  }
}
