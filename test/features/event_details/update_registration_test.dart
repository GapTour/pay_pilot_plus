import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';
import 'package:pay_pilot_plus/core/data/params/bank_params.dart';
import 'package:pay_pilot_plus/core/data/params/detailed_account_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_registration_params.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/banks/banks_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_registrations/event_registrations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/services/accounts_chart_seeder_service.dart';
import 'package:pay_pilot_plus/features/banks/data/providers/bank_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_registrations_local_provider.dart';
import 'package:pay_pilot_plus/features/guests/data/providers/guest_local_provider.dart';
import 'package:pay_pilot_plus/features/members/data/providers/member_local_provider.dart';

/// ویرایش ثبت‌نام باید ردیف‌های همان سری‌ها را داخل همان سندها بازنویسی کند.
void main() {
  late AppDatabase db;
  late EventRegistrationsLocalProvider registrations;
  late Map<SubsidiaryAccountType, int> sub;
  late ({int id, String name}) event;
  late ({int id, String name}) guestA;
  late ({int id, String name}) guestB;
  late ({int id, String name}) staff;
  late ({int id, String name}) bank;

  final day1 = DateTime(2026, 1, 1);
  final day2 = DateTime(2026, 2, 2);

  setUpAll(() => S.load(const Locale('en')));

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await AccountsChartSeederService(db).seedDefaultChartOfAccounts();

    final subsidiaryDao = SubsidiaryAccountsDao(db);
    final accountsDao = DetailedAccountsDao(db);
    final journalsDao = JournalsDao(db);
    final usersDao = UsersDao(db);

    registrations = EventRegistrationsLocalProvider(
      journalsDao,
      subsidiaryDao,
      accountsDao,
      EventRegistrationsDao(db),
    );

    sub = {
      for (final s in await db.select(db.subsidiaryAccounts).get())
        s.type: s.id,
    };

    UserParams person(String name, UserAccountRole role) => UserParams(
      id: null,
      name: name,
      description: null,
      profileImage: null,
      isActive: true,
      telegramID: null,
      instagramID: null,
      phone: null,
      birthday: null,
      openingBalance: null,
      role: role,
    );

    final guests = GuestLocalProvider(
      usersDao,
      subsidiaryDao,
      accountsDao,
      journalsDao,
    );
    final a = await guests.insertGuest(person('Arash', .guest));
    final b = await guests.insertGuest(person('Bita', .guest));
    guestA = (id: a.id, name: a.name);
    guestB = (id: b.id, name: b.name);

    final s = await MemberLocalProvider(
      usersDao,
      subsidiaryDao,
      accountsDao,
      journalsDao,
    ).insertMember(person('Mansoure', .staff));
    staff = (id: s.id, name: s.name);

    final bk =
        await BankLocalProvider(
          BanksDao(db),
          subsidiaryDao,
          accountsDao,
          journalsDao,
        ).insertBank(
          BankParams(
            id: null,
            name: 'Blu',
            description: null,
            number: null,
            noticeMemo: null,
            openingBalance: null,
            isActive: true,
          ),
        );
    bank = (id: bk.id, name: bk.name);

    final teamID = await db
        .into(db.teams)
        .insert(TeamsCompanion.insert(title: 'Team'));
    final eventID = await db
        .into(db.events)
        .insert(
          EventsCompanion.insert(
            title: 'Night',
            teamID: teamID,
            userID: staff.id,
            entranceFee: BigInt.zero,
            snacksFee: BigInt.zero,
            date: Value(day1),
          ),
        );
    await accountsDao.insertAccount(
      DetailedAccountParams(
        id: null,
        attachmentID: eventID,
        name: 'Night',
        type: .event,
      ),
    );
    event = (id: eventID, name: 'Night');
  });

  tearDown(() => db.close());

  EventRegistrationParams params(
    List<({int id, String name})> persons, {
    int? id,
    int gross = 300,
    int discount = 0,
    DateTime? date,
    ({int id, String name})? bankInfo,
    ({int id, String name})? assignmentInfo,
    SnacksFeeAssignmentStatus? snacksStatus,
    ({int id, String name})? snacksInfo,
  }) => EventRegistrationParams(
    id: id,
    eventInfo: event,
    bankInfo: bankInfo,
    assignmentInfo: assignmentInfo,
    snacksAssignmentInfo: snacksInfo,
    guestsInfo: persons,
    snacksAssignmentStatus: snacksStatus,
    status: .confirmed,
    grossAmount: BigInt.from(gross),
    discountAmount: BigInt.from(discount),
    netAmount: BigInt.from(gross - discount),
    registeredAt: date ?? day1,
    description: null,
  );

  Future<int> registrationID(int userID) async => (await (db.select(
    db.eventRegistrations,
  )..where((t) => t.userID.equals(userID))).getSingle()).id;

  Future<List<JournalLine>> allLines() => db.select(db.journalLines).get();

  Future<int> accountOf(int userID) async => (await (db.select(
    db.detailedAccounts,
  )..where((t) => t.userID.equals(userID))).getSingle()).id;

  /// ردیف‌هایی که به یک شخص مربوط‌اند (تفصیلی اول یا دوم)
  Future<List<JournalLine>> linesOf(int userID) async {
    final account = await accountOf(userID);
    final series = (await allLines())
        .where(
          (l) => l.firstDetailedId == account || l.secondDetailedId == account,
        )
        .map((l) => l.series)
        .toSet();
    return (await allLines()).where((l) => series.contains(l.series)).toList();
  }

  String snapshot(List<JournalLine> lines) => lines
      .map(
        (l) =>
            '${l.headerId}|${l.subsidiaryId}|${l.firstDetailedId}|'
            '${l.secondDetailedId}|${l.debit}|${l.credit}|${l.series}|${l.date}',
      )
      .join('\n');

  test('amount change keeps series and entry numbers', () async {
    await registrations.registerGuests(params([guestA], bankInfo: bank));
    final before = await linesOf(guestA.id);
    final headersBefore = await db.select(db.journalHeaders).get();

    await registrations.updateRegistration(
      params(
        [guestA],
        id: await registrationID(guestA.id),
        discount: 50,
        bankInfo: bank,
      ),
    );

    final after = await linesOf(guestA.id);
    expect(
      after.map((l) => l.series).toSet(),
      before.map((l) => l.series).toSet(),
    );
    expect(
      (await db.select(db.journalHeaders).get()).map((h) => h.entryNumber),
      headersBefore.map((h) => h.entryNumber),
    );
    BigInt debitOn(SubsidiaryAccountType t) => after
        .where((l) => l.subsidiaryId == sub[t])
        .fold(BigInt.zero, (s, l) => s + l.debit);
    expect(debitOn(.guestReceivables), BigInt.from(250));
    expect(debitOn(.saleDiscounts), BigInt.from(50));
    expect(debitOn(.bank), BigInt.from(250));

    final row = await (db.select(
      db.eventRegistrations,
    )..where((t) => t.userID.equals(guestA.id))).getSingle();
    expect(row.netAmount, BigInt.from(250));
  });

  test(
    'bank to staff collection rewrites the payment series in place',
    () async {
      await registrations.registerGuests(params([guestA], bankInfo: bank));
      final paySeries = (await allLines())
          .firstWhere((l) => l.subsidiaryId == sub[SubsidiaryAccountType.bank])
          .series;

      await registrations.updateRegistration(
        params(
          [guestA],
          id: await registrationID(guestA.id),
          assignmentInfo: staff,
        ),
      );

      final payment = (await allLines()).where((l) => l.series == paySeries);
      expect(
        payment.any((l) => l.subsidiaryId == sub[SubsidiaryAccountType.bank]),
        isFalse,
      );
      final payable = payment.singleWhere(
        (l) => l.subsidiaryId == sub[SubsidiaryAccountType.accountsPayable],
      );
      expect(payable.firstDetailedId, await accountOf(staff.id));
      expect(payable.debit, BigInt.from(300));
    },
  );

  test('shared header leaves the other guest unchanged', () async {
    await registrations.registerGuests(
      params([guestA, guestB], bankInfo: bank),
    );
    final bBefore = snapshot(await linesOf(guestB.id));

    await registrations.updateRegistration(
      params(
        [guestA],
        id: await registrationID(guestA.id),
        gross: 500,
        bankInfo: bank,
      ),
    );

    expect(snapshot(await linesOf(guestB.id)), bBefore);
  });

  test('guest made free removes the payment series', () async {
    await registrations.registerGuests(params([guestA], bankInfo: bank));

    await registrations.updateRegistration(
      params([guestA], id: await registrationID(guestA.id), discount: 300),
    );

    final lines = await linesOf(guestA.id);
    expect(
      lines.where(
        (l) =>
            l.subsidiaryId == sub[SubsidiaryAccountType.bank] ||
            l.subsidiaryId == sub[SubsidiaryAccountType.guestReceivables],
      ),
      isEmpty,
    );
    expect(
      lines
          .singleWhere(
            (l) => l.subsidiaryId == sub[SubsidiaryAccountType.eventRevenue],
          )
          .credit,
      BigInt.from(300),
    );
    expect(
      lines
          .singleWhere(
            (l) => l.subsidiaryId == sub[SubsidiaryAccountType.saleDiscounts],
          )
          .debit,
      BigInt.from(300),
    );
  });

  test('staff from net 0 to net > 0 posts a new journal', () async {
    await registrations.registerMembers(params([staff], gross: 0));
    expect(await allLines(), isEmpty);

    await registrations.updateRegistration(
      params([staff], id: await registrationID(staff.id), gross: 100),
    );

    final payable = (await allLines()).singleWhere(
      (l) => l.subsidiaryId == sub[SubsidiaryAccountType.accountsPayable],
    );
    expect(payable.firstDetailedId, await accountOf(staff.id));
    expect(payable.debit, BigInt.from(100));
  });

  test(
    'date change in a shared header keeps header and other guest dates',
    () async {
      await registrations.registerGuests(
        params([guestA, guestB], bankInfo: bank),
      );

      await registrations.updateRegistration(
        params(
          [guestA],
          id: await registrationID(guestA.id),
          date: day2,
          bankInfo: bank,
        ),
      );

      expect((await linesOf(guestA.id)).every((l) => l.date == day2), isTrue);
      expect((await linesOf(guestB.id)).every((l) => l.date == day1), isTrue);
      expect(
        (await db.select(db.journalHeaders).get()).every(
          (h) => h.entryDate == day1,
        ),
        isTrue,
      );
    },
  );

  test('failure rolls back the row and the journals', () async {
    await registrations.registerGuests(params([guestA], bankInfo: bank));
    final before = snapshot(await allLines());

    // شخص ناموجود در تسویه: بعد از بازنویسی سری ثبت‌نام خطا می‌دهد
    await expectLater(
      registrations.updateRegistration(
        params(
          [guestA],
          id: await registrationID(guestA.id),
          gross: 999,
          assignmentInfo: (id: 9999, name: 'Ghost'),
        ),
      ),
      throwsA(anything),
    );

    expect(snapshot(await allLines()), before);
    final row = await (db.select(
      db.eventRegistrations,
    )..where((t) => t.userID.equals(guestA.id))).getSingle();
    expect(row.grossAmount, BigInt.from(300));
  });

  test('registrations carry their settlement counterparty', () async {
    final fundID = await db
        .into(db.funds)
        .insert(
          FundsCompanion.insert(title: 'Reserve', openingBalance: BigInt.zero),
        );

    await registrations.registerGuests(params([guestA], bankInfo: bank));
    await registrations.registerGuests(params([guestB], assignmentInfo: staff));
    await registrations.registerMembers(params([staff], gross: 100));

    final freeGuest =
        await GuestLocalProvider(
          UsersDao(db),
          SubsidiaryAccountsDao(db),
          DetailedAccountsDao(db),
          JournalsDao(db),
        ).insertGuest(
          UserParams(
            id: null,
            name: 'Free',
            description: null,
            profileImage: null,
            isActive: true,
            telegramID: null,
            instagramID: null,
            phone: null,
            birthday: null,
            openingBalance: null,
            role: .guest,
          ),
        );
    final all = await registrations.registerGuests(
      params(
        [(id: freeGuest.id, name: freeGuest.name)],
        discount: 300,
        snacksStatus: .assignmentToFund,
        snacksInfo: (id: fundID, name: 'Reserve'),
      ),
    );

    final byName = {for (final r in all) r.user.name: r};
    expect(byName['Arash']!.bankInfo, (id: bank.id, name: 'Blu'));
    expect(byName['Arash']!.assignmentInfo, isNull);
    expect(byName['Bita']!.assignmentInfo, (id: staff.id, name: 'Mansoure'));
    expect(byName['Bita']!.bankInfo, isNull);
    expect(
      byName['Free']!.snacksAssignmentStatus,
      SnacksFeeAssignmentStatus.assignmentToFund,
    );
    expect(byName['Free']!.snacksAssignmentInfo, (id: fundID, name: 'Reserve'));
    expect(byName['Free']!.bankInfo, isNull);
    expect(byName['Mansoure']!.bankInfo, isNull);
    expect(byName['Mansoure']!.assignmentInfo, isNull);
    expect(byName['Mansoure']!.user.role, UserAccountRole.staff);
  });
}
