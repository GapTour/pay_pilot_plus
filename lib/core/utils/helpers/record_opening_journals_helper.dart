import 'package:drift/drift.dart' show Value;
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/utils/helpers/journal_lines_series_helper.dart';

class RecordOpeningJournalsHelper {
  RecordOpeningJournalsHelper._();

  static List<JournalLinesCompanion> submitBankDeposit({
    required ({int id, String name, int accountID}) bankInfo,
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required BigInt openingAmount,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final bankSubsidiaryID =
        subsidiaryAccountsMap[SubsidiaryAccountType.bank]!.id;
    final openingID =
        subsidiaryAccountsMap[SubsidiaryAccountType.openingBalance]!.id;
    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'opnBNK${bankInfo.accountID}AMN$openingAmount',
    );

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(bankInfo.accountID),
        subsidiaryId: openingID,
        debit: BigInt.zero,
        credit: openingAmount,
        series: series,
        memo: Value('بابت ثبت افتتاحیه موجودی اولیه بانک ${bankInfo.name}'),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(bankInfo.accountID),
        subsidiaryId: bankSubsidiaryID,
        debit: openingAmount,
        credit: BigInt.zero,
        series: series,
        memo: Value('بابت ثبت افتتاحیه موجودی اولیه بانک ${bankInfo.name}'),
      ),
    ]);

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion> submitCashDeposit({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required BigInt openingAmount,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final cashSubsidiaryID =
        subsidiaryAccountsMap[SubsidiaryAccountType.cash]!.id;
    final openingID =
        subsidiaryAccountsMap[SubsidiaryAccountType.openingBalance]!.id;
    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'opnCSH${cashSubsidiaryID}AMN$openingAmount',
    );

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        subsidiaryId: openingID,
        debit: BigInt.zero,
        credit: openingAmount,
        series: series,
        memo: Value('بابت ثبت افتتاحیه موجودی اولیه صندوق'),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        subsidiaryId: cashSubsidiaryID,
        debit: openingAmount,
        credit: BigInt.zero,
        series: series,
        memo: Value('بابت ثبت افتتاحیه موجودی اولیه صندوق'),
      ),
    ]);

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion> submitGuestReceivable({
    required ({int id, String name, int accountID}) userInfo,
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required BigInt openingAmount,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final receivableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.guestReceivables]!.id;
    final openingID =
        subsidiaryAccountsMap[SubsidiaryAccountType.openingBalance]!.id;
    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'opnGUS${userInfo.accountID}AMN$openingAmount',
    );

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(userInfo.accountID),
        subsidiaryId: openingID,
        debit: BigInt.zero,
        credit: openingAmount,
        series: series,
        memo: Value('بابت ثبت افتتاحیه موجودی اولیه حساب ${userInfo.name}'),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(userInfo.accountID),
        subsidiaryId: receivableID,
        debit: openingAmount,
        credit: BigInt.zero,
        series: series,
        memo: Value('بابت ثبت افتتاحیه موجودی اولیه حساب ${userInfo.name}'),
      ),
    ]);

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion> submitMemberPayable({
    required ({int id, String name, int accountID}) userInfo,
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required BigInt openingAmount,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;
    final openingID =
        subsidiaryAccountsMap[SubsidiaryAccountType.openingBalance]!.id;
    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'opnMEM${userInfo.accountID}AMN$openingAmount',
    );

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(userInfo.accountID),
        subsidiaryId: openingID,
        debit: openingAmount,
        credit: BigInt.zero,
        series: series,
        memo: Value('بابت ثبت افتتاحیه موجودی اولیه حساب ${userInfo.name}'),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(userInfo.accountID),
        subsidiaryId: payableID,
        debit: BigInt.zero,
        credit: openingAmount,
        series: series,
        memo: Value('بابت ثبت افتتاحیه موجودی اولیه حساب ${userInfo.name}'),
      ),
    ]);

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion> submitHostPayable({
    required ({int id, String name, int accountID}) userInfo,
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required BigInt openingAmount,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;
    final openingID =
        subsidiaryAccountsMap[SubsidiaryAccountType.openingBalance]!.id;
    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'opnHST${userInfo.accountID}AMN$openingAmount',
    );

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(userInfo.accountID),
        subsidiaryId: openingID,
        debit: openingAmount,
        credit: BigInt.zero,
        series: series,
        memo: Value('بابت ثبت افتتاحیه موجودی اولیه حساب ${userInfo.name}'),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(userInfo.accountID),
        subsidiaryId: payableID,
        debit: BigInt.zero,
        credit: openingAmount,
        series: series,
        memo: Value('بابت ثبت افتتاحیه موجودی اولیه حساب ${userInfo.name}'),
      ),
    ]);

    return generatedJournalLines;
  }
}
