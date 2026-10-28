import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pay_pilot_plus/core/data/params/journal_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/utils/services/accounts_chart_seeder_service.dart';
import 'package:pay_pilot_plus/features/simple_reports/data/providers/simple_report_local_provider.dart';

void main() {
  late AppDatabase db;
  late JournalsDao journalsDao;
  late SimpleReportLocalProvider provider;

  late int memberA;
  late int memberB;
  late int host;
  late int event1;
  late int event2;

  Future<int> insertDetailed(
    String code,
    String name,
    DetailedAccountType type,
  ) {
    return db
        .into(db.detailedAccounts)
        .insert(
          DetailedAccountsCompanion.insert(code: code, name: name, type: type),
        );
  }

  Future<int> insertPerson(
    String code,
    String name,
    UserAccountRole role,
  ) async {
    final userID = await db
        .into(db.users)
        .insert(UsersCompanion.insert(name: name, role: role));

    return db
        .into(db.detailedAccounts)
        .insert(
          DetailedAccountsCompanion.insert(
            code: code,
            name: name,
            type: DetailedAccountType.user,
            userID: Value(userID),
          ),
        );
  }

  JournalLinesCompanion line({
    required int subsidiaryID,
    required String series,
    int? first,
    int? second,
    int debit = 0,
    int credit = 0,
  }) {
    return JournalLinesCompanion.insert(
      headerId: 0,
      subsidiaryId: subsidiaryID,
      firstDetailedId: Value(first),
      secondDetailedId: Value(second),
      debit: BigInt.from(debit),
      credit: BigInt.from(credit),
      series: series,
    );
  }

  Future<void> insertJournal(DateTime date, List<JournalLinesCompanion> lines) {
    return journalsDao.insertJournal(
      JournalParams(
        date: date,
        lines: lines,
        noticeMemo: null,
        hasSource: true,
      ),
    );
  }

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await AccountsChartSeederService(db).seedDefaultChartOfAccounts();

    journalsDao = JournalsDao(db);
    final subsidiaryDao = SubsidiaryAccountsDao(db);
    provider = SimpleReportLocalProvider(
      journalsDao,
      subsidiaryDao,
      DetailedAccountsDao(db),
    );

    final subs = await subsidiaryDao.fetchSubsidiaryAccounts();
    final payable = subs[SubsidiaryAccountType.accountsPayable]!.id;
    final salary = subs[SubsidiaryAccountType.salaryExpense]!.id;
    final bank = subs[SubsidiaryAccountType.bank]!.id;

    memberA = await insertPerson('100001', 'Ali', UserAccountRole.staff);
    memberB = await insertPerson('100002', 'Sara', UserAccountRole.staff);
    host = await insertPerson('100003', 'Reza', UserAccountRole.host);
    event1 = await insertDetailed(
      '200001',
      'Event 1',
      DetailedAccountType.event,
    );
    event2 = await insertDetailed(
      '200002',
      'Event 2',
      DetailedAccountType.event,
    );
    final bankAccount = await insertDetailed(
      '300001',
      'Bank',
      DetailedAccountType.bank,
    );

    // حقوق رویداد ۱: علی ۱۰۰، سارا ۲۰۰، میزبان ۴۰ (نباید در گزارش بیاید)
    await insertJournal(DateTime(2026, 1, 10), [
      line(subsidiaryID: salary, series: 's1', first: event1, debit: 340),
      line(
        subsidiaryID: payable,
        series: 's1',
        first: host,
        second: event1,
        credit: 40,
      ),
      line(
        subsidiaryID: payable,
        series: 's1',
        first: memberA,
        second: event1,
        credit: 100,
      ),
      line(
        subsidiaryID: payable,
        series: 's1',
        first: memberB,
        second: event1,
        credit: 200,
      ),
    ]);

    // حقوق رویداد ۲: علی ۵۰
    await insertJournal(DateTime(2026, 2, 10), [
      line(subsidiaryID: salary, series: 's2', first: event2, debit: 50),
      line(
        subsidiaryID: payable,
        series: 's2',
        first: memberA,
        second: event2,
        credit: 50,
      ),
    ]);

    // هزینه‌ای که علی پرداخته (حقوق نیست ولی در مانده اثر دارد): ۷۰
    await insertJournal(DateTime(2026, 2, 15), [
      line(subsidiaryID: bank, series: 'x1', first: bankAccount, debit: 70),
      line(subsidiaryID: payable, series: 'x1', first: memberA, credit: 70),
    ]);

    // پرداخت به علی: ۱۲۰
    await insertJournal(DateTime(2026, 2, 20), [
      line(subsidiaryID: payable, series: 'p1', first: memberA, debit: 120),
      line(subsidiaryID: bank, series: 'p1', first: bankAccount, credit: 120),
    ]);
  });

  tearDown(() => db.close());

  test('fetchSalaries returns only salary lines', () async {
    final salaries = await provider.fetchSalaries();

    expect(salaries.length, 3);
    expect(salaries.map((e) => e.amount).toList(), [
      BigInt.from(100),
      BigInt.from(200),
      BigInt.from(50),
    ]);
    expect(salaries.first.eventInfo?.name, 'Event 1');
  });

  test('summaries total salaries and overall balance per member', () async {
    final summaries = await provider.fetchMemberSalarySummaries();

    expect(summaries.length, 2);

    // بیشترین حقوق اول: سارا ۲۰۰، سپس علی ۱۵۰
    expect(summaries[0].memberInfo.id, memberB);
    expect(summaries[0].totalSalary, BigInt.from(200));
    expect(summaries[0].currentBalance, BigInt.from(200));

    expect(summaries[1].memberInfo.id, memberA);
    expect(summaries[1].totalSalary, BigInt.from(150));
    expect(summaries[1].eventsCount, 2);
    // ۱۰۰ + ۵۰ + ۷۰ − ۱۲۰
    expect(summaries[1].currentBalance, BigInt.from(100));
  });

  test('filters by date range, event and member', () async {
    final byDate = await provider.fetchSalaries(from: DateTime(2026, 2, 1));
    expect(byDate.map((e) => e.amount), [BigInt.from(50)]);

    final byEvent = await provider.fetchMemberSalarySummaries(
      eventAccountID: event1,
    );
    expect(byEvent.map((e) => e.totalSalary), [
      BigInt.from(200),
      BigInt.from(100),
    ]);

    final byMember = await provider.fetchSalaries(memberAccountID: memberB);
    expect(byMember.map((e) => e.amount), [BigInt.from(200)]);
  });

  test('summary survives json round trip', () async {
    final summary = (await provider.fetchMemberSalarySummaries()).last;
    final decoded = summary.toJson();

    expect(decoded, contains('"totalSalary":"150"'));
    expect(decoded, contains('"currentBalance":"100"'));
  });

  test('member and event lists for filters', () async {
    final members = await provider.fetchMemberAccounts();
    final events = await provider.fetchEventAccounts();

    expect(members.map((e) => e.name), ['Ali', 'Sara']);
    expect(events.map((e) => e.name), ['Event 1', 'Event 2']);
  });

  test('hosts are excluded from salaries and member list', () async {
    final salaries = await provider.fetchSalaries();
    final summaries = await provider.fetchMemberSalarySummaries();
    final members = await provider.fetchMemberAccounts();

    expect(salaries.any((e) => e.memberInfo.id == host), isFalse);
    expect(summaries.any((e) => e.memberInfo.id == host), isFalse);
    expect(members.any((e) => e.id == host), isFalse);
  });
}
