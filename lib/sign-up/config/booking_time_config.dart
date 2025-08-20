import 'package:flutter/material.dart';
import '../../config/app_globals.dart';


/// Generate base slots from config
List<TimeOfDay> generateBaseSlots() {
  final List<TimeOfDay> slots = [];
  for (int h = startHour; h <= endHourInclusive; h++) {
    slots.add(TimeOfDay(hour: h, minute: 0));
  }
  return slots;
}

/// Helper: is this weekday open?
bool isOpenDay(DateTime d) => openWeekdays.contains(d.weekday);
