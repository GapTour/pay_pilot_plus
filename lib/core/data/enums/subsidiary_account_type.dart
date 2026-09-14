part of '../../database/app_database.dart';

enum SubsidiaryAccountType {
  cash(
    '0111',
    AccountGroupType.assets,
    GeneralAccountType.cashAndBank,
    'صندوق‌ها',
  ),
  bank(
    '0112',
    AccountGroupType.assets,
    GeneralAccountType.cashAndBank,
    'بانک‌ها',
  ),
  guestReceivables(
    '0121',
    AccountGroupType.assets,
    GeneralAccountType.accountsReceivable,
    'حساب‌های معین مهمانان (بدهکاران)',
  ),
  otherReceivables(
    '0122',
    AccountGroupType.assets,
    GeneralAccountType.accountsReceivable,
    'حساب‌های معین سایر (بدهکاران)',
  ),
  accountsPayable(
    '0211',
    AccountGroupType.liabilities,
    GeneralAccountType.accountsPayable,
    'حساب‌های معین بستانکاران',
  ),
  taxPayable(
    '0212',
    AccountGroupType.liabilities,
    GeneralAccountType.accountsPayable,
    'حساب‌های معین مالیات پرداختنی',
  ),
  otherPayables(
    '0213',
    AccountGroupType.liabilities,
    GeneralAccountType.accountsPayable,
    'حساب‌های معین سایر (بستانکاران)',
  ),
  partnerEquity(
    '0311',
    AccountGroupType.equity,
    GeneralAccountType.ownerEquity,
    'حساب‌های معین اعضا و شرکا',
  ),
  eventRevenue(
    '0411',
    AccountGroupType.revenues,
    GeneralAccountType.eventRevenueGroup,
    'درآمد مستقیم از ایونت‌ها',
  ),
  sponsorshipRevenue(
    '0412',
    AccountGroupType.revenues,
    GeneralAccountType.eventRevenueGroup,
    'درآمد حاصل از اسپانسرشیپ',
  ),
  otherRevenue(
    '0413',
    AccountGroupType.revenues,
    GeneralAccountType.eventRevenueGroup,
    'سایر درآمدها',
  ),
  saleDiscounts(
    '0421',
    AccountGroupType.revenues,
    GeneralAccountType.contraRevenue,
    'تخفیفات ایونت',
  ),
  eventExpenses(
    '0511',
    AccountGroupType.expenses,
    GeneralAccountType.eventExpenses,
    'هزینه‌های پذیرایی',
  ),
  adsExpenses(
    '0521',
    AccountGroupType.expenses,
    GeneralAccountType.otherExpense,
    'هزینه‌های تبلیغات و بازاریابی',
  ),
  salaryExpense(
    '0522',
    AccountGroupType.expenses,
    GeneralAccountType.otherExpense,
    'هزینه‌های حقوق و دستمزد',
  ),
  otherExpense(
    '0523',
    AccountGroupType.expenses,
    GeneralAccountType.otherExpense,
    'سایر هزینه‌ها',
  );

  final String prefix;
  final AccountGroupType accountGroupType;
  final GeneralAccountType generalAccountType;
  final String title;

  const SubsidiaryAccountType(
    this.prefix,
    this.accountGroupType,
    this.generalAccountType,
    this.title,
  );

  String get completeCode =>
      '${accountGroupType.prefix}${generalAccountType.prefix}$prefix';

  factory SubsidiaryAccountType.fromPrefix(String prefix) {
    return SubsidiaryAccountType.values.firstWhere(
      (type) => type.prefix == prefix,
      orElse: () => throw ArgumentError('Invalid prefix: $prefix'),
    );
  }

  factory SubsidiaryAccountType.fromTitle(String title) {
    return SubsidiaryAccountType.values.firstWhere(
      (type) => type.title == title,
      orElse: () => throw ArgumentError('Invalid title: $title'),
    );
  }
}
