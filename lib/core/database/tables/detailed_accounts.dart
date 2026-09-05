part of '../../database/app_database.dart';

enum DetailedAccountType {
  event,
  user,
  bank,
  cash,
  other;

  bool get isEvent => this == DetailedAccountType.event;
  bool get isUser => this == DetailedAccountType.user;
  bool get isBank => this == DetailedAccountType.bank;
  bool get isCash => this == DetailedAccountType.cash;
  bool get isOther => this == DetailedAccountType.other;
}

/// 4. حساب‌های تفصیلی شناور (اشخاص، پروژه‌ها، مراکز هزینه)
@DataClassName('DetailedAccount')
class DetailedAccounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().withLength(min: 4, max: 15).unique()();
  TextColumn get name => text().withLength(min: 2, max: 200)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get type => textEnum<DetailedAccountType>()();
  IntColumn get userID => integer().nullable().references(Users, #id)();
  IntColumn get eventID => integer().nullable().references(Events, #id)();
  IntColumn get bankID => integer().nullable().references(Banks, #id)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {eventID, userID, bankID},
  ];
}
