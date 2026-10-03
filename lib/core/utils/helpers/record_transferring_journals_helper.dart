import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/utils/helpers/journal_lines_series_helper.dart';

class RecordTransferringJournalsHelper {
  RecordTransferringJournalsHelper._();

  static JournalLinesCompanion registerTransferFeeNotIndependently({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) bankInfo,
    required ({int id, String name, int accountID})? eventInfo,
    required BigInt transferFee,
    required String series,
    required DateTime paidAt,
  }) {
    final expenseID =
        subsidiaryAccountsMap[SubsidiaryAccountType.feeExpenses]!.id;

    return JournalLinesCompanion.insert(
      headerId: 0,
      firstDetailedId: Value(eventInfo?.accountID),
      secondDetailedId: Value(bankInfo.accountID),
      subsidiaryId: expenseID,
      debit: transferFee,
      credit: BigInt.zero,
      series: series,
      date: Value(paidAt),
      memo: Value(
        'بابت کارمزد انتقال پرداختی${eventInfo?.name == null ? '' : ' ایونت ${eventInfo!.name}'}',
      ),
    );
  }

  static List<JournalLinesCompanion> registerTransferFee({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) bankInfo,
    required ({int id, String name, int accountID})? eventInfo,
    required BigInt transferFee,
    required DateTime paidAt,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final expenseID =
        subsidiaryAccountsMap[SubsidiaryAccountType.feeExpenses]!.id;
    final banksID = subsidiaryAccountsMap[SubsidiaryAccountType.bank]!.id;
    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'trnBNK${bankInfo.accountID}',
    );

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(bankInfo.accountID),
        subsidiaryId: banksID,
        debit: BigInt.zero,
        credit: transferFee,
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت کارمزد انتقال پرداختی${eventInfo?.name == null ? '' : ' ایونت ${eventInfo!.name}'}',
        ),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(eventInfo?.accountID),
        secondDetailedId: Value(bankInfo.accountID),
        subsidiaryId: expenseID,
        debit: transferFee,
        credit: BigInt.zero,
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت کارمزد انتقال پرداختی${eventInfo?.name == null ? '' : ' ایونت ${eventInfo!.name}'}',
        ),
      ),
    ]);

    return generatedJournalLines;
  }

  // static List<JournalLinesCompanion> registerPaymentFromEvent({
  //   required Map<SubsidiaryAccountType, SubsidiaryAccount>
  //   subsidiaryAccountsMap,
  //   required ({int id, String name, int accountID}) bankInfo,
  //   required ({int id, String name, int accountID}) eventInfo,
  //   required BigInt paymentAmount,
  //   required BigInt? transferFee,
  //   required String series,
  //   required DateTime paidAt,
  //   required String memo,
  // }) {
  //   final generatedJournalLines = <JournalLinesCompanion>[];

  //   final expenseID =
  //       subsidiaryAccountsMap[SubsidiaryAccountType.feeExpenses]!.id;
  //   final banksID = subsidiaryAccountsMap[SubsidiaryAccountType.bank]!.id;

  //   generatedJournalLines.addAll([
  //     JournalLinesCompanion.insert(
  //       headerId: 0,
  //       firstDetailedId: Value(bankInfo.accountID),
  //       subsidiaryId: banksID,
  //       debit: BigInt.zero,
  //       credit: paymentAmount + (transferFee ?? BigInt.zero),
  //       series: series,
  //       date: Value(paidAt),
  //       memo: Value(memo),
  //     ),
  //     if (transferFee != null)
  //       JournalLinesCompanion.insert(
  //         headerId: 0,
  //         firstDetailedId: Value(bankInfo.accountID),
  //         secondDetailedId: Value(eventInfo.accountID),
  //         subsidiaryId: expenseID,
  //         debit: transferFee,
  //         credit: BigInt.zero,
  //         series: series,
  //         date: Value(paidAt),
  //         memo: Value(memo),
  //       ),
  //   ]);

  //   return generatedJournalLines;
  // }

  static List<JournalLinesCompanion> registerPaymentToHost({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) bankInfo,
    required ({int id, String name, int accountID})? eventInfo,
    required ({int id, String name, int accountID}) hostInfo,
    required BigInt? transferFee,
    required BigInt paidAmount,
    required DateTime paidAt,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;
    final banksID = subsidiaryAccountsMap[SubsidiaryAccountType.bank]!.id;
    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'payHST${hostInfo.accountID}BNK${bankInfo.accountID}',
    );

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(bankInfo.accountID),
        secondDetailedId: Value(hostInfo.accountID),
        subsidiaryId: banksID,
        debit: BigInt.zero,
        credit: paidAmount + (transferFee ?? BigInt.zero),
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت پرداختی به ${hostInfo.name} از بانک ${bankInfo.name} ${eventInfo?.name == null ? '' : 'بابت ایونت ${eventInfo!.name}'}',
        ),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(hostInfo.accountID),
        secondDetailedId: Value(eventInfo?.accountID),
        subsidiaryId: payableID,
        debit: paidAmount,
        credit: BigInt.zero,
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت پرداختی به ${hostInfo.name} از بانک ${bankInfo.name} ${eventInfo?.name == null ? '' : 'بابت ایونت ${eventInfo!.name}'}',
        ),
      ),
    ]);

    if (transferFee != null) {
      final transferFeeJournal = registerTransferFeeNotIndependently(
        subsidiaryAccountsMap: subsidiaryAccountsMap,
        bankInfo: bankInfo,
        eventInfo: eventInfo,
        transferFee: transferFee,
        series: series,
        paidAt: paidAt,
      );

      generatedJournalLines.add(transferFeeJournal);
    }

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion> registerPaymentToStaff({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) bankInfo,
    required ({int id, String name, int accountID}) staffInfo,
    required ({int id, String name, int accountID})? eventInfo,
    required BigInt? transferFee,
    required BigInt paidAmount,
    required DateTime paidAt,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;
    final banksID = subsidiaryAccountsMap[SubsidiaryAccountType.bank]!.id;
    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'paySTF${staffInfo.accountID}BNK${bankInfo.accountID}',
    );

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(bankInfo.accountID),
        secondDetailedId: Value(staffInfo.accountID),
        subsidiaryId: banksID,
        debit: BigInt.zero,
        credit: paidAmount + (transferFee ?? BigInt.zero),
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت پرداختی به ${staffInfo.name} از بانک ${bankInfo.name} ${eventInfo?.name == null ? '' : 'بابت ایونت ${eventInfo!.name}'}',
        ),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(staffInfo.accountID),
        secondDetailedId: Value(eventInfo?.accountID),
        subsidiaryId: payableID,
        debit: paidAmount,
        credit: BigInt.zero,
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت پرداختی به ${staffInfo.name} از بانک ${bankInfo.name} ${eventInfo?.name == null ? '' : 'بابت ایونت ${eventInfo!.name}'}',
        ),
      ),
    ]);

    if (transferFee != null) {
      final transferFeeJournal = registerTransferFeeNotIndependently(
        subsidiaryAccountsMap: subsidiaryAccountsMap,
        bankInfo: bankInfo,
        eventInfo: eventInfo,
        transferFee: transferFee,
        series: series,
        paidAt: paidAt,
      );

      generatedJournalLines.add(transferFeeJournal);
    }

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion> registerPaymentFromGuest({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) bankInfo,
    required ({int id, String name, int accountID}) eventInfo,
    required List<({int id, String name, int accountID})> guestsInfo,
    required BigInt receivedAmount,
    required DateTime paidAt,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final receivablesID =
        subsidiaryAccountsMap[SubsidiaryAccountType.guestReceivables]!.id;
    final banksID = subsidiaryAccountsMap[SubsidiaryAccountType.bank]!.id;

    for (var gi in guestsInfo) {
      final series = JournalLinesSeriesHelper.generateSeries(
        extra: 'recUSR${gi.accountID}EVN${eventInfo.accountID}',
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
            'بابت تسویه حساب ${gi.name} برای شرکت در رویداد ${eventInfo.name}',
          ),
        ),
        JournalLinesCompanion.insert(
          headerId: 0,
          firstDetailedId: Value(bankInfo.accountID),
          secondDetailedId: Value(eventInfo.accountID),
          subsidiaryId: banksID,
          debit: receivedAmount,
          credit: BigInt.zero,
          series: series,
          date: Value(paidAt),
          memo: Value(
            'بابت دریافت از ${gi.name} برای شرکت در رویداد ${eventInfo.name}',
          ),
        ),
      ]);
    }

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion> registerPaymentFromHost({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) bankInfo,
    required ({int id, String name, int accountID})? eventInfo,
    required ({int id, String name, int accountID}) hostInfo,
    required BigInt paidAmount,
    required DateTime paidAt,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;
    final banksID = subsidiaryAccountsMap[SubsidiaryAccountType.bank]!.id;
    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'payHST${hostInfo.accountID}BNK${bankInfo.accountID}',
    );

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(bankInfo.accountID),
        secondDetailedId: Value(hostInfo.accountID),
        subsidiaryId: banksID,
        credit: BigInt.zero,
        debit: paidAmount,
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت دریافت از ${hostInfo.name} واریز به بانک ${bankInfo.name} ${eventInfo?.name == null ? '' : 'بابت رویداد ${eventInfo!.name}'}',
        ),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(hostInfo.accountID),
        secondDetailedId: Value(eventInfo?.accountID),
        subsidiaryId: payableID,
        credit: paidAmount,
        debit: BigInt.zero,
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت دریافت از ${hostInfo.name} واریز به بانک ${bankInfo.name} ${eventInfo?.name == null ? '' : 'بابت رویداد ${eventInfo!.name}'}',
        ),
      ),
    ]);

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion> registerPaymentFromStaff({
    required Map<SubsidiaryAccountType, SubsidiaryAccount>
    subsidiaryAccountsMap,
    required ({int id, String name, int accountID}) bankInfo,
    required ({int id, String name, int accountID}) staffInfo,
    required ({int id, String name, int accountID})? eventInfo,
    required BigInt paidAmount,
    required DateTime paidAt,
  }) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;
    final banksID = subsidiaryAccountsMap[SubsidiaryAccountType.bank]!.id;
    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'paySTF${staffInfo.accountID}BNK${bankInfo.accountID}',
    );

    generatedJournalLines.addAll([
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(bankInfo.accountID),
        secondDetailedId: Value(staffInfo.accountID),
        subsidiaryId: banksID,
        credit: BigInt.zero,
        debit: paidAmount,
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت دریافت از ${staffInfo.name} واریز به بانک ${bankInfo.name} ${eventInfo?.name == null ? '' : 'بابت رویداد ${eventInfo!.name}'}',
        ),
      ),
      JournalLinesCompanion.insert(
        headerId: 0,
        firstDetailedId: Value(staffInfo.accountID),
        secondDetailedId: Value(eventInfo?.accountID),
        subsidiaryId: payableID,
        credit: paidAmount,
        debit: BigInt.zero,
        series: series,
        date: Value(paidAt),
        memo: Value(
          'بابت دریافت از ${staffInfo.name} واریز به بانک ${bankInfo.name} ${eventInfo?.name == null ? '' : 'بابت رویداد ${eventInfo!.name}'}',
        ),
      ),
    ]);

    return generatedJournalLines;
  }

  // static List<JournalLinesCompanion> receiptCash({
  //   required Map<SubsidiaryAccountType, SubsidiaryAccount>
  //   subsidiaryAccountsMap,
  //   required List<({int id, String name, int accountID})> guestsInfo,
  //   required ({int id, String name, int accountID}) eventInfo,
  //   required BigInt amount,
  // }) {
  //   final generatedJournalLines = <JournalLinesCompanion>[];

  //   final receivablesID =
  //       subsidiaryAccountsMap[SubsidiaryAccountType.guestReceivables]!.id;
  //   final cashesID = subsidiaryAccountsMap[SubsidiaryAccountType.cash]!.id;

  //   for (var ui in guestsInfo) {
  //     final series = JournalLinesSeriesHelper.generateSeries(
  //       extra: 'payUSR${ui.accountID}EVN$eventInfo.accountID',
  //     );

  //     generatedJournalLines.addAll([
  //       JournalLinesCompanion.insert(
  //         headerId: 0,
  //         firstDetailedId: Value(ui.accountID),
  //         secondDetailedId: Value(eventAccountID),
  //         subsidiaryId: receivablesID,
  //         debit: BigInt.zero,
  //         credit: amount,
  //         series: series,
  //         memo: Value('بابت تسویه حساب ${ui.name} رویداد $eventName'),
  //       ),
  //       JournalLinesCompanion.insert(
  //         headerId: 0,
  //         secondDetailedId: Value(eventAccountID),
  //         subsidiaryId: cashesID,
  //         debit: amount,
  //         credit: BigInt.zero,
  //         series: series,
  //         memo: Value('بابت دریافت از ${ui.name} رویداد $eventName'),
  //       ),
  //     ]);
  //   }

  //   return generatedJournalLines;
  // }
}
