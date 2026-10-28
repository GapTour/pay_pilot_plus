import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [Users, DetailedAccounts])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  UsersDao(super.db);

  Future<int> insertUser(UserParams params) async {
    final name = params.name.trim();
    final existingName = await (select(
      users,
    )..where((tbl) => tbl.name.equals(name))).getSingleOrNull();

    if (existingName != null) {
      return throw StateError(S.current.error_duplicateName(name));
    }

    return await transaction(() async {
      return await into(users).insert(
        UsersCompanion(
          name: Value(name),
          phoneNumber: Value(params.phone),
          telegramId: Value(params.telegramID),
          instagramId: Value(params.instagramID),
          description: Value(params.description),
          birthday: Value(params.birthday),
          profileImage: Value(params.profileImage),
          role: Value(params.role),
        ),
      );
    });
  }

  Future<List<({User user, DetailedAccount account})>> fetchAllUser() async {
    final query = select(detailedAccounts)
        .join([innerJoin(users, users.id.equalsExp(detailedAccounts.userID))]);

    final rows = await query.get();

    return rows.map((row) {
      final user = row.readTable(users);
      final account = row.readTable(detailedAccounts);

      return (user: user, account: account);
    }).toList();
  }

  Future<List<({User user, DetailedAccount account})>>
  fetchAllActiveUsers() async {
    final query = select(detailedAccounts).join([
      innerJoin(
        users,
        users.id.equalsExp(detailedAccounts.userID) &
            users.isActive.equals(true),
      ),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      final user = row.readTable(users);
      final account = row.readTable(detailedAccounts);

      return (user: user, account: account);
    }).toList();
  }

  Future<List<({User user, DetailedAccount account})>>
  fetchAllActiveStaffs() async {
    final query = select(detailedAccounts).join([
      innerJoin(
        users,
        users.id.equalsExp(detailedAccounts.userID) &
            users.role.equals(UserAccountRole.staff.name) &
            users.isActive.equals(true),
      ),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      final user = row.readTable(users);
      final account = row.readTable(detailedAccounts);

      return (user: user, account: account);
    }).toList();
  }

  Future<List<({User user, DetailedAccount account})>>
  fetchAllActiveGuests() async {
    final query = select(detailedAccounts).join([
      innerJoin(
        users,
        users.id.equalsExp(detailedAccounts.userID) &
            users.role.equals(UserAccountRole.guest.name) &
            users.isActive.equals(true),
      ),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      final user = row.readTable(users);
      final account = row.readTable(detailedAccounts);

      return (user: user, account: account);
    }).toList();
  }

  Future<List<({User user, DetailedAccount account})>>
  fetchAllActiveLandlords() async {
    final query = select(detailedAccounts).join([
      innerJoin(
        users,
        users.id.equalsExp(detailedAccounts.userID) &
            users.role.equals(UserAccountRole.host.name) &
            users.isActive.equals(true),
      ),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      final user = row.readTable(users);
      final account = row.readTable(detailedAccounts);

      return (user: user, account: account);
    }).toList();
  }

  Future<User> fetchUser(int id) async {
    return await (select(users)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<int> updateUser(UserParams params) async {
    final name = params.name.trim();
    final existingName = await (select(
      users,
    )..where((tbl) => tbl.name.equals(name))).getSingleOrNull();

    if (existingName != null && existingName.id != params.id) {
      return throw StateError(S.current.error_duplicateName(name));
    }

    return await transaction(() async {
      return await (update(
        users,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        UsersCompanion(
          name: Value(name),
          phoneNumber: Value(params.phone),
          telegramId: Value(params.telegramID),
          instagramId: Value(params.instagramID),
          description: Value(params.description),
          birthday: Value(params.birthday),
          profileImage: Value(params.profileImage),
          isActive: Value(params.isActive),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<int> archiveUser(int id) async {
    return await transaction(() async {
      return await (update(users)..where((tbl) => tbl.id.equals(id))).write(
        UsersCompanion(
          isActive: Value(false),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }
}
