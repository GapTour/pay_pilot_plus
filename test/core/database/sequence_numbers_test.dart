import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pay_pilot_plus/core/data/params/detailed_account_params.dart';
import 'package:pay_pilot_plus/core/data/params/journal_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/utils/services/accounts_chart_seeder_service.dart';

void main() {
  late AppDatabase db;
  late JournalsDao journalsDao;
  late DetailedAccountsDao accountsDao;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await AccountsChartSeederService(db).seedDefaultChartOfAccounts();
    journalsDao = JournalsDao(db);
    accountsDao = DetailedAccountsDao(db);
  });

  tearDown(() => db.close());

  group('journal entry numbers', () {
    Future<String> insertJournalAndReadNumber() async {
      final subs = await SubsidiaryAccountsDao(db).fetchSubsidiaryAccounts();
      final cash = subs[SubsidiaryAccountType.cash]!.id;
      final bank = subs[SubsidiaryAccountType.bank]!.id;

      final headerID = await journalsDao.insertJournal(
        JournalParams(
          date: DateTime(2026, 1, 1),
          noticeMemo: null,
          hasSource: true,
          lines: [
            JournalLinesCompanion.insert(
              headerId: 0,
              subsidiaryId: cash,
              debit: BigInt.from(10),
              credit: BigInt.zero,
              series: 's',
            ),
            JournalLinesCompanion.insert(
              headerId: 0,
              subsidiaryId: bank,
              debit: BigInt.zero,
              credit: BigInt.from(10),
              series: 's',
            ),
          ],
        ),
      );

      final header = await (db.select(
        db.journalHeaders,
      )..where((t) => t.id.equals(headerID))).getSingle();
      return header.entryNumber;
    }

    Future<void> seedHeader(String entryNumber) {
      return db
          .into(db.journalHeaders)
          .insert(
            JournalHeadersCompanion.insert(
              entryNumber: entryNumber,
              entryDate: DateTime(2026, 1, 1),
            ),
          );
    }

    test('first journal gets JV-0001', () async {
      expect(await insertJournalAndReadNumber(), 'JV-0001');
    });

    test('continues after the highest number', () async {
      await seedHeader('JV-0007');
      await seedHeader('JV-0012');

      expect(await insertJournalAndReadNumber(), 'JV-0013');
    });

    test('rolls over from JV-9999 to JV-10000', () async {
      await seedHeader('JV-9999');

      expect(await insertJournalAndReadNumber(), 'JV-10000');
    });

    test('keeps counting after JV-10000 exists', () async {
      await seedHeader('JV-9999');
      await seedHeader('JV-10000');

      expect(await insertJournalAndReadNumber(), 'JV-10001');
    });
  });

  group('detailed account codes', () {
    Future<int> newUser(String name) {
      return db
          .into(db.users)
          .insert(
            UsersCompanion.insert(name: name, role: UserAccountRole.staff),
          );
    }

    Future<String> insertUserAccount(String name) async {
      final result = await accountsDao.insertAccount(
        DetailedAccountParams(
          id: null,
          attachmentID: await newUser(name),
          name: name,
          type: DetailedAccountType.user,
        ),
      );
      return result.code;
    }

    Future<void> seedCode(String code) {
      return db
          .into(db.detailedAccounts)
          .insert(
            DetailedAccountsCompanion.insert(
              code: code,
              name: 'seed $code',
              type: DetailedAccountType.other,
            ),
          );
    }

    test('first user account gets 1000001', () async {
      expect(await insertUserAccount('Ali'), '1000001');
    });

    test('rolls over from 1099999 to 10100000', () async {
      await seedCode('1099999');

      expect(await insertUserAccount('Ali'), '10100000');
    });

    test('keeps counting after 10100000 exists', () async {
      await seedCode('1099999');
      await seedCode('10100000');

      expect(await insertUserAccount('Ali'), '10100001');
    });
  });
}
