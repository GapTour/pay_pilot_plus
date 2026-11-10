import 'package:drift/native.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';
import 'package:pay_pilot_plus/core/data/params/journal_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/services/accounts_chart_seeder_service.dart';

/// جایگزینی ردیف‌های یک سری باید داخل همان سربرگ انجام شود و
/// به سری‌های دیگرِ همان سربرگ دست نزند.
void main() {
  late AppDatabase db;
  late JournalsDao journals;
  late int cashID;
  late int revenueID;

  final day1 = DateTime(2026, 1, 1);
  final day2 = DateTime(2026, 2, 2);

  setUpAll(() => S.load(const Locale('en')));

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await AccountsChartSeederService(db).seedDefaultChartOfAccounts();
    journals = JournalsDao(db);

    final subs = await db.select(db.subsidiaryAccounts).get();
    cashID = subs.firstWhere((s) => s.type == SubsidiaryAccountType.cash).id;
    revenueID = subs
        .firstWhere((s) => s.type == SubsidiaryAccountType.eventRevenue)
        .id;
  });

  tearDown(() => db.close());

  List<JournalLinesCompanion> pair(int amount, {String series = 'tmp'}) => [
    JournalLinesCompanion.insert(
      headerId: 0,
      subsidiaryId: cashID,
      debit: BigInt.from(amount),
      credit: BigInt.zero,
      series: series,
    ),
    JournalLinesCompanion.insert(
      headerId: 0,
      subsidiaryId: revenueID,
      debit: BigInt.zero,
      credit: BigInt.from(amount),
      series: series,
    ),
  ];

  Future<int> post(List<JournalLinesCompanion> lines) => journals.insertJournal(
    JournalParams(date: day1, lines: lines, noticeMemo: null, hasSource: true),
  );

  Future<List<JournalLine>> linesOf(String series) =>
      (db.select(db.journalLines)..where((t) => t.series.equals(series))).get();

  Future<JournalHeader?> header(int id) => (db.select(
    db.journalHeaders,
  )..where((t) => t.id.equals(id))).getSingleOrNull();

  test('shared header: other series untouched, entry number kept, '
      'header date kept', () async {
    final headerID = await post([
      ...pair(100, series: 'A'),
      ...pair(200, series: 'B'),
    ]);
    final entryNumber = (await header(headerID))!.entryNumber;

    await journals.replaceSeriesLines(
      series: 'A',
      lines: pair(150),
      date: day2,
    );

    final a = await linesOf('A');
    expect(a.map((l) => l.debit + l.credit), [
      BigInt.from(150),
      BigInt.from(150),
    ]);
    expect(a.every((l) => l.headerId == headerID && l.date == day2), isTrue);

    final b = await linesOf('B');
    expect(b.map((l) => l.debit + l.credit), [
      BigInt.from(200),
      BigInt.from(200),
    ]);
    expect(b.every((l) => l.date == day1), isTrue);

    final h = (await header(headerID))!;
    expect(h.entryNumber, entryNumber);
    expect(h.entryDate, day1);
    expect(await db.select(db.journalHeaders).get(), hasLength(1));
  });

  test('sole header takes the new date', () async {
    final headerID = await post(pair(100, series: 'A'));

    await journals.replaceSeriesLines(
      series: 'A',
      lines: pair(100),
      date: day2,
    );

    expect((await header(headerID))!.entryDate, day2);
  });

  test('unbalanced replacement throws and changes nothing', () async {
    await post(pair(100, series: 'A'));
    final lines = pair(100)..removeLast();

    await expectLater(
      journals.replaceSeriesLines(series: 'A', lines: lines, date: day2),
      throwsStateError,
    );

    final a = await linesOf('A');
    expect(a, hasLength(2));
    expect(a.every((l) => l.date == day1), isTrue);
  });

  test('empty replacement removes the series and an emptied header', () async {
    final soleID = await post(pair(100, series: 'A'));
    final sharedID = await post([
      ...pair(100, series: 'B'),
      ...pair(100, series: 'C'),
    ]);

    await journals.replaceSeriesLines(series: 'A', lines: [], date: day2);
    await journals.replaceSeriesLines(series: 'B', lines: [], date: day2);

    expect(await linesOf('A'), isEmpty);
    expect(await header(soleID), isNull);
    expect(await linesOf('B'), isEmpty);
    expect(await header(sharedID), isNotNull);
    expect(await linesOf('C'), hasLength(2));
  });

  test('unknown series throws', () async {
    await expectLater(
      journals.replaceSeriesLines(series: 'X', lines: pair(1), date: day2),
      throwsStateError,
    );
  });
}
