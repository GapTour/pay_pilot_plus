import 'package:drift/drift.dart' show Table, TableInfo;
import 'package:drift/native.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';
import 'package:pay_pilot_plus/core/data/params/bank_params.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/banks/banks_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/services/accounts_chart_seeder_service.dart';
import 'package:pay_pilot_plus/features/banks/data/providers/bank_local_provider.dart';
import 'package:pay_pilot_plus/features/members/data/providers/member_local_provider.dart';

/// اگر یکی از مراحل ثبت/ویرایش شکست بخورد، هیچ‌کدام از مراحل قبلی نباید
/// در دیتابیس باقی بماند. مبلغ افتتاحیه منفی باعث خطای CHECK در ردیف سند
/// می‌شود، یعنی بعد از ثبت شخص و حساب تفصیلی.
void main() {
  late AppDatabase db;
  late MemberLocalProvider members;
  late BankLocalProvider banks;

  setUpAll(() => S.load(const Locale('en')));

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await AccountsChartSeederService(db).seedDefaultChartOfAccounts();

    final subsidiaryDao = SubsidiaryAccountsDao(db);
    final accountsDao = DetailedAccountsDao(db);
    final journalsDao = JournalsDao(db);

    members = MemberLocalProvider(
      UsersDao(db),
      subsidiaryDao,
      accountsDao,
      journalsDao,
    );
    banks = BankLocalProvider(
      BanksDao(db),
      subsidiaryDao,
      accountsDao,
      journalsDao,
    );
  });

  tearDown(() => db.close());

  UserParams member(String name, {int? id, int? opening}) => UserParams(
    id: id,
    name: name,
    description: null,
    profileImage: null,
    isActive: true,
    telegramID: null,
    instagramID: null,
    phone: null,
    birthday: null,
    openingBalance: opening == null ? null : BigInt.from(opening),
    role: UserAccountRole.staff,
  );

  BankParams bank(String name, {int? opening}) => BankParams(
    id: null,
    name: name,
    description: null,
    number: null,
    noticeMemo: null,
    openingBalance: opening == null ? null : BigInt.from(opening),
    isActive: true,
  );

  Future<int> count(TableInfo<Table, dynamic> table) async {
    final rows = await db.select(table).get();
    return rows.length;
  }

  test('member insert succeeds with an opening balance', () async {
    await members.insertMember(member('Ali', opening: 100));

    final all = await members.fetchAllMembers();
    expect(all.single.name, 'Ali');
    expect(all.single.openingBalance, BigInt.from(100));
  });

  test('failed member insert leaves no user, account or journal', () async {
    await expectLater(
      members.insertMember(member('Ali', opening: -5)),
      throwsA(anything),
    );

    expect(await count(db.users), 0);
    expect(await count(db.detailedAccounts), 0);
    expect(await count(db.journalHeaders), 0);
    expect(await count(db.journalLines), 0);
  });

  test('failed member update keeps the old name and opening balance', () async {
    final created = await members.insertMember(member('Ali', opening: 100));

    await expectLater(
      members.updateMember(member('Reza', id: created.id, opening: -5)),
      throwsA(anything),
    );

    final all = await members.fetchAllMembers();
    expect(all.single.name, 'Ali');
    expect(all.single.detailedAccountInfo.name, 'Ali');
    expect(all.single.openingBalance, BigInt.from(100));
  });

  test('failed bank insert leaves no bank or account', () async {
    await expectLater(
      banks.insertBank(bank('Melli', opening: -5)),
      throwsA(anything),
    );

    expect(await count(db.banks), 0);
    expect(await count(db.detailedAccounts), 0);
  });

  test('name can be reused after a failed insert', () async {
    await expectLater(
      members.insertMember(member('Ali', opening: -5)),
      throwsA(anything),
    );

    await members.insertMember(member('Ali'));

    expect((await members.fetchAllMembers()).single.name, 'Ali');
  });
}
