import 'package:intl/intl.dart';

extension ManageSeparatorExtension on num? {
  String addSeparator() {
    final num value = this ?? 0;
    final num roundedValue = num.tryParse(value.toStringAsFixed(0)) ?? 0;

    final String formattedText = NumberFormat('#,###').format(roundedValue);

    return formattedText;
  }
}
