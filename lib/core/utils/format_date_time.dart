import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

  String timeString = DateFormat('hh:mm a').format(dateTime);

  if (date == today) {
    return 'Today $timeString';
  } else if (date == yesterday) {
    return 'Yesterday $timeString';
  } else if (now.difference(dateTime).inDays < 7) {
    return '${DateFormat('EEEE').format(dateTime)} $timeString';
  } else {
    return '${DateFormat('M/d/yyyy').format(dateTime)} $timeString';
  }
}
