import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String toUSDCurrencyFormat() =>
      NumberFormat.currency(locale: 'en_US', symbol: 'USD ', decimalDigits: 2)
          .format(this);
}
