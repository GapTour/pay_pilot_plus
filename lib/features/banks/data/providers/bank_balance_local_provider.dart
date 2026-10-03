import 'package:pay_pilot_plus/core/data/models/detailed_account_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_balance_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/data/models/subsidiary_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/bank_balance_params.dart';
import 'package:pay_pilot_plus/core/data/params/fund_balance_params.dart';
import 'package:pay_pilot_plus/core/data/params/journal_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart'
    show JournalLinesCompanion, SubsidiaryAccountType;
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/events/events_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/fund_balances/fund_balances_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/funds/funds_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/core/utils/helpers/record_transferring_journals_helper.dart';
import 'package:pay_pilot_plus/core/utils/resources/calculate_sum_on_background_thread.dart';
import 'package:pay_pilot_plus/features/banks/data/sources/i_bank_balance_source.dart';

abstract class IBankBalanceLocalProvider
    implements
        IBankBalanceSource<
          List<JournalLineModel>,
          BigInt,
          List<({FundModel fund, List<FundBalanceModel> fundBalances})>,
          JournalLineModel?,
          List<UserModel>,
          List<FundModel>,
          List<EventModel>
        > {}

class BankBalanceLocalProvider implements IBankBalanceLocalProvider {
  final JournalsDao _journalsDao;
  final SubsidiaryAccountsDao _subsidiaryAccountsDao;
  final FundBalancesDao _fundBalancesDao;
  final DetailedAccountsDao _detailedAccountsDao;
  final UsersDao _usersDao;
  final FundsDao _fundsDao;
  final EventsDao _eventsDao;

  BankBalanceLocalProvider(
    this._subsidiaryAccountsDao,
    this._fundBalancesDao,
    this._journalsDao,
    this._detailedAccountsDao,
    this._usersDao,
    this._fundsDao,
    this._eventsDao,
  );

  @override
  Future<List<JournalLineModel>> fetchBankBalance(int bankAccountID) async {
    final bankSubsidiaryAccount = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccount(.bank);

    final journalLines = await _journalsDao.fetchJournalLinesBySubsidiaryId(
      subsidiaryID: bankSubsidiaryAccount.id,
      firstDetailedID: bankAccountID,
    );

    return journalLines.map((e) {
      final line = e.journalLine;
      final subAccount = e.subAccount;
      final group = e.group;
      final general = e.general;

      final detailed1 = e.detailed1;
      final detailed2 = e.detailed2;

      final subsidiaryModel = SubsidiaryModel(
        id: subAccount.id,
        accountGroup: (id: group.id, type: group.type),
        generalAccount: (id: general.id, type: general.type),
        type: subAccount.type,
      );

      DetailedAccountModel? firstDetailedModel;
      if (detailed1 != null) {
        firstDetailedModel = DetailedAccountModel(
          id: detailed1.id,
          code: detailed1.code,
          name: detailed1.name,
          type: detailed1.type,
          isActive: detailed1.isActive,
          userInfo: detailed1.userID != null
              ? (id: detailed1.userID!, name: '')
              : null,
          eventInfo: detailed1.eventID != null
              ? (id: detailed1.eventID!, name: '')
              : null,
          bankInfo: detailed1.bankID != null
              ? (id: detailed1.bankID!, name: '')
              : null,
        );
      }

      DetailedAccountModel? secondDetailedModel;
      if (detailed2 != null) {
        secondDetailedModel = DetailedAccountModel(
          id: detailed2.id,
          code: detailed2.code,
          name: detailed2.name,
          type: detailed2.type,
          isActive: detailed2.isActive,
          userInfo: detailed2.userID != null
              ? (id: detailed2.userID!, name: '')
              : null,
          eventInfo: detailed2.eventID != null
              ? (id: detailed2.eventID!, name: '')
              : null,
          bankInfo: detailed2.bankID != null
              ? (id: detailed2.bankID!, name: '')
              : null,
        );
      }

      return JournalLineModel(
        id: line.id,
        headerID: line.headerId,
        subsidiaryAccount: subsidiaryModel,
        firstDetailedInfo: firstDetailedModel,
        secondDetailedInfo: secondDetailedModel,
        debit: line.debit,
        credit: line.credit,
        series: line.series,
        memo: line.memo,
      );
    }).toList();
  }

  @override
  Future<BigInt> calculateRemaining(List<JournalLineModel> journalLines) async {
    final debitSets = journalLines.map((e) => e.debit).toList();
    final debitAmounts = await calculateSumOnBackgroundThread(debitSets);

    final creditSets = journalLines.map((e) => e.credit).toList();
    final creditAmounts = await calculateSumOnBackgroundThread(creditSets);

    return debitAmounts - creditAmounts;
  }

  @override
  Future<BigInt> calculateFundsRemaining({
    required BigInt openingBalance,
    required List<FundBalanceModel> fundBalances,
  }) async {
    final debitSets = fundBalances.map((e) => e.debit).toList();
    final debitAmounts = await calculateSumOnBackgroundThread(debitSets);

    final creditSets = fundBalances.map((e) => e.credit).toList();
    final creditAmounts = await calculateSumOnBackgroundThread(creditSets);

    return openingBalance + debitAmounts - creditAmounts;
  }

  @override
  Future<List<({FundModel fund, List<FundBalanceModel> fundBalances})>>
  fetchAllFundsBalance() async {
    final allFunds =
        <({FundModel fund, List<FundBalanceModel> fundBalances})>[];
    final results = await _fundBalancesDao.fetchAllBalances();

    for (var r in results) {
      final balances = r.balances.map((e) {
        return FundBalanceModel(
          id: e.id,
          debit: e.debit,
          title: r.fund.title,
          credit: e.credit,
          date: e.date,
          series: e.series,
          memo: e.memo,
        );
      }).toList();
      final fundInfo = FundModel(
        id: r.fund.id,
        title: r.fund.title,
        openingBalance: r.fund.openingBalance,
        isActive: r.fund.isActive,
      );

      allFunds.add((fundBalances: balances, fund: fundInfo));
    }

    return allFunds;
  }

  @override
  Future<JournalLineModel?> payTo(BankBalanceParams params) async {
    final subsidiaryAccounts = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();
    final detailedAccounts = await _detailedAccountsDao.fetchAllAccounts();
    final user = await _usersDao.fetchUser(params.userInfo.id);
    if (user.role.isGuest) return null;

    final bankInfo = (
      id: params.bankInfo.id,
      name: params.bankInfo.name,
      accountID: detailedAccounts
          .firstWhere((e) => e.bankID == params.bankInfo.id)
          .id,
    );
    final eventInfo = params.eventInfo == null
        ? null
        : (
            id: params.eventInfo!.id,
            name: params.eventInfo!.name,
            accountID: detailedAccounts
                .firstWhere((e) => e.eventID == params.eventInfo!.id)
                .id,
          );
    final userInfo = (
      id: params.userInfo.id,
      name: params.userInfo.name,
      accountID: detailedAccounts
          .firstWhere((e) => e.userID == params.userInfo.id)
          .id,
    );

    final generatedJournalLines = <JournalLinesCompanion>[];

    if (user.role.isHost) {
      final journalLinesForHost =
          RecordTransferringJournalsHelper.registerPaymentToHost(
            subsidiaryAccountsMap: subsidiaryAccounts,
            bankInfo: bankInfo,
            eventInfo: eventInfo,
            hostInfo: userInfo,
            transferFee: params.transferFee,
            paidAmount: params.amount,
          );
      generatedJournalLines.addAll(journalLinesForHost);
    }

    if (user.role.isStaff) {
      final journalLinesForStaff =
          RecordTransferringJournalsHelper.registerPaymentToStaff(
            subsidiaryAccountsMap: subsidiaryAccounts,
            bankInfo: bankInfo,
            eventInfo: eventInfo,
            staffInfo: userInfo,
            transferFee: params.transferFee,
            paidAmount: params.amount,
          );
      generatedJournalLines.addAll(journalLinesForStaff);
    }

    final headerID = await _journalsDao.insertJournal(
      JournalParams(
        date: params.paidAt,
        noticeMemo: params.noticeMemo,
        lines: generatedJournalLines,
        headerID: null,
        description:
            'بابت ثبت پرداختی از بانک ${params.bankInfo.name} به ${params.userInfo.name}',
      ),
    );

    if (params.fundInfo != null) {
      await _fundBalancesDao.insertBalance(
        FundBalanceParams(
          fundID: params.fundInfo!.id,
          series: generatedJournalLines.first.series.value,
          memo: generatedJournalLines.first.memo.value,
          date: params.paidAt,
          debit: BigInt.zero,
          credit: params.amount,
        ),
      );
    }

    final response = await _journalsDao.fetchJournalLinesByHeaderId(headerID);

    final recordedBankJournal = response.firstWhere((w) {
      return w.journalLine.credit == (params.amount + params.transferFee) &&
          w.subAccount.type == SubsidiaryAccountType.bank;
    });

    return JournalLineModel(
      id: recordedBankJournal.journalLine.id,
      headerID: headerID,
      subsidiaryAccount: SubsidiaryModel(
        id: recordedBankJournal.subAccount.id,
        accountGroup: (
          id: recordedBankJournal.group.id,
          type: recordedBankJournal.group.type,
        ),
        generalAccount: (
          id: recordedBankJournal.general.id,
          type: recordedBankJournal.general.type,
        ),
        type: recordedBankJournal.subAccount.type,
      ),
      firstDetailedInfo: DetailedAccountModel(
        id: recordedBankJournal.detailed1!.id,
        code: recordedBankJournal.detailed1!.code,
        name: recordedBankJournal.detailed1!.name,
        type: recordedBankJournal.detailed1!.type,
        isActive: recordedBankJournal.detailed1!.isActive,
        userInfo: null,
        eventInfo: null,
        bankInfo: (id: recordedBankJournal.detailed1!.bankID!, name: ''),
      ),
      secondDetailedInfo: DetailedAccountModel(
        id: recordedBankJournal.detailed2!.id,
        code: recordedBankJournal.detailed2!.code,
        name: recordedBankJournal.detailed2!.name,
        type: recordedBankJournal.detailed2!.type,
        isActive: recordedBankJournal.detailed2!.isActive,
        userInfo: (id: recordedBankJournal.detailed2!.userID!, name: ''),
        eventInfo: null,
        bankInfo: null,
      ),
      debit: recordedBankJournal.journalLine.debit,
      credit: recordedBankJournal.journalLine.credit,
      series: recordedBankJournal.journalLine.series,
    );
  }

  @override
  Future<JournalLineModel?> receiveFrom(BankBalanceParams params) async {
    final subsidiaryAccounts = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();
    final detailedAccounts = await _detailedAccountsDao.fetchAllAccounts();
    final user = await _usersDao.fetchUser(params.userInfo.id);
    if (user.role.isGuest) return null;

    final bankInfo = (
      id: params.bankInfo.id,
      name: params.bankInfo.name,
      accountID: detailedAccounts
          .firstWhere((e) => e.bankID == params.bankInfo.id)
          .id,
    );
    final eventInfo = params.eventInfo == null
        ? null
        : (
            id: params.eventInfo!.id,
            name: params.eventInfo!.name,
            accountID: detailedAccounts
                .firstWhere((e) => e.eventID == params.eventInfo!.id)
                .id,
          );
    final userInfo = (
      id: params.userInfo.id,
      name: params.userInfo.name,
      accountID: detailedAccounts
          .firstWhere((e) => e.userID == params.userInfo.id)
          .id,
    );

    final generatedJournalLines = <JournalLinesCompanion>[];
    if (user.role.isHost) {
      final journalLinesForHost =
          RecordTransferringJournalsHelper.registerPaymentFromHost(
            subsidiaryAccountsMap: subsidiaryAccounts,
            bankInfo: bankInfo,
            eventInfo: eventInfo,
            hostInfo: userInfo,
            paidAmount: params.amount,
          );
      generatedJournalLines.addAll(journalLinesForHost);
    }
    if (user.role.isStaff) {
      final journalLinesForStaff =
          RecordTransferringJournalsHelper.registerPaymentFromStaff(
            subsidiaryAccountsMap: subsidiaryAccounts,
            bankInfo: bankInfo,
            eventInfo: eventInfo,
            staffInfo: userInfo,
            paidAmount: params.amount,
          );
      generatedJournalLines.addAll(journalLinesForStaff);
    }

    final headerID = await _journalsDao.insertJournal(
      JournalParams(
        date: params.paidAt,
        noticeMemo: params.noticeMemo,
        lines: generatedJournalLines,
        headerID: null,
        description:
            'بابت ثبت دریافتی به بانک ${params.bankInfo.name} از ${params.userInfo.name}',
      ),
    );

    if (params.fundInfo != null) {
      await _fundBalancesDao.insertBalance(
        FundBalanceParams(
          fundID: params.fundInfo!.id,
          series: generatedJournalLines.first.series.value,
          memo: generatedJournalLines.first.memo.value,
          date: params.paidAt,
          debit: params.amount,
          credit: BigInt.zero,
        ),
      );
    }

    final response = await _journalsDao.fetchJournalLinesByHeaderId(headerID);

    final recordedBankJournal = response.firstWhere((w) {
      return w.journalLine.debit == params.amount &&
          w.subAccount.type == SubsidiaryAccountType.bank;
    });

    return JournalLineModel(
      id: recordedBankJournal.journalLine.id,
      headerID: headerID,
      subsidiaryAccount: SubsidiaryModel(
        id: recordedBankJournal.subAccount.id,
        accountGroup: (
          id: recordedBankJournal.group.id,
          type: recordedBankJournal.group.type,
        ),
        generalAccount: (
          id: recordedBankJournal.general.id,
          type: recordedBankJournal.general.type,
        ),
        type: recordedBankJournal.subAccount.type,
      ),
      firstDetailedInfo: DetailedAccountModel(
        id: recordedBankJournal.detailed1!.id,
        code: recordedBankJournal.detailed1!.code,
        name: recordedBankJournal.detailed1!.name,
        type: recordedBankJournal.detailed1!.type,
        isActive: recordedBankJournal.detailed1!.isActive,
        userInfo: null,
        eventInfo: null,
        bankInfo: (id: recordedBankJournal.detailed1!.bankID!, name: ''),
      ),
      secondDetailedInfo: DetailedAccountModel(
        id: recordedBankJournal.detailed2!.id,
        code: recordedBankJournal.detailed2!.code,
        name: recordedBankJournal.detailed2!.name,
        type: recordedBankJournal.detailed2!.type,
        isActive: recordedBankJournal.detailed2!.isActive,
        userInfo: (id: recordedBankJournal.detailed2!.userID!, name: ''),
        eventInfo: null,
        bankInfo: null,
      ),
      debit: recordedBankJournal.journalLine.debit,
      credit: recordedBankJournal.journalLine.credit,
      series: recordedBankJournal.journalLine.series,
      memo: recordedBankJournal.journalLine.memo,
    );
  }

  @override
  Future<List<UserModel>> fetchAllUsers() async {
    final result = await _usersDao.fetchAllActiveUsers();

    return result.map((e) {
      final user = e.user;
      final account = e.account;

      return UserModel(
        id: user.id,
        detailedAccountInfo: (
          id: account.id,
          code: account.code,
          name: account.name,
        ),
        openingBalance: BigInt.zero,
        name: user.name,
        description: user.description,
        phoneNumber: user.phoneNumber,
        isActive: user.isActive,
        profileImage: user.profileImage,
        telegramID: user.telegramId,
        instagramID: user.instagramId,
        birthday: user.birthday,
        role: user.role,
      );
    }).toList();
  }

  @override
  Future<List<FundModel>> fetchAllFunds() async {
    final result = await _fundsDao.fetchAllActiveFunds();

    return result.map((e) {
      return FundModel(
        id: e.id,
        title: e.title,
        openingBalance: BigInt.zero,
        isActive: e.isActive,
      );
    }).toList();
  }

  @override
  Future<List<EventModel>> fetchAllEvents() async {
    final result = await _eventsDao.fetchAllActiveEvents();

    return result.map((e) {
      final event = e.event;
      final account = e.account;
      final team = e.team;
      final user = e.user;

      return EventModel(
        id: event.id,
        title: event.title,
        date: event.date,
        isClosed: event.isClosed,
        detailedAccountInfo: (
          id: account.id,
          name: account.name,
          code: account.code,
        ),
        entranceFee: e.event.entranceFee,
        snacksFee: e.event.snacksFee,
        teamInfo: (id: team.id, name: team.title),
        hostInfo: (id: user.id, name: user.name),
      );
    }).toList();
  }
}
