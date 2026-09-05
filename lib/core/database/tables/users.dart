part of '../../database/app_database.dart';

enum UserAccountRole {
  guest('مهمان'),
  landlord('میزبان'),
  staff('عضو تیم');

  final String title;

  const UserAccountRole(this.title);

  factory UserAccountRole.fromTitle(String name) {
    return UserAccountRole.values.firstWhere(
      (role) => role.name == name,
      orElse: () => throw ArgumentError('Invalid title: $name'),
    );
  }
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get profileImage => text().nullable()();
  TextColumn get telegramId => text().nullable()();
  TextColumn get instagramId => text().nullable()();
  DateTimeColumn get birthday => dateTime().nullable()();
  TextColumn get role => textEnum<UserAccountRole>()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDate)();
}
