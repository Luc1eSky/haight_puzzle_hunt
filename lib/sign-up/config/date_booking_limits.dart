/// Returns true if the date is Thursday through Sunday
bool isThuSun(DateTime d) =>
    d.weekday >= DateTime.thursday && d.weekday <= DateTime.sunday;

/// Strips time from DateTime
DateTime toMidnight(DateTime d) => DateTime(d.year, d.month, d.day);

/// Earliest date you can book (Thu–Sun, starting today or next Thu)
DateTime getMinBookingDate() {
  DateTime today = toMidnight(DateTime.now());
  if (isThuSun(today)) {
    return today;
  }
  while (!isThuSun(today)) {
    today = today.add(const Duration(days: 1));
  }
  return today;
}

/// Latest date you can book (Thu–Sun, 3 months ahead)
DateTime getMaxBookingDate() {
  DateTime limit = toMidnight(DateTime.now().add(const Duration(days: 90)));
  while (!isThuSun(limit)) {
    limit = limit.subtract(const Duration(days: 1));
  }
  return limit;
}

/// Get the next available Thu–Sun
DateTime nextAvailable(DateTime from) {
  DateTime next = toMidnight(from.add(const Duration(days: 1)));
  while (!isThuSun(next)) {
    next = next.add(const Duration(days: 1));
  }
  return next;
}

/// Get the previous available Thu–Sun
DateTime previousAvailable(DateTime from) {
  DateTime prev = toMidnight(from.subtract(const Duration(days: 1)));
  while (!isThuSun(prev)) {
    prev = prev.subtract(const Duration(days: 1));
  }
  return prev;
}
