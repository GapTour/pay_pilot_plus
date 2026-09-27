import 'package:drift/drift.dart' show Value;
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/utils/helpers/journal_lines_series_helper.dart';

class RecordEntranceFeeJournalsHelper {
  RecordEntranceFeeJournalsHelper._();

  static List<JournalLinesCompanion> insertEvent({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) hostInfo,
    required ({int id, String name, int accountID}) eventInfo,
    required BigInt entranceFee,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final expenseID =
        subsidiaryAccountsMap[SubsidiaryAccountType.entranceExpenses]!.id;
    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;

    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'entEVN${eventInfo.accountID}HST${hostInfo.accountID}',
    );

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(hostInfo.accountID),
        secondDetailedId: Value(eventInfo.accountID),
        subsidiaryId: payableID,
        debit: BigInt.zero,
        credit: entranceFee,
        series: series,
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
        memo: Value(
          'بابت برگزاری رویداد ${eventInfo.name} در ${hostInfo.name}',
        ),
      ),
    ]);

    return generatedJournalLines;
  }
}
