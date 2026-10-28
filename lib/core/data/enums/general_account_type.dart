part of '../../database/app_database.dart';

enum GeneralAccountType {
  cashAndBank('11', AccountGroupType.assets, 'نقد و بانک'),
  accountsReceivable('12', AccountGroupType.assets, 'حساب‌های دریافتنی'),
  prepaidExpenses('13', AccountGroupType.assets, 'پیش پرداخت هزینه ها'),
  accountsPayable('21', AccountGroupType.liabilities, 'حساب‌های پرداختنی'),
  ownerEquity('31', AccountGroupType.equity, 'حقوق صاحبان سهام'),
  openingAndClosingBalances(
    '32',
    AccountGroupType.equity,
    'تراز افتتاحیه و اختتامیه',
  ),
  eventRevenueGroup('41', AccountGroupType.revenues, 'درآمد حاصل از ایونت‌ها'),
  contraRevenue('42', AccountGroupType.revenues, 'کاهنده درآمد'),
  eventExpenses('51', AccountGroupType.expenses, 'هزینه‌های مستقیم ایونت‌ها'),
  otherExpense('52', AccountGroupType.expenses, 'هزینه‌های عمومی و اداری');

  final String prefix;
  final AccountGroupType accountGroupType;
  final String title;

  const GeneralAccountType(this.prefix, this.accountGroupType, this.title);

  /// عنوان قابل ترجمه برای نمایش در رابط کاربری؛ `title` ثابت می‌ماند
  /// چون برای سریال‌سازی و نام حساب‌های ذخیره‌شده استفاده می‌شود.
  String get localizedTitle => switch (this) {
    cashAndBank => S.current.generalAccount_cashAndBank,
    accountsReceivable => S.current.generalAccount_accountsReceivable,
    prepaidExpenses => S.current.generalAccount_prepaidExpenses,
    accountsPayable => S.current.generalAccount_accountsPayable,
    ownerEquity => S.current.generalAccount_ownerEquity,
    openingAndClosingBalances =>
      S.current.generalAccount_openingAndClosingBalances,
    eventRevenueGroup => S.current.generalAccount_eventRevenueGroup,
    contraRevenue => S.current.generalAccount_contraRevenue,
    eventExpenses => S.current.generalAccount_eventExpenses,
    otherExpense => S.current.generalAccount_otherExpense,
  };

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
