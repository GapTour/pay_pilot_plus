import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';

/// توضیح ساده مانده عضو بدون اصطلاحات حسابداری
extension MemberBalanceText on BigInt {
  String get memberBalanceText {
    if (this == BigInt.zero) return 'تسویه شده';
    if (isNegative) return 'به گروه بدهکار است: ${(-this).addSeparator()}';
    return 'از گروه طلب دارد: ${addSeparator()}';
  }
}
