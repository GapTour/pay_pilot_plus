import 'package:drift/drift.dart' show Value;
import 'package:pay_pilot_plus/core/database/app_database.dart'
    show JournalLinesCompanion, SubsidiaryAccountType, SubsidiaryAccount;
import 'package:pay_pilot_plus/core/utils/helpers/journal_lines_series_helper.dart';

class RecordAssignmentJournalsHelper {
  RecordAssignmentJournalsHelper._();

  static List<JournalLinesCompanion> fromGuestsToStaff({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) staffInfo,
    required ({int id, String name, int accountID}) eventInfo,
    required List<({int id, String name, int accountID})> guestsInfo,
    required BigInt receivedAmount,
    required DateTime paidAt,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final receivablesID =
        subsidiaryAccountsMap[SubsidiaryAccountType.guestReceivables]!.id;
    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;

    for (var gi in guestsInfo) {
      final series = JournalLinesSeriesHelper.generateSeries(
        extra: 'payUSR${gi.accountID}EVN${eventInfo.accountID}',
      );

      generatedJournalLines.addAll([
        JournalLinesCompanion.insert(
          headerId: 0,
          firstDetailedId: Value(gi.accountID),
          secondDetailedId: Value(eventInfo.accountID),
          subsidiaryId: receivablesID,
          debit: BigInt.zero,
          credit: receivedAmount,
          series: series,
          date: Value(paidAt),
          memo: Value(
            'تسویه حساب ثبت نام در رویداد ${eventInfo.name} توسط ${gi.name} و واگذاری به حساب ${staffInfo.name}',
          ),
        ),
        JournalLinesCompanion.insert(
          headerId: 0,
          firstDetailedId: Value(staffInfo.accountID),
          secondDetailedId: Value(gi.accountID),
          subsidiaryId: payableID,
          debit: receivedAmount,
          credit: BigInt.zero,
          series: series,
          date: Value(paidAt),
          memo: Value(
            'تسویه حساب ثبت نام در رویداد ${eventInfo.name} توسط ${gi.name} و واگذاری به حساب ${staffInfo.name}',
          ),
        ),
      ]);
    }

    return generatedJournalLines;
  }

  // static List<JournalLinesCompanion> fromGuestsToAnywhere({
  //   required Map<SubsidiaryAccountType, SubsidiaryAccount>
  //   subsidiaryAccountsMap,
  //   required ({int id, String name, int accountID}) eventInfo,
  //   required List<({int id, String name, int accountID})> guestsInfo,
  //   required BigInt receivedAmount,
  //   required DateTime paidAt,
  // }) {
  //   final generatedJournalLines = <JournalLinesCompanion>[];

  //   final receivablesID =
  //       subsidiaryAccountsMap[SubsidiaryAccountType.guestReceivables]!.id;

  //   for (var gi in guestsInfo) {
  //     final series = JournalLinesSeriesHelper.generateSeries(
  //       extra: 'recUSR${gi.accountID}EVN${eventInfo.accountID}',
  //     );

  //     generatedJournalLines.addAll([
  //       JournalLinesCompanion.insert(
  //         headerId: 0,
  //         firstDetailedId: Value(gi.accountID),
  //         secondDetailedId: Value(eventInfo.accountID),
  //         subsidiaryId: receivablesID,
  //         debit: BigInt.zero,
  //         credit: receivedAmount,
  //         series: series,
  //         date: Value(paidAt),
  //         memo: Value(
  //           'بابت تسویه حساب ${gi.name} برای ثبت نام در رویداد ${eventInfo.name}',
  //         ),
  //       ),
  //     ]);
  //   }

  //   return generatedJournalLines;
  // }
}
