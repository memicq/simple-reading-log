import 'package:intl/intl.dart';

class DateTimeUtil {
  static String toLocaleDateString(DateTime dateTime) {
    DateFormat format = DateFormat('yyyy/MM/dd(E)', 'ja');
    return format.format(dateTime);
  }

  static String toLocaleSimpleDateString(DateTime dateTime) {
    DateFormat format = DateFormat('MM/dd', 'ja');
    return format.format(dateTime);
  }

  static String toLocaleDateTimeString(DateTime dateTime) {
    DateFormat format = DateFormat('yyyy/MM/dd(E) HH:mm', 'ja');
    return format.format(dateTime);
  }

  static int dateKey(DateTime dateTime) {
    return dateTime.year * 10000 + dateTime.month * 100 + dateTime.day;
  }
}
