import 'package:drift/drift.dart' show Value;
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/utils/helpers/journal_lines_series_helper.dart';

class RecordExpensesJournalsHelper {
  RecordExpensesJournalsHelper._();

  static List<JournalLinesCompanion> identificationEntranceFee({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) hostInfo,
    required ({int id, String name, int accountID}) eventInfo,
    required BigInt entranceFee,
    required String series,
    required DateTime date,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final expenseID =
        subsidiaryAccountsMap[SubsidiaryAccountType.entranceExpenses]!.id;
    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(hostInfo.accountID),
        secondDetailedId: Value(eventInfo.accountID),
        subsidiaryId: payableID,
        debit: BigInt.zero,
        credit: entranceFee,
        series: series,
        date: Value(date),
        memo: Value(
          'بابت برگزاری رویداد ${eventInfo.name} در ${hostInfo.name}',
        ),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(eventInfo.accountID),
        secondDetailedId: Value(hostInfo.accountID),
        subsidiaryId: expenseID,
        debit: entranceFee,
        credit: BigInt.zero,
        series: series,
        date: Value(date),
        memo: Value(
          'بابت برگزاری رویداد ${eventInfo.name} در ${hostInfo.name}',
        ),
      ),
    ]);

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion> identificationSnacksFee({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) hostInfo,
    required ({int id, String name, int accountID}) eventInfo,
    required List<({int id, String name, int accountID})> staffsInfo,
    required BigInt snacksFee,
    required int totalGuestsNumber,
    required String series,
    required DateTime date,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final expenseID =
        subsidiaryAccountsMap[SubsidiaryAccountType.snacksExpenses]!.id;
    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;
    BigInt finalGuestsNumber = BigInt.from(totalGuestsNumber);

    for (var staff in staffsInfo) {
      finalGuestsNumber = finalGuestsNumber + BigInt.one;
      generatedJournalLines.add(
        JournalLinesCompanion.insert(
          headerId: 0,
          firstDetailedId: Value(staff.accountID),
          secondDetailedId: Value(eventInfo.accountID),
          subsidiaryId: payableID,
          debit: snacksFee,
          credit: BigInt.zero,
          series: series,
          date: Value(date),
          memo: Value(
            'بابت هزینه پذیرایی رویداد ${eventInfo.name} توسط (${hostInfo.name})',
          ),
        ),
      );
    }

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(eventInfo.accountID),
        secondDetailedId: Value(hostInfo.accountID),
        subsidiaryId: expenseID,
        debit: snacksFee * BigInt.from(totalGuestsNumber),
        credit: BigInt.zero,
        series: series,
        date: Value(date),
        memo: Value(
          'بابت هزینه پذیرایی رویداد ${eventInfo.name} توسط (${hostInfo.name})',
        ),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(hostInfo.accountID),
        secondDetailedId: Value(eventInfo.accountID),
        subsidiaryId: payableID,
        debit: BigInt.zero,
        credit: snacksFee * finalGuestsNumber,
        series: series,
        date: Value(date),
        memo: Value('بابت هزینه پذیرایی رویداد ${eventInfo.name}'),
      ),
    ]);

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion> identificationExpenseSettledByStaff({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required SubsidiaryAccountType expenseSubsidiaryType,
    required ({int id, String name, int accountID}) staffInfo,
    required ({int id, String name, int accountID}) eventInfo,
    required BigInt amount,
    required DateTime paidAt,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final expenseID = subsidiaryAccountsMap[expenseSubsidiaryType]!.id;
    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;
    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'expEVN${eventInfo.accountID}USR${staffInfo.accountID}',
    );

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(staffInfo.accountID),
        secondDetailedId: Value(eventInfo.accountID),
        subsidiaryId: payableID,
        debit: BigInt.zero,
        credit: amount,
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت پرداخت ${expenseSubsidiaryType.title} ایونت ${eventInfo.name} توسط ${staffInfo.name}',
        ),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(eventInfo.accountID),
        subsidiaryId: expenseID,
        debit: amount,
        credit: BigInt.zero,
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت پرداخت ${expenseSubsidiaryType.title} ایونت ${eventInfo.name} توسط ${staffInfo.name}',
        ),
      ),
    ]);

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion>
  identificationEventExpenseWithDirectPayment({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required SubsidiaryAccountType expenseSubsidiaryType,
    required ({int id, String name, int accountID}) bankInfo,
    required ({int id, String name, int accountID}) eventInfo,
    required BigInt amount,
    required BigInt? transferFee,
    required String series,
    required DateTime paidAt,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final expenseID = subsidiaryAccountsMap[expenseSubsidiaryType]!.id;
    final banksID = subsidiaryAccountsMap[SubsidiaryAccountType.bank]!.id;

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(bankInfo.accountID),
        subsidiaryId: banksID,
        debit: BigInt.zero,
        credit: amount + (transferFee ?? BigInt.zero),
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت پرداخت ${expenseSubsidiaryType.title} ایونت ${eventInfo.name}',
        ),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(eventInfo.accountID),
        subsidiaryId: expenseID,
        debit: amount,
        credit: BigInt.zero,
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت پرداخت ${expenseSubsidiaryType.title} ایونت ${eventInfo.name}',
        ),
      ),
    ]);

    return generatedJournalLines;
  }
}
