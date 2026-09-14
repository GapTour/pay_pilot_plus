part of '../../database/app_database.dart';

enum GeneralAccountType {
  cashAndBank('11', AccountGroupType.assets, 'نقد و بانک'),
  accountsReceivable('12', AccountGroupType.assets, 'حساب‌های دریافتنی'),
  accountsPayable('21', AccountGroupType.liabilities, 'حساب‌های پرداختنی'),
  ownerEquity('31', AccountGroupType.equity, 'حقوق صاحبان سهام'),
  eventRevenueGroup('41', AccountGroupType.revenues, 'درآمد حاصل از ایونت‌ها'),
  contraRevenue('42', AccountGroupType.revenues, 'کاهنده درآمد'),
  eventExpenses('51', AccountGroupType.expenses, 'هزینه‌های مستقیم ایونت‌ها'),
  otherExpense('52', AccountGroupType.expenses, 'هزینه‌های عمومی و اداری');

  final String prefix;
  final AccountGroupType accountGroupType;
  final String title;

  const GeneralAccountType(this.prefix, this.accountGroupType, this.title);

  String get completeCode => '${accountGroupType.prefix}$prefix';

  factory GeneralAccountType.fromPrefix(String prefix) {
    return GeneralAccountType.values.firstWhere(
      (type) => type.prefix == prefix,
      orElse: () => throw ArgumentError('Invalid prefix: $prefix'),
    );
  }

  factory GeneralAccountType.fromTitle(String title) {
    return GeneralAccountType.values.firstWhere(
      (type) => type.title == title,
      orElse: () => throw ArgumentError('Invalid title: $title'),
    );
  }
}
