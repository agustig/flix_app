import 'package:intl/intl.dart';

extension IntExtension on int {
  String toUSDCurrencyFormat() =>
      NumberFormat.currency(locale: 'en_US', symbol: 'USD ', decimalDigits: 2)
          .format(this);
}
