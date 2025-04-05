import 'package:intl/intl.dart';

String formatWithThousandsSeparator(double number) {
  final formatter = NumberFormat.decimalPattern();
  return formatter.format(number);
}

/// Removes formatting (commas) to store plain number
String removeThousandsSeperatorFormatting(String formattedNumber) {
  return formattedNumber.replaceAll(',', '');
}
