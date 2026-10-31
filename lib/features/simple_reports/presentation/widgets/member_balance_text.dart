import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';

/// توضیح ساده مانده عضو بدون اصطلاحات حسابداری
extension MemberBalanceText on BigInt {
  String get memberBalanceText {
    if (this == BigInt.zero) return S.current.balance_settled;
    if (isNegative) return S.current.balance_owesGroup((-this).addSeparator());
    return S.current.balance_groupOwes(addSeparator());
  }
}
