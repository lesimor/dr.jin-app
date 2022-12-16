// Package imports:
import 'package:intl/intl.dart';

// convert Datetime to weekday string
String getWeekday(DateTime date) {
  switch (date.weekday) {
    case 1:
      return '월';
    case 2:
      return '화';
    case 3:
      return '수';
    case 4:
      return '목';
    case 5:
      return '금';
    case 6:
      return '토';
    case 7:
      return '일';
    default:
      return '';
  }
}

String getSimpleDayFormat(DateTime date) {
  return '${DateFormat('yyyy.MM.dd').format(date)} (${getWeekday(date)}) ${DateFormat('HH:mm').format(date)}';
}

String toIsoFormmatedString(DateTime datetime) {
  return datetime.toIso8601String();
}

DateTime fromDateTimeString(String formattedString) {
  return DateTime.parse(formattedString);
}
