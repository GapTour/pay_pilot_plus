import 'package:intl/intl.dart';

extension ManageSeparatorExtension on BigInt? {
  String addSeparator() {
    final BigInt value = this ?? BigInt.zero;

    final String formattedText = NumberFormat('#,###').format(value.toInt());

    return formattedText;
  }

  String addSeparatorWithSymbol() {
    BigInt value = this ?? BigInt.zero;
    if (value == BigInt.zero) return 'بی حساب';
    bool isNegative = value.isNegative;
    if (isNegative) value = value * BigInt.from(-1);

    String formattedText = NumberFormat('#,###').format(value.toInt());
    if (!isNegative) formattedText = '$formattedText  +';
    if (isNegative) formattedText = '$formattedText  -';

    return formattedText;
  }
}
