part of '../../database/app_database.dart';

enum SubsidiaryAccountType {
  cash('0111', GeneralAccountType.cashAndBank, 'صندوق‌ها'),
  bank('0112', GeneralAccountType.cashAndBank, 'بانک‌ها'),
  guestReceivables(
    '0121',
    GeneralAccountType.accountsReceivable,
    'حساب‌های معین مهمانان (بدهکاران)',
  ),
  otherReceivables(
    '0122',
    GeneralAccountType.accountsReceivable,
    'حساب‌های معین سایر (بدهکاران)',
  ),
  accountsPayable(
    '0211',
    GeneralAccountType.accountsPayable,
    'حساب‌های معین بستانکاران',
  ),
  taxPayable(
    '0212',
    GeneralAccountType.accountsPayable,
    'حساب‌های معین مالیات پرداختنی',
  ),
  otherPayables(
    '0213',
    GeneralAccountType.accountsPayable,
    'حساب‌های معین سایر (بستانکاران)',
  ),
  partnerEquity(
    '0311',
    GeneralAccountType.ownerEquity,
    'حساب‌های معین اعضا و شرکا',
  ),
  eventRevenue(
    '0411',
    GeneralAccountType.eventRevenueGroup,
    'درآمد مستقیم از ایونت‌ها',
  ),
  sponsorshipRevenue(
    '0412',
    GeneralAccountType.eventRevenueGroup,
    'درآمد حاصل از اسپانسرشیپ',
  ),
  otherRevenue('0413', GeneralAccountType.eventRevenueGroup, 'سایر درآمدها'),
  saleDiscounts('0421', GeneralAccountType.eventExpenses, 'تخفیفات ایونت'),
  eventExpenses('0511', GeneralAccountType.eventExpenses, 'هزینه‌های پذیرایی'),
  adsExpenses(
    '0521',
    GeneralAccountType.otherExpense,
    'هزینه‌های تبلیغات و بازاریابی',
  ),
  salaryExpense(
    '0522',
    GeneralAccountType.otherExpense,
    'هزینه‌های حقوق و دستمزد',
  ),
  otherExpense('0523', GeneralAccountType.otherExpense, 'سایر هزینه‌ها');

  final String prefix;
  final GeneralAccountType type;
  final String title;

  const SubsidiaryAccountType(this.prefix, this.type, this.title);

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
