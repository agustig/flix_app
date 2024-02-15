import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String toUSDCurrencyFormat({String? symbol, decimalDigits = 2}) =>
      NumberFormat.currency(
        locale: 'en_US',
        symbol: symbol ?? 'USD ',
        decimalDigits: decimalDigits,
      ).format(this);
}
