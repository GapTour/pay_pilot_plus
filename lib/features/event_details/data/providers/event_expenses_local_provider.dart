import 'package:pay_pilot_plus/core/data/models/event_expense_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_balance_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_expense_params.dart';
import 'package:pay_pilot_plus/core/data/params/fund_balance_params.dart';
import 'package:pay_pilot_plus/core/data/params/journal_params.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/fund_balances/fund_balances_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/utils/helpers/journal_lines_series_helper.dart';
import 'package:pay_pilot_plus/core/utils/helpers/record_expenses_journals_helper.dart';
import 'package:pay_pilot_plus/core/utils/helpers/record_transferring_journals_helper.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_expenses_source.dart';

abstract class IEventExpensesLocalProvider
    implements
        IEventExpensesSource<List<EventExpenseModel>, int, EventExpenseModel> {}

class EventExpensesLocalProvider extends BaseRepository
    implements IEventExpensesLocalProvider {
  final JournalsDao _journalsDao;
  final SubsidiaryAccountsDao _subsidiaryAccountsDao;
  final DetailedAccountsDao _accountsDao;
  final FundBalancesDao _fundBalancesDao;

  EventExpensesLocalProvider(
    this._journalsDao,
    this._subsidiaryAccountsDao,
    this._accountsDao,
    this._fundBalancesDao,
  );

  @override
  Future<List<EventExpenseModel>> fetchAllExpenses(int eventID) async {
    final eventAccount = await _accountsDao.fetchEventAccount(eventID);
    final response = await _journalsDao.fetchJournalLinesBySubsidiaryId(
      subsidiaryID: null,
      firstDetailedID: eventAccount.id,
    );

    final validLines = response
        .where((r) => r.subAccount.type.isExpense)
        .toList();

    if (validLines.isEmpty) return const [];

    final journalsList = await Future.wait(
      validLines.map(
        (r) => _journalsDao.fetchJournalsBySeries(series: r.journalLine.series),
      ),
    );

    final validBankLines = journalsList
        .expand((e) => e)
        .where(
          (w) =>
              w.journalLine.credit > BigInt.zero && w.subAccount.type == .bank,
        );

    final fundBalanceResults = await Future.wait(
      validBankLines.map(
        (e) => _fundBalancesDao.fetchFundBalanceBySeries(e.journalLine.series),
      ),
    );

    final fundBalanceMap = {
      for (var fb in fundBalanceResults)
        if (fb != null)
          fb.balanceInfo.series: FundBalanceModel(
            id: fb.balanceInfo.id,
            title: fb.fund.title,
            debit: fb.balanceInfo.debit,
            credit: fb.balanceInfo.credit,
            date: fb.balanceInfo.date,
            series: fb.balanceInfo.series,
          ),
    };

    final expenses = <EventExpenseModel>[];
    for (var valid in validLines) {
      ({int id, String name})? bankInfo;
      ({int id, String name})? userInfo;

      final validateCreditorSide = journalsList
          .expand((e) => e)
          .firstWhere(
            (w) =>
                w.journalLine.credit > BigInt.zero &&
                w.journalLine.series == valid.journalLine.series,
          );

      final detailed = validateCreditorSide.detailed1;
      if (detailed == null) continue;

      final detailedAccountInfo = await _accountsDao.fetchAccount(detailed.id);
      if (detailedAccountInfo.bankID != null) {
        bankInfo = (
          id: detailedAccountInfo.bankID!,
          name: detailedAccountInfo.name,
        );
      } else if (detailedAccountInfo.userID != null) {
        userInfo = (
          id: detailedAccountInfo.userID!,
          name: detailedAccountInfo.name,
        );
      }

      expenses.add(
        EventExpenseModel(
          series: valid.journalLine.series,
          subsidiaryAccountType: valid.subAccount.type,
          eventInfo: (id: eventID, name: eventAccount.name),
          bankInfo: bankInfo,
          staffInfo: userInfo,
          fundBalance: fundBalanceMap[valid.journalLine.series],
          amount: valid.journalLine.debit,
          paidAt: valid.journalLine.date,
        ),
      );
    }

    return expenses;
  }

  @override
  Future<EventExpenseModel> insertExpenseSettledByStaff(
    EventExpenseParams params,
  ) async {
    if (params.staffInfo == null) {
      StateError('مشخصات کاربر نمیتواند خالی باشد!');
    }
    late ({int id, String name, int accountID}) eventInfo;
    late ({int id, String name, int accountID}) staffInfo;

    final subsidiariesMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();
    final eventAccount = await _accountsDao.fetchEventAccount(
      params.eventInfo.id,
    );
    eventInfo = (
      id: params.eventInfo.id,
      name: params.eventInfo.name,
      accountID: eventAccount.id,
    );

    final staffAccount = await _accountsDao.fetchUserAccount(
      params.staffInfo!.id,
    );

    staffInfo = (
      id: params.staffInfo!.id,
      name: params.staffInfo!.name,
      accountID: staffAccount.id,
    );

    final expenseJournals =
        RecordExpensesJournalsHelper.identificationExpenseSettledByStaff(
          subsidiaryAccountsMap: subsidiariesMap,
          expenseSubsidiaryType: params.subsidiaryAccountType,
          staffInfo: staffInfo,
          eventInfo: eventInfo,
          amount: params.amount,
          paidAt: params.paidAt,
        );

    await _journalsDao.insertJournal(
      JournalParams(
        date: params.paidAt,
        lines: expenseJournals,
        headerID: null,
        description:
            'بابت پرداخت ${params.subsidiaryAccountType.title} توسط ${params.staffInfo!.name}',
      ),
    );

    return EventExpenseModel(
      subsidiaryAccountType: params.subsidiaryAccountType,
      bankInfo: null,
      eventInfo: params.eventInfo,
      staffInfo: params.staffInfo,
      fundBalance: null,
      amount: params.amount,
      paidAt: params.paidAt,
      series: expenseJournals.first.series.value,
    );
  }

  @override
  Future<EventExpenseModel> insertExpenseSettledByBank(
    EventExpenseParams params,
  ) async {
    if (params.bankInfo == null) {
      StateError('مشخصات بانک نمیتواند خالی باشد!');
    }
    late ({int id, String name, int accountID}) eventInfo;
    late ({int id, String name, int accountID}) bankInfo;

    final subsidiariesMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();
    final eventAccount = await _accountsDao.fetchEventAccount(
      params.eventInfo.id,
    );
    eventInfo = (
      id: params.eventInfo.id,
      name: params.eventInfo.name,
      accountID: eventAccount.id,
    );

    final bankAccount = await _accountsDao.fetchBankAccount(
      params.bankInfo!.id,
    );

    bankInfo = (
      id: params.bankInfo!.id,
      name: params.bankInfo!.name,
      accountID: bankAccount.id,
    );

    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'expEVN${eventInfo.accountID}BNK${bankInfo.accountID}',
    );
    final memo =
        'بابت پرداخت ${params.subsidiaryAccountType.title} ایونت ${params.eventInfo.name} از بانک ${params.bankInfo!.name}';

    if (params.fundInfo != null) {
      await _fundBalancesDao.insertBalance(
        FundBalanceParams(
          fundID: params.fundInfo!.id,
          series: series,
          memo: memo,
          date: params.paidAt,
          debit: BigInt.zero,
          credit: params.amount,
        ),
      );
    }

    final expenseJournals =
        RecordExpensesJournalsHelper.identificationEventExpenseWithDirectPayment(
          subsidiaryAccountsMap: subsidiariesMap,
          expenseSubsidiaryType: params.subsidiaryAccountType,
          bankInfo: bankInfo,
          eventInfo: eventInfo,
          amount: params.amount,
          transferFee: params.transferFee,
          series: series,
          paidAt: params.paidAt,
        );

    if (params.transferFee != null) {
      final transferFeeLine =
          RecordTransferringJournalsHelper.registerTransferFeeNotIndependently(
            subsidiaryAccountsMap: subsidiariesMap,
            bankInfo: bankInfo,
            eventInfo: eventInfo,
            transferFee: params.transferFee!,
            series: series,
            paidAt: params.paidAt,
          );

      expenseJournals.add(transferFeeLine);
    }

    await _journalsDao.insertJournal(
      JournalParams(
        date: params.paidAt,
        lines: expenseJournals,
        headerID: null,
        description: 'بابت پرداخت ${params.subsidiaryAccountType.title}',
      ),
    );

    final fundInfo = await _fundBalancesDao.fetchFundBalanceBySeries(series);
    final fundBalance = fundInfo == null
        ? null
        : FundBalanceModel(
            id: fundInfo.balanceInfo.id,
            title: fundInfo.fund.title,
            debit: fundInfo.balanceInfo.debit,
            credit: fundInfo.balanceInfo.credit,
            date: fundInfo.balanceInfo.date,
            series: series,
          );

    return EventExpenseModel(
      subsidiaryAccountType: params.subsidiaryAccountType,
      bankInfo: params.bankInfo,
      eventInfo: params.eventInfo,
      staffInfo: null,
      fundBalance: fundBalance,
      amount: params.amount,
      paidAt: params.paidAt,
      series: series,
    );
  }

  @override
  Future<int> deleteExpense(String series) async {
    await _fundBalancesDao.deleteBalance(series);
    return await _journalsDao.deleteJournalsLines(series);
  }
}
