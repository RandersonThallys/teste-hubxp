import 'package:intl/intl.dart';

class Formatting {
  String value(double value) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
  }
}
