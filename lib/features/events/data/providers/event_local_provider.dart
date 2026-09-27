import 'package:collection/collection.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/detailed_account_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_params.dart';
import 'package:pay_pilot_plus/core/data/params/fund_allocation_params.dart';
import 'package:pay_pilot_plus/core/data/params/fund_balance_params.dart';
import 'package:pay_pilot_plus/core/data/params/journal_params.dart';
import 'package:pay_pilot_plus/core/data/params/member_allocation_params.dart';
import 'package:pay_pilot_plus/core/data/params/user_salary_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/events/events_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/fund_allocations/fund_allocations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/fund_balances/fund_balances_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/member_allocations/member_allocations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/team_funds/team_funds_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/team_members/team_members_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/teams/teams_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/core/utils/helpers/journal_lines_series_helper.dart';
import 'package:pay_pilot_plus/core/utils/helpers/record_entrance_fee_journals_helper.dart';
import 'package:pay_pilot_plus/core/utils/helpers/record_salaries_journals_helper.dart';
import 'package:pay_pilot_plus/features/events/data/sources/i_event_source.dart';

abstract class IEventLocalProvider
    implements
        IEventSource<
          EventModel,
          int,
          List<EventModel>,
          List<TeamModel>,
          List<UserModel>
        > {}

class EventLocalProvider implements IEventLocalProvider {
  final EventsDao _eventsDao;
  final JournalsDao _journalsDao;
  final SubsidiaryAccountsDao _subsidiaryAccountsDao;
  final DetailedAccountsDao _accountsDao;
  final TeamMembersDao _teamMembersDao;
  final TeamFundsDao _teamFundsDao;
  final MemberAllocationsDao _memberAllocationsDao;
  final FundAllocationsDao _fundAllocationsDao;
  final TeamsDao _teamsDao;
  final UsersDao _usersDao;
  final FundBalancesDao _fundBalancesDao;

  EventLocalProvider(
    this._eventsDao,
    this._journalsDao,
    this._subsidiaryAccountsDao,
    this._accountsDao,
    this._teamMembersDao,
    this._teamFundsDao,
    this._memberAllocationsDao,
    this._fundAllocationsDao,
    this._teamsDao,
    this._usersDao,
    this._fundBalancesDao,
  );

  @override
  Future<int> archiveEvent(int id) async {
    return _eventsDao.archiveEvent(id);
  }

  @override
  Future<int> closeEvent(EventParams params) async {
    final subsidiaryMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();

    final eventProfit = await _calculateProfit(params.id!);
    final usersSalary = await _calculateUsersSalary(params.id!, eventProfit);
    final usersAccount = await _accountsDao.fetchAllUserAccounts();
    final eventAccount = await _accountsDao.fetchEventAccount(params.id!);

    final fundAllocations = await _fundAllocationsDao.fetchAllFundRatios(
      params.id!,
    );
    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'salEVN${eventAccount.id}',
    );

    for (var allocation in fundAllocations) {
      final allocationAmount =
          (eventProfit *
              BigInt.from(allocation.fundAllocation.sharePercentage)) ~/
          BigInt.from(100);

      await _fundBalancesDao.insertBalance(
        FundBalanceParams(
          fundID: allocation.fund.id,
          series: series,
          memo: 'بابت حقوق رویداد ${params.title}',
          date: params.date,
          credit: BigInt.zero,
          debit: allocationAmount,
        ),
      );
    }

    final journalLines = await RecordSalariesJournalsHelper.submitSalaries(
      subsidiaryMap,
      usersAccount,
      usersSalary,
      eventProfit,
      params.title,
      eventAccount.id,
      series,
    );

    await _journalsDao.insertJournal(
      JournalParams(
        date: params.date,
        lines: journalLines,
        description: 'بابت شناسایی حقوق اعضا در رویداد ${params.title}',
      ),
    );

    return await _eventsDao.closeEvent(params.id!);
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
        entranceFee: event.entranceFee,
        snacksFee: event.snacksFee,
        detailedAccountInfo: (
          id: account.id,
          name: account.name,
          code: account.code,
        ),
        teamInfo: (id: team.id, name: team.title),
        hostInfo: (id: user.id, name: user.name),
      );
    }).toList();
  }

  @override
  Future<List<TeamModel>> fetchAllTeams() async {
    final teams = await _teamsDao.fetchAllActiveTeams();

    return teams.map((e) {
      return TeamModel(
        id: e.id,
        title: e.title,
        description: e.description,
        isActive: e.isActive,
      );
    }).toList();
  }

  @override
  Future<EventModel> insertEvent(EventParams params) async {
    final eventID = await _eventsDao.insertEvent(params);
    await _insertMembersAllocations(eventID, params);
    await _insertFundsAllocations(eventID, params);

    final accountParams = DetailedAccountParams(
      id: null,
      attachmentID: eventID,
      name: params.title.trim(),
      type: .event,
    );
    final newAccount = await _accountsDao.insertAccount(accountParams);

    await _insertEventEntranceJournals(params, eventID, newAccount.id);

    return EventModel(
      id: eventID,
      title: params.title.trim(),
      date: params.date,
      isClosed: false,
      entranceFee: params.entranceFee,
      snacksFee: params.snacksFee,
      detailedAccountInfo: (
        id: newAccount.id,
        name: params.title.trim(),
        code: newAccount.code,
      ),
      teamInfo: params.teamInfo,
      hostInfo: params.hostInfo,
    );
  }

  @override
  Future<int> openEvent(int id) async {
    final eventAccountID = (await _accountsDao.fetchEventAccount(id)).id;

    final salaryID = (await _subsidiaryAccountsDao.fetchSubsidiaryAccount(
      .salaryExpense,
    )).id;

    final journalLinesInfo = await _journalsDao.fetchJournals(
      firstDetailedId: eventAccountID,
      subsidiaryID: salaryID,
    );

    await _journalsDao.deleteJournalHeader(journalLinesInfo.first.headerId);
    await _fundBalancesDao.deleteBalance(journalLinesInfo.first.series);

    return await _eventsDao.openEvent(id);
  }

  @override
  Future<EventModel> updateEvent(EventParams params) async {
    final prevTeam = (await _eventsDao.fetchEvent(params.id!)).teamID;

    if (prevTeam != params.teamInfo.id) {
      await _memberAllocationsDao.deleteAllMemberRatiosByEvent(params.id!);
      await _fundAllocationsDao.deleteAllFundRatiosByEvent(params.id!);
      await _insertMembersAllocations(params.id!, params);
      await _insertFundsAllocations(params.id!, params);
    }

    await _eventsDao.updateEvent(params);

    final account = await _accountsDao.fetchEventAccount(params.id!);

    await _updateEventEntranceJournals(params, account.id);

    return EventModel(
      id: params.id!,
      title: params.title.trim(),
      date: params.date,
      isClosed: params.isClosed,
      entranceFee: params.entranceFee,
      snacksFee: params.snacksFee,
      detailedAccountInfo: (
        id: account.id,
        name: params.title.trim(),
        code: account.code,
      ),
      teamInfo: params.teamInfo,
      hostInfo: params.hostInfo,
    );
  }

  Future<void> _updateEventEntranceJournals(
    EventParams params,
    int eventAccountID,
  ) async {
    if (params.entranceFee <= BigInt.zero) return;

    final subsidiaryMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();

    final hostAccount = await _accountsDao.fetchUserAccount(params.hostInfo.id);

    final expenseID = subsidiaryMap[SubsidiaryAccountType.entranceExpenses]!.id;

    final entranceHeader = await _journalsDao.fetchJournalLinesBySubsidiaryId(
      subsidiaryID: expenseID,
      firstDetailedID: eventAccountID,
      secondDetailedID: hostAccount.id,
    );

    if (entranceHeader.isNotEmpty) {
      await _journalsDao.deleteJournalsLines(
        entranceHeader.first.journalLine.series,
      );
    }

    final journalLines = RecordEntranceFeeJournalsHelper.insertEvent(
      entranceFee: params.entranceFee,
      eventInfo: (
        id: params.id!,
        name: params.title.trim(),
        accountID: eventAccountID,
      ),
      hostInfo: (
        id: params.hostInfo.id,
        name: params.hostInfo.name,
        accountID: hostAccount.id,
      ),
      subsidiaryAccountsMap: subsidiaryMap,
    );

    await _journalsDao.insertJournal(
      JournalParams(
        date: params.date,
        lines: journalLines,
        description: 'بابت شناسایی هزینه ورودی رویداد ${params.title}',
      ),
    );
  }

  Future<void> _insertEventEntranceJournals(
    EventParams params,
    int eventID,
    int eventAccountID,
  ) async {
    if (params.entranceFee <= BigInt.zero) return;

    final subsidiaryMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();

    final hostAccount = await _accountsDao.fetchUserAccount(params.hostInfo.id);

    final journalLines = RecordEntranceFeeJournalsHelper.insertEvent(
      entranceFee: params.entranceFee,
      eventInfo: (
        id: eventID,
        name: params.title.trim(),
        accountID: eventAccountID,
      ),
      hostInfo: (
        id: params.hostInfo.id,
        name: params.hostInfo.name,
        accountID: hostAccount.id,
      ),
      subsidiaryAccountsMap: subsidiaryMap,
    );

    await _journalsDao.insertJournal(
      JournalParams(
        date: params.date,
        lines: journalLines,
        description: 'بابت شناسایی هزینه ورودی رویداد ${params.title}',
      ),
    );
  }

  Future<void> _insertMembersAllocations(
    int eventID,
    EventParams params,
  ) async {
    final teamMembers = await _teamMembersDao.fetchAllTeamMembers(
      params.teamInfo.id,
    );
    final partnerShareParams = MemberAllocationParams(
      id: null,
      eventInfo: (id: eventID, name: params.title),
      usersInfo: teamMembers.map((e) {
        return (
          id: e.user.id,
          name: e.user.name,
          ratio: e.member.sharePercentage,
        );
      }).toList(),
    );

    await _memberAllocationsDao.insertMultiMemberRatio(partnerShareParams);
  }

  Future<void> _insertFundsAllocations(int eventID, EventParams params) async {
    final fundRatios = await _teamFundsDao.fetchAllTeamFunds(
      params.teamInfo.id,
    );
    final allocationParams = FundAllocationParams(
      id: null,
      eventInfo: (id: eventID, name: params.title),
      fundsInfo: fundRatios.map((e) {
        return (
          id: e.fund.id,
          name: e.fund.title,
          ratio: e.teamFund.sharePercentage,
        );
      }).toList(),
    );

    await _fundAllocationsDao.insertMultiFundRatio(allocationParams);
  }

  Future<BigInt> _calculateProfit(int eventID) async {
    final subsidiaryMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();

    final eventAccount = await _accountsDao.fetchEventAccount(eventID);
    final eventJournals = await _journalsDao.fetchJournals(
      firstDetailedId: eventAccount.id,
      subsidiaryID: null,
    );

    final revenueID = subsidiaryMap[SubsidiaryAccountType.eventRevenue]?.id;
    final discountsID = subsidiaryMap[SubsidiaryAccountType.saleDiscounts]?.id;
    final entranceExpenseID =
        subsidiaryMap[SubsidiaryAccountType.entranceExpenses]?.id;
    final snacksExpenseID =
        subsidiaryMap[SubsidiaryAccountType.snacksExpenses]?.id;

    final eventProfit = eventJournals.fold<BigInt>(BigInt.zero, (sum, journal) {
      if (journal.subsidiaryId == revenueID) return sum + journal.credit;
      if (journal.subsidiaryId == entranceExpenseID) return sum - journal.debit;
      if (journal.subsidiaryId == snacksExpenseID) return sum - journal.debit;
      if (journal.subsidiaryId == discountsID) return sum - journal.debit;

      return sum;
    });

    return eventProfit;
  }

  Future<List<UserSalaryParams>> _calculateUsersSalary(
    int eventID,
    BigInt eventProfit,
  ) async {
    final usersSalary = <UserSalaryParams>[];

    final partnerShares = await _memberAllocationsDao.fetchAllMemberRatios(
      eventID,
    );

    for (var partner in partnerShares) {
      final userProfit =
          (eventProfit *
              BigInt.from(partner.memberAllocation.sharePercentage)) ~/
          BigInt.from(100);

      usersSalary.add(
        UserSalaryParams(
          userInfo: (id: partner.user.id, name: partner.user.name),
          salary: userProfit,
        ),
      );
    }

    return usersSalary;
  }

  @override
  Future<List<UserModel>> fetchAllHosts() async {
    final users = await _usersDao.fetchAllActiveLandlords();
    final openingLines = await _journalsDao.fetchAllOpeningJournals();

    return users.map((e) {
      final openingInfo = openingLines?.firstWhereOrNull((j) {
        return j.firstDetailedId == e.account.id && j.credit != BigInt.zero;
      });

      return UserModel(
        id: e.user.id,
        name: e.user.name,
        description: e.user.description,
        phoneNumber: e.user.phoneNumber,
        isActive: e.user.isActive,
        profileImage: e.user.profileImage,
        telegramID: e.user.telegramId,
        instagramID: e.user.instagramId,
        birthday: e.user.birthday,
        role: e.user.role,
        openingBalance: openingInfo?.credit ?? BigInt.zero,
        detailedAccountInfo: (
          id: e.account.id,
          code: e.account.code,
          name: e.account.name,
        ),
      );
    }).toList();
  }
}
