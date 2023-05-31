import 'package:intl/intl.dart' as ints;

class DateFormatter {
  static final ints.DateFormat formatter = ints.DateFormat('yyyy-MM-dd');
  static String getFormated(DateTime date) {
    return formatter.format(date);
  }
}
