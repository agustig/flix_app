extension StringExtension on String {
  String currencyAmountExtractor({int decimalDigits = 0}) => decimalDigits == 0
      ? replaceAll(RegExp('[^0-9]'), '')
      : replaceAll(RegExp('[^0-9.]'), '');
}
