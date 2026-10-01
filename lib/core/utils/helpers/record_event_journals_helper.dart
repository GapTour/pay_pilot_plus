import 'package:drift/drift.dart' show Value;
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/utils/helpers/journal_lines_series_helper.dart';

class RecordEventJournalsHelper {
  RecordEventJournalsHelper._();

  static List<JournalLinesCompanion> identificationGuestAttending({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) eventInfo,
    required List<({int id, String name, int accountID})> guestsInfo,
    required BigInt grossAmount,
    required BigInt discountAmount,
    required BigInt netAmount,
    required DateTime attendAt,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final revenueID =
        subsidiaryAccountsMap[SubsidiaryAccountType.eventRevenue]!.id;
    final discountsID =
        subsidiaryAccountsMap[SubsidiaryAccountType.saleDiscounts]!.id;
    final receivablesID =
        subsidiaryAccountsMap[SubsidiaryAccountType.guestReceivables]!.id;

    for (var gi in guestsInfo) {
      final series = JournalLinesSeriesHelper.generateSeries(
        extra: 'regUSR${gi.accountID}EVN${eventInfo.accountID}',
      );

      generatedJournalLines.addAll([
        JournalLinesCompanion.insert(
          headerId: 0,
          firstDetailedId: Value(eventInfo.accountID),
          secondDetailedId: Value(gi.accountID),
          subsidiaryId: revenueID,
          debit: BigInt.zero,
          credit: grossAmount,
          series: series,
          date: Value(attendAt),
          memo: Value('بابت ثبت نام ${gi.name} در رویداد ${eventInfo.name}'),
        ),
        if (discountAmount > BigInt.zero)
          JournalLinesCompanion.insert(
            headerId: 0,
            firstDetailedId: Value(eventInfo.accountID),
            secondDetailedId: Value(gi.accountID),
            subsidiaryId: discountsID,
            debit: discountAmount,
            credit: BigInt.zero,
            series: series,
            date: Value(attendAt),
            memo: Value('بابت ثبت نام ${gi.name} در رویداد ${eventInfo.name}'),
          ),
        if (netAmount > BigInt.zero)
          JournalLinesCompanion.insert(
            headerId: 0,
            firstDetailedId: Value(gi.accountID),
            secondDetailedId: Value(eventInfo.accountID),
            subsidiaryId: receivablesID,
            debit: netAmount,
            credit: BigInt.zero,
            series: series,
            date: Value(attendAt),
            memo: Value('بابت ثبت نام ${gi.name} در رویداد ${eventInfo.name}'),
          ),
      ]);
    }

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion> identificationStaffAttending({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) eventInfo,
    required List<({int id, String name, int accountID})> staffsInfo,
    required BigInt grossAmount,
    required BigInt discountAmount,
    required BigInt netAmount,
    required DateTime attendAt,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final revenueID =
        subsidiaryAccountsMap[SubsidiaryAccountType.eventRevenue]!.id;
    final discountsID =
        subsidiaryAccountsMap[SubsidiaryAccountType.saleDiscounts]!.id;
    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;

    for (var si in staffsInfo) {
      final series = JournalLinesSeriesHelper.generateSeries(
        extra: 'regSTF${si.accountID}EVN${eventInfo.accountID}',
      );

      generatedJournalLines.addAll([
        JournalLinesCompanion.insert(
          headerId: 0,
          firstDetailedId: Value(eventInfo.accountID),
          secondDetailedId: Value(si.accountID),
          subsidiaryId: revenueID,
          debit: BigInt.zero,
          credit: grossAmount,
          series: series,
          date: Value(attendAt),
          memo: Value('بابت ثبت نام ${si.name} در رویداد ${eventInfo.name}'),
        ),
        if (discountAmount > BigInt.from(0))
          JournalLinesCompanion.insert(
            headerId: 0,
            firstDetailedId: Value(eventInfo.accountID),
            secondDetailedId: Value(si.accountID),
            subsidiaryId: discountsID,
            debit: discountAmount,
            credit: BigInt.zero,
            series: series,
            date: Value(attendAt),
            memo: Value('بابت ثبت نام ${si.name} در رویداد ${eventInfo.name}'),
          ),
        if (netAmount > BigInt.from(0))
          JournalLinesCompanion.insert(
            headerId: 0,
            firstDetailedId: Value(si.accountID),
            secondDetailedId: Value(eventInfo.accountID),
            subsidiaryId: payableID,
            debit: netAmount,
            credit: BigInt.zero,
            series: series,
            date: Value(attendAt),
            memo: Value('بابت ثبت نام ${si.name} در رویداد ${eventInfo.name}'),
          ),
      ]);
    }

    return generatedJournalLines;
  }
}
