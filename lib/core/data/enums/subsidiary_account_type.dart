part of '../../database/app_database.dart';

enum SubsidiaryAccountType {
  cash(
    '0111',
    AccountGroupType.assets,
    GeneralAccountType.cashAndBank,
    AccountingNatureType.debitNature,
    'صندوق‌ها',
  ),
  bank(
    '0112',
    AccountGroupType.assets,
    GeneralAccountType.cashAndBank,
    AccountingNatureType.debitNature,
    'بانک‌ها',
  ),
  guestReceivables(
    '0121',
    AccountGroupType.assets,
    GeneralAccountType.accountsReceivable,
    AccountingNatureType.debitNature,
    'حساب‌های معین مهمانان (بدهکاران)',
  ),
  otherReceivables(
    '0129',
    AccountGroupType.assets,
    GeneralAccountType.accountsReceivable,
    AccountingNatureType.debitNature,
    'حساب‌های معین سایر (بدهکاران)',
  ),
  accountsPayable(
    '0211',
    AccountGroupType.liabilities,
    GeneralAccountType.accountsPayable,
    AccountingNatureType.creditNature,
    'حساب‌های معین بستانکاران',
  ),
  taxPayable(
    '0212',
    AccountGroupType.liabilities,
    GeneralAccountType.accountsPayable,
    AccountingNatureType.creditNature,
    'حساب‌های معین مالیات پرداختنی',
  ),
  otherPayables(
    '0219',
    AccountGroupType.liabilities,
    GeneralAccountType.accountsPayable,
    AccountingNatureType.creditNature,
    'حساب‌های معین سایر (بستانکاران)',
  ),
  partnerEquity(
    '0311',
    AccountGroupType.equity,
    GeneralAccountType.ownerEquity,
    AccountingNatureType.creditNature,
    'حساب‌های معین اعضا و شرکا',
  ),
  openingBalance(
    '0321',
    AccountGroupType.equity,
    GeneralAccountType.openingAndClosingBalances,
    AccountingNatureType.mixedNature,
    'تراز افتتاحیه',
  ),
  closingBalance(
    '0322',
    AccountGroupType.equity,
    GeneralAccountType.openingAndClosingBalances,
    AccountingNatureType.mixedNature,
    'تراز اختتامیه',
  ),
  eventRevenue(
    '0411',
    AccountGroupType.revenues,
    GeneralAccountType.eventRevenueGroup,
    AccountingNatureType.creditNature,
    'درآمد مستقیم از ایونت‌ها',
  ),
  sponsorshipRevenue(
    '0412',
    AccountGroupType.revenues,
    GeneralAccountType.eventRevenueGroup,
    AccountingNatureType.creditNature,
    'درآمد حاصل از اسپانسرشیپ',
  ),
  otherRevenue(
    '0419',
    AccountGroupType.revenues,
    GeneralAccountType.eventRevenueGroup,
    AccountingNatureType.creditNature,
    'سایر درآمدها',
  ),
  saleDiscounts(
    '0421',
    AccountGroupType.revenues,
    GeneralAccountType.contraRevenue,
    AccountingNatureType.debitNature,
    'تخفیفات ایونت',
  ),
  entranceExpenses(
    '0511',
    AccountGroupType.expenses,
    GeneralAccountType.eventExpenses,
    AccountingNatureType.debitNature,
    'هزینه‌های ورودی',
  ),
  snacksExpenses(
    '0512',
    AccountGroupType.expenses,
    GeneralAccountType.eventExpenses,
    AccountingNatureType.debitNature,
    'هزینه‌های پذیرایی',
  ),
  salaryExpense(
    '0521',
    AccountGroupType.expenses,
    GeneralAccountType.otherExpense,
    AccountingNatureType.debitNature,
    'هزینه‌های حقوق و دستمزد',
  ),
  adsExpenses(
    '0522',
    AccountGroupType.expenses,
    GeneralAccountType.otherExpense,
    AccountingNatureType.debitNature,
    'هزینه‌های تبلیغات',
  ),
  feeExpenses(
    '0523',
    AccountGroupType.expenses,
    GeneralAccountType.otherExpense,
    AccountingNatureType.debitNature,
    'هزینه‌های کارمزد بانکی',
  ),
  otherExpenses(
    '0529',
    AccountGroupType.expenses,
    GeneralAccountType.otherExpense,
    AccountingNatureType.debitNature,
    'سایر هزینه‌ها',
  );

  final String prefix;
  final AccountGroupType accountGroupType;
  final GeneralAccountType generalAccountType;
  final AccountingNatureType accountingNatureType;
  final String title;

  const SubsidiaryAccountType(
    this.prefix,
    this.accountGroupType,
    this.generalAccountType,
    this.accountingNatureType,
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

  bool get isExpense =>
      this == .adsExpenses ||
      this == .entranceExpenses ||
      this == .snacksExpenses ||
      this == .feeExpenses ||
      this == .otherExpenses;
}
