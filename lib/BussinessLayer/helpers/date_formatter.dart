import 'package:intl/intl.dart' as ints;

class DateFormatter {
  static final ints.DateFormat formatter = ints.DateFormat('yyyy-MM-dd');

  static String getFormated(DateTime? date) {
    if (date != null) {
      return formatter.format(date);
    }
    return '';
  }

  static String getDateString(DateTime date) {
    return "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day}";
  }

  static String getCurrentDateString() {
    return "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
  }
}
