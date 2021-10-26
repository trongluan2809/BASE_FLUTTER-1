import 'package:intl/intl.dart';

class NumberFormatted {
  static String format(double price) {
    final format = NumberFormat("#,##0", "en_US");
    return format.format(price);
  }
}
