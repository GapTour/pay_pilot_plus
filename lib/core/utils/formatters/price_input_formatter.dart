import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_string_to_extension.dart';

class PriceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Keep only digits (Persian or Western)
    String cleaned = newValue.text.replaceAll(RegExp(r'[^\d۰-۹]'), '');

    // Convert Persian digits → Western digits
    cleaned = cleaned.parseStringToStringWithWesternDigits;

    // Parse number
    final value = double.tryParse(cleaned) ?? 0;

    // Format with commas
    final formatted = NumberFormat('#,###').format(value);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
