import 'package:intl/intl.dart' as ints;

class DateFormatter {
  static final ints.DateFormat formatter = ints.DateFormat('yyyy-MM-dd');

  static String getFormated(DateTime date) {
    return formatter.format(date);
  }

  static String getDateString(DateTime date) {
    return "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day}";
  }
}
