class DateHelper {
  /// Returns a 3-letter day name (e.g., "Mon", "Tue").
  static String getShortDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (weekday < 1 || weekday > 7) return '';
    return days[weekday - 1];
  }

  /// Returns a 3-letter month name (e.g., "Jan", "Feb").
  static String getShortMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    if (month < 1 || month > 12) return '';
    return months[month - 1];
  }

  /// Formats an epoch timestamp into a human-readable AM/PM string.
  /// Example: 1712457600 -> "12:00 PM"
  static String formatEpochToString(int? epoch) {
    if (epoch == null) return '';
    final date = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    final hour = date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final amPm = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return '$hour12:$minute $amPm';
  }

  /// Formats an epoch timestamp into a full date string.
  /// Example: 1712457600 -> "7 Apr 2026"
  static String formatEpochToFullDate(int? epoch) {
    if (epoch == null) return '';
    final date = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    final day = date.day;
    final month = getShortMonthName(date.month);
    final year = date.year;
    return '$day $month $year';
  }
}
