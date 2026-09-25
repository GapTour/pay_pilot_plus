import 'package:intl/intl.dart';

extension ManageSeparatorExtension on BigInt? {
  String addSeparator() {
    final BigInt value = this ?? BigInt.zero;

    final String formattedText = NumberFormat('#,###').format(value.toInt());

    return formattedText;
  }

  String addSeparatorWithSymbol() {
    final BigInt value = this ?? BigInt.zero;

    String formattedText = NumberFormat('#,###').format(value.toInt());
    if (value > BigInt.zero) formattedText = '$formattedText  +';
    if (value < BigInt.zero) {
      formattedText = formattedText.replaceAll('-', '').trim();
      formattedText = '$formattedText  -';
    }

    return formattedText;
  }
}
