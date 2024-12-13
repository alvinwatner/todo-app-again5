import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('MMM dd, yyyy').format(date);
}

String formatDateTime(DateTime date) {
  return DateFormat('MMM dd, yyyy hh:mm a').format(date);
}

String formatTime(DateTime date) {
  return DateFormat('hh:mm a').format(date);
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

DateTime startOfDay(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

DateTime endOfDay(DateTime date) {
  return DateTime(date.year, date.month, date.day, 23, 59, 59);
}
