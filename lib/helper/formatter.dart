import 'package:intl/intl.dart';

String moneyFormatter(double money) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: "Rp ",
    decimalDigits: 0,
  ).format(money);
}
