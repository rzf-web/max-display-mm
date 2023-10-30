import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

String doubleFormatter(double data) {
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  String s = data.toString().replaceAll(regex, '');
  return s;
}

String moneyFormatter(double money) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: "Rp ",
    decimalDigits: 0,
  ).format(money);
}
