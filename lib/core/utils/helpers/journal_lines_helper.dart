import 'dart:math';

import 'package:drift/drift.dart' show Value;
import 'package:pay_pilot_plus/core/data/params/guest_registration_journal_params.dart';
import 'package:pay_pilot_plus/core/data/params/user_salary_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

class JournalLinesHelper {
  JournalLinesHelper._();

  static List<JournalLinesCompanion> recordGuestRegistration(
    GuestRegistrationJournalParams params,
  ) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final revenueID =
        params.subsidiaryAccountsMap[SubsidiaryAccountType.eventRevenue]!.id;
    final discountsID =
        params.subsidiaryAccountsMap[SubsidiaryAccountType.saleDiscounts]!.id;
    final receivablesID = params
        .subsidiaryAccountsMap[SubsidiaryAccountType.guestReceivables]!
        .id;

    for (var userInfo in params.usersInfo) {
      final userAccount = params.usersAccounts.firstWhere(
        (element) => element.userID == userInfo.id,
      );
      final series = _generateSeries(
        extra: 'regUSR${userAccount.id}EVN${params.eventInfo.accountID}',
      );

      generatedJournalLines.addAll([
        JournalLinesCompanion.insert(
          headerId: 0,
          detailedId: Value(params.eventInfo.accountID),
          subsidiaryId: revenueID,
          debit: BigInt.zero,
          credit: params.grossAmount,
          series: series,
          memo: Value(
            'بابت ثبت نام ${userInfo.name} در رویداد ${params.eventInfo.name}',
          ),
        ),
        if (params.discountAmount > BigInt.from(0))
          JournalLinesCompanion.insert(
            headerId: 0,
            detailedId: Value(params.eventInfo.accountID),
            subsidiaryId: discountsID,
            debit: params.discountAmount,
            credit: BigInt.zero,
            series: series,
            memo: Value(
              'بابت ثبت نام ${userInfo.name} در رویداد ${params.eventInfo.name}',
            ),
          ),
        if (params.netAmount > BigInt.from(0))
          JournalLinesCompanion.insert(
            headerId: 0,
            detailedId: Value(userAccount.id),
            subsidiaryId: receivablesID,
            debit: params.netAmount,
            credit: BigInt.zero,
            series: series,
            memo: Value(
              'بابت ثبت نام ${userInfo.name} در رویداد ${params.eventInfo.name}',
            ),
          ),
      ]);
    }

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion> recordBankDeposit(
    Map<SubsidiaryAccountType, SubsidiaryAccount> subsidiaryAccountsMap,
    List<({int id, String name, int accountID})> usersInfo,
    int bankAccountID,
    BigInt amount,
    String eventName,
    int eventAccountID,
  ) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final receivablesID =
        subsidiaryAccountsMap[SubsidiaryAccountType.guestReceivables]!.id;
    final banksID = subsidiaryAccountsMap[SubsidiaryAccountType.bank]!.id;

    for (var ui in usersInfo) {
      final series = _generateSeries(
        extra: 'payUSR${ui.accountID}EVN$eventAccountID',
      );

      generatedJournalLines.addAll([
        JournalLinesCompanion.insert(
          headerId: 0,
          detailedId: Value(ui.accountID),
          subsidiaryId: receivablesID,
          debit: BigInt.zero,
          credit: amount,
          series: series,
          memo: Value('بابت تسویه حساب ${ui.name} رویداد $eventName'),
        ),
        JournalLinesCompanion.insert(
          headerId: 0,
          detailedId: Value(bankAccountID),
          detailedIdSecond: Value(eventAccountID),
          subsidiaryId: banksID,
          debit: amount,
          credit: BigInt.zero,
          series: series,
          memo: Value('بابت دریافت از ${ui.name} رویداد $eventName'),
        ),
      ]);
    }

    return generatedJournalLines;
  }

  static List<JournalLinesCompanion> recordCashReceipt(
    Map<SubsidiaryAccountType, SubsidiaryAccount> subsidiaryAccountsMap,
    List<({int id, String name, int accountID})> usersInfo,
    BigInt amount,
    String eventName,
    int eventAccountID,
  ) {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final receivablesID =
        subsidiaryAccountsMap[SubsidiaryAccountType.guestReceivables]!.id;
    final cashesID = subsidiaryAccountsMap[SubsidiaryAccountType.cash]!.id;

    for (var ui in usersInfo) {
      final series = _generateSeries(
        extra: 'payUSR${ui.accountID}EVN$eventAccountID',
      );

      generatedJournalLines.addAll([
        JournalLinesCompanion.insert(
          headerId: 0,
          detailedId: Value(ui.accountID),
          subsidiaryId: receivablesID,
          debit: BigInt.zero,
          credit: amount,
          series: series,
          memo: Value('بابت تسویه حساب ${ui.name} رویداد $eventName'),
        ),
        JournalLinesCompanion.insert(
          headerId: 0,
          detailedIdSecond: Value(eventAccountID),
          subsidiaryId: cashesID,
          debit: amount,
          credit: BigInt.zero,
          series: series,
          memo: Value('بابت دریافت از ${ui.name} رویداد $eventName'),
        ),
      ]);
    }

    return generatedJournalLines;
  }

  static Future<List<JournalLinesCompanion>> recordMembersSalary(
    Map<SubsidiaryAccountType, SubsidiaryAccount> subsidiaryAccountsMap,
    List<DetailedAccount> usersAccount,
    List<UserSalaryParams> salaryParams,
    BigInt eventProfit,
    String eventName,
    int eventAccountID,
  ) async {
    final generatedJournalLines = <JournalLinesCompanion>[];

    final payableID =
        subsidiaryAccountsMap[SubsidiaryAccountType.accountsPayable]!.id;
    final expenseID =
        subsidiaryAccountsMap[SubsidiaryAccountType.salaryExpense]!.id;
    final series = _generateSeries(extra: 'salEVN$eventAccountID');

    generatedJournalLines.add(
      JournalLinesCompanion.insert(
        headerId: 0,
        detailedId: Value(eventAccountID),
        subsidiaryId: expenseID,
        debit: eventProfit,
        credit: BigInt.zero,
        series: series,
        memo: Value('بابت شناسایی حقوق اعضا در رویداد $eventName'),
      ),
    );

    for (var us in salaryParams) {
      final userAccountID = usersAccount
          .firstWhere((element) => element.userID == us.userInfo.id)
          .id;

      generatedJournalLines.add(
        JournalLinesCompanion.insert(
          headerId: 0,
          detailedId: Value(userAccountID),
          subsidiaryId: payableID,
          debit: BigInt.zero,
          credit: us.salary,
          series: series,
          memo: Value('بابت حقوق رویداد $eventName'),
        ),
      );
    }

    return generatedJournalLines;
  }

  static String _generateSeries({String? extra}) {
    final random = Random.secure();
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    final date = (DateTime.now()).toUtc();

    final datePart =
        '${date.year}'
        '${date.month.toString().padLeft(2, '0')}'
        '${date.day.toString().padLeft(2, '0')}'
        '${date.hour.toString().padLeft(2, '0')}'
        '${date.minute.toString().padLeft(2, '0')}'
        '${date.second.toString().padLeft(2, '0')}';

    final randomPart = List.generate(
      8,
      (_) => characters[random.nextInt(characters.length)],
    ).join();

    return 'SER-$datePart-$randomPart${extra != null ? '-$extra' : 'N'}';
  }
}
