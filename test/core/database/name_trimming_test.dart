import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pay_pilot_plus/core/data/params/bank_params.dart';
import 'package:pay_pilot_plus/core/data/params/detailed_account_params.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/banks/banks_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';

void main() {
  late AppDatabase db;
  late UsersDao usersDao;
  late BanksDao banksDao;
  late DetailedAccountsDao accountsDao;

  // پیام خطای نام تکراری از S.current ساخته می‌شود
  setUpAll(() => S.load(const Locale('en')));

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    usersDao = UsersDao(db);
    banksDao = BanksDao(db);
    accountsDao = DetailedAccountsDao(db);
  });

  tearDown(() => db.close());

  UserParams user(String name, {int? id}) => UserParams(
    id: id,
    name: name,
    description: null,
    profileImage: null,
    isActive: true,
    telegramID: null,
    instagramID: null,
    phone: null,
    birthday: null,
    openingBalance: null,
    role: UserAccountRole.staff,
  );

  BankParams bank(String name, {int? id}) => BankParams(
    id: id,
    name: name,
    description: null,
    number: null,
    noticeMemo: null,
    openingBalance: null,
    isActive: true,
  );

  group('users', () {
    test('insert stores the trimmed name', () async {
      final id = await usersDao.insertUser(user('  Ali  '));

      expect((await usersDao.fetchUser(id)).name, 'Ali');
    });

    test('update stores the trimmed name', () async {
      final id = await usersDao.insertUser(user('Ali'));

      await usersDao.updateUser(user('  Reza  ', id: id));

      expect((await usersDao.fetchUser(id)).name, 'Reza');
    });

    test('update rejects a name taken by another user', () async {
      await usersDao.insertUser(user('Ali'));
      final saraID = await usersDao.insertUser(user('Sara'));

      expect(
        () => usersDao.updateUser(user('Ali ', id: saraID)),
        throwsStateError,
      );
    });

    test('update keeps the same name for the same user', () async {
      final id = await usersDao.insertUser(user('Ali'));

      await usersDao.updateUser(user(' Ali ', id: id));

      expect((await usersDao.fetchUser(id)).name, 'Ali');
    });
  });

  group('banks', () {
    Future<String> bankName(int id) async {
      final row = await (db.select(
        db.banks,
      )..where((t) => t.id.equals(id))).getSingle();
      return row.name;
    }

    test('update stores the trimmed name', () async {
      final id = await banksDao.insertBank(bank('Melli'));

      await banksDao.updateBank(bank('  Pasargad  ', id: id));

      expect(await bankName(id), 'Pasargad');
    });

    test('update rejects a name taken by another bank', () async {
      await banksDao.insertBank(bank('Melli'));
      final otherID = await banksDao.insertBank(bank('Pasargad'));

      expect(
        () => banksDao.updateBank(bank(' Melli', id: otherID)),
        throwsStateError,
      );
    });
  });

  group('detailed accounts', () {
    test('update stores the trimmed name', () async {
      final userID = await usersDao.insertUser(user('Ali'));
      final account = await accountsDao.insertAccount(
        DetailedAccountParams(
          id: null,
          attachmentID: userID,
          name: 'Ali',
          type: DetailedAccountType.user,
        ),
      );

      await accountsDao.updateAccount(
        DetailedAccountParams(
          id: account.id,
          attachmentID: userID,
          name: '  Reza  ',
          type: DetailedAccountType.user,
        ),
      );

      expect((await accountsDao.fetchAccount(account.id)).name, 'Reza');
    });
  });
}
