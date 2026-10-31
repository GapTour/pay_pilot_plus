import 'package:collection/collection.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/close_event_params.dart';
import 'package:pay_pilot_plus/core/data/params/detailed_account_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_params.dart';
import 'package:pay_pilot_plus/core/data/params/fund_allocation_params.dart';
import 'package:pay_pilot_plus/core/data/params/fund_balance_params.dart';
import 'package:pay_pilot_plus/core/data/params/journal_params.dart';
import 'package:pay_pilot_plus/core/data/params/member_allocation_params.dart';
import 'package:pay_pilot_plus/core/data/params/snacks_fee_assignment_params.dart';
import 'package:pay_pilot_plus/core/data/params/user_salary_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_registrations/event_registrations_dao.dart';
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
import 'package:pay_pilot_plus/core/utils/helpers/record_expenses_journals_helper.dart';
import 'package:pay_pilot_plus/core/utils/helpers/record_salaries_journals_helper.dart';
import 'package:pay_pilot_plus/features/events/data/sources/i_event_source.dart';

abstract class IEventLocalProvider
    implements
        IEventSource<
          EventModel,
          int,
          List<EventModel>,
          List<TeamModel>,
          List<UserModel>,
          List<int>
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
  final EventRegistrationsDao _registrationsDao;

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
    this._registrationsDao,
  );

  @override
  Future<int> archiveEvent(int id) async {
    // همه مراحل در یک تراکنش تا شکست هر مرحله، مراحل قبلی را هم برگرداند
    return _eventsDao.transaction(() async {
      return _eventsDao.archiveEvent(id);
    });
  }

  @override
  Future<int> closeEvent(CloseEventParams params) async {
    final subsidiaryMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();

    final allDetailedAccounts = await _accountsDao.fetchAllAccounts();

    final staffsInfo = params.staffsInfo.map((s) {
      final staffAccount = allDetailedAccounts.firstWhere(
        (element) => element.userID == s.id,
      );
      return (id: s.id, name: s.name, accountID: staffAccount.id);
    }).toList();
    final hostInfo = (
      id: params.hostInfo.id,
      name: params.hostInfo.name,
      accountID: allDetailedAccounts
          .firstWhere((element) => element.userID == params.hostInfo.id)
          .id,
    );
    final eventInfo = (
      id: params.id,
      name: params.title,
      accountID: allDetailedAccounts
          .firstWhere((element) => element.eventID == params.id)
          .id,
    );
    final allRegisteredGuests = await _registrationsDao.fetchAllRegistrations(
      params.id,
    );
    final allAssignmentsToFund = allRegisteredGuests.where(
      (w) =>
          w.snacksAssignmentFund != null &&
          w.registration.snacksFeeAssignmentStatus.isAssignmentToFund,
    );
    final series = JournalLinesSeriesHelper.generateSeries(
      extra: 'clsEVN${eventInfo.accountID}HST${hostInfo.accountID}',
    );

    await _identificationEventSnacksExpenses(
      subsidiaryMap: subsidiaryMap,
      eventInfo: eventInfo,
      hostInfo: hostInfo,
      staffsInfo: staffsInfo,
      snacksFee: params.snacksFee,
      totalRegisteredGuestsNumber: params.totalRegisteredGuestsNumber,
      series: series,
      date: params.date,
      snacksAssignmentsParams: allRegisteredGuests
          .where(
            (w) => w.registration.snacksFeeAssignmentStatus.isAssignmentToStaff,
          )
          .map((e) {
            final guestInfo = (
              id: e.guest.id,
              name: e.guest.name,
              accountID: allDetailedAccounts
                  .firstWhere((element) => element.userID == e.guest.id)
                  .id,
            );

            final snacksAssignmentInfo = (
              id: e.snacksAssignmentUser!.id,
              name: e.snacksAssignmentUser!.name,
              accountID: allDetailedAccounts
                  .firstWhere(
                    (element) => element.userID == e.snacksAssignmentUser!.id,
                  )
                  .id,
            );
            return SnacksFeeAssignmentParams(
              snacksAssignmentInfo: snacksAssignmentInfo,
              guestInfo: guestInfo,
              snacksAssignmentStatus: e.registration.snacksFeeAssignmentStatus,
            );
          })
          .toList(),
    );
    await _identificationEventEntranceExpenses(
      subsidiaryMap: subsidiaryMap,
      eventInfo: eventInfo,
      hostInfo: hostInfo,
      entranceFee: params.entranceFee,
      series: series,
      date: params.date,
    );
    for (var assignToFund in allAssignmentsToFund) {
      await _fundBalancesDao.insertBalance(
        FundBalanceParams(
          fundID: assignToFund.registration.snacksAssignmentFundID!,
          series: series,
          memo:
              'بابت کسر هزینه پذیرایی ${assignToFund.guest.name} رویداد ${eventInfo.name} توسط (${hostInfo.name})',
          date: assignToFund.registration.registeredAt,
          credit: params.snacksFee,
          debit: BigInt.zero,
        ),
      );
    }
    final eventProfit = await _calculateProfit(
      subsidiaryMap: subsidiaryMap,
      eventInfo: eventInfo,
      snacksFeeRecordedByFund:
          params.snacksFee * BigInt.from(allAssignmentsToFund.length),
    );
    if (eventProfit == BigInt.zero) return await _eventsDao.closeEvent(params);

    await _updateFundsBalance(
      eventInfo: eventInfo,
      eventProfit: eventProfit,
      series: series,
      date: params.date,
    );
    final usersSalary = await _calculateUsersSalary(
      allDetailedAccounts: allDetailedAccounts,
      eventInfo: eventInfo,
      eventProfit: eventProfit,
    );
    await _identificationEventSalaries(
      subsidiaryMap: subsidiaryMap,
      eventInfo: eventInfo,
      usersSalary: usersSalary,
      series: series,
      date: params.date,
    );

    return await _eventsDao.closeEvent(params);
  }

  Future<void> _identificationEventSnacksExpenses({
    required Map<SubsidiaryAccountType, SubsidiaryAccount> subsidiaryMap,
    required ({int accountID, int id, String name}) hostInfo,
    required ({int accountID, int id, String name}) eventInfo,
    required List<({int accountID, int id, String name})> staffsInfo,
    required List<SnacksFeeAssignmentParams> snacksAssignmentsParams,
    required BigInt snacksFee,
    required int totalRegisteredGuestsNumber,
    required String series,
    required DateTime date,
  }) async {
    final journalLines = RecordExpensesJournalsHelper.identificationSnacksFee(
      subsidiaryAccountsMap: subsidiaryMap,
      hostInfo: hostInfo,
      eventInfo: eventInfo,
      staffsInfo: staffsInfo,
      snacksFee: snacksFee,
      totalRegisteredGuestsNumber: totalRegisteredGuestsNumber,
      snacksAssignmentsParams: snacksAssignmentsParams,
      series: series,
    );

    await _journalsDao.insertJournal(
      JournalParams(
        date: date,
        noticeMemo: null,
        hasSource: true,
        lines: journalLines,
        description:
            'بابت شناسایی هزینه پذیرایی رویداد  ${eventInfo.name} برگزار شده در ${hostInfo.name}',
      ),
    );
  }

  Future<void> _identificationEventEntranceExpenses({
    required Map<SubsidiaryAccountType, SubsidiaryAccount> subsidiaryMap,
    required ({int accountID, int id, String name}) hostInfo,
    required ({int accountID, int id, String name}) eventInfo,
    required BigInt entranceFee,
    required String series,
    required DateTime date,
  }) async {
    if (entranceFee <= BigInt.zero) return;

    final journalLines = RecordExpensesJournalsHelper.identificationEntranceFee(
      subsidiaryAccountsMap: subsidiaryMap,
      hostInfo: hostInfo,
      eventInfo: eventInfo,
      entranceFee: entranceFee,
      series: series,
    );

    await _journalsDao.insertJournal(
      JournalParams(
        date: date,
        noticeMemo: null,
        hasSource: true,
        lines: journalLines,
        description:
            'بابت شناسایی هزینه ورودی رویداد  ${eventInfo.name} برگزار شده در ${hostInfo.name}',
      ),
    );
  }

  Future<BigInt> _calculateProfit({
    required Map<SubsidiaryAccountType, SubsidiaryAccount> subsidiaryMap,
    required ({int accountID, int id, String name}) eventInfo,
    required BigInt snacksFeeRecordedByFund,
  }) async {
    final eventJournals = await _journalsDao.fetchJournalLinesBySubsidiaryId(
      firstDetailedID: eventInfo.accountID,
      subsidiaryID: null,
    );

    final revenueID = subsidiaryMap[SubsidiaryAccountType.eventRevenue]?.id;
    final discountsID = subsidiaryMap[SubsidiaryAccountType.saleDiscounts]?.id;
    final entranceExpenseID =
        subsidiaryMap[SubsidiaryAccountType.entranceExpenses]?.id;
    final snacksExpenseID =
        subsidiaryMap[SubsidiaryAccountType.snacksExpenses]?.id;
    final adsExpenseID = subsidiaryMap[SubsidiaryAccountType.adsExpenses]?.id;
    final feeExpenseID = subsidiaryMap[SubsidiaryAccountType.feeExpenses]?.id;
    final otherExpenseID =
        subsidiaryMap[SubsidiaryAccountType.otherExpenses]?.id;

    final eventProfit = eventJournals.fold<BigInt>(snacksFeeRecordedByFund, (
      sum,
      response,
    ) {
      final journal = response.journalLine;

      if (journal.subsidiaryId == revenueID) return sum + journal.credit;
      if (journal.subsidiaryId == entranceExpenseID) return sum - journal.debit;
      if (journal.subsidiaryId == snacksExpenseID) return sum - journal.debit;
      if (journal.subsidiaryId == discountsID) return sum - journal.debit;
      if (journal.subsidiaryId == adsExpenseID) return sum - journal.debit;
      if (journal.subsidiaryId == feeExpenseID) return sum - journal.debit;
      if (journal.subsidiaryId == otherExpenseID) return sum - journal.debit;

      return sum;
    });

    return eventProfit > BigInt.zero ? eventProfit : BigInt.zero;
  }

  Future<void> _updateFundsBalance({
    required ({int accountID, int id, String name}) eventInfo,
    required BigInt eventProfit,
    required String series,
    required DateTime date,
  }) async {
    final fundAllocations = await _fundAllocationsDao.fetchAllFundRatios(
      eventInfo.id,
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
          memo: 'بابت محاسبه درصد رویداد ${eventInfo.name}',
          date: date,
          credit: BigInt.zero,
          debit: allocationAmount,
        ),
      );
    }
  }

  Future<List<UserSalaryParams>> _calculateUsersSalary({
    required List<DetailedAccount> allDetailedAccounts,
    required ({int accountID, int id, String name}) eventInfo,
    required BigInt eventProfit,
  }) async {
    final usersSalary = <UserSalaryParams>[];

    final memberAllocations = await _memberAllocationsDao.fetchAllMemberRatios(
      eventInfo.id,
    );

    for (var member in memberAllocations) {
      final accountID = allDetailedAccounts
          .firstWhere((e) => e.userID == member.user.id)
          .id;

      final userProfit =
          (eventProfit *
              BigInt.from(member.memberAllocation.sharePercentage)) ~/
          BigInt.from(100);

      usersSalary.add(
        UserSalaryParams(
          userInfo: (
            id: member.user.id,
            name: member.user.name,
            accountID: accountID,
          ),
          salary: userProfit,
        ),
      );
    }

    return usersSalary;
  }

  Future<void> _identificationEventSalaries({
    required Map<SubsidiaryAccountType, SubsidiaryAccount> subsidiaryMap,
    required ({int accountID, int id, String name}) eventInfo,
    required List<UserSalaryParams> usersSalary,
    required String series,
    required DateTime date,
  }) async {
    final journalLines = RecordSalariesJournalsHelper.identificationSalaries(
      subsidiaryAccountsMap: subsidiaryMap,
      eventInfo: eventInfo,
      salaryParams: usersSalary,
      series: series,
    );

    await _journalsDao.insertJournal(
      JournalParams(
        date: date,
        noticeMemo: null,
        hasSource: true,
        lines: journalLines,
        description: 'شناسایی حقوق اعضا بابت رویداد ${eventInfo.name}',
      ),
    );
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
    // همه مراحل در یک تراکنش تا شکست هر مرحله، مراحل قبلی را هم برگرداند
    return _eventsDao.transaction(() async {
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

      return EventModel(
        id: eventID,
        title: params.title.trim(),
        date: params.date,
        isClosed: false,
        detailedAccountInfo: (
          id: newAccount.id,
          name: params.title.trim(),
          code: newAccount.code,
        ),
        entranceFee: BigInt.zero,
        snacksFee: BigInt.zero,
        teamInfo: params.teamInfo,
        hostInfo: params.hostInfo,
      );
    });
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

  @override
  Future<int> openEvent(int id) async {
    final eventAccountID = (await _accountsDao.fetchEventAccount(id)).id;

    final salaryID = (await _subsidiaryAccountsDao.fetchSubsidiaryAccount(
      .salaryExpense,
    )).id;

    final journalLinesInfo = await _journalsDao.fetchJournalLinesBySubsidiaryId(
      subsidiaryID: salaryID,
      firstDetailedID: eventAccountID,
    );

    await _journalsDao.deleteJournalsLines(
      journalLinesInfo.first.journalLine.series,
    );
    await _fundBalancesDao.deleteBalance(
      journalLinesInfo.first.journalLine.series,
    );

    return await _eventsDao.openEvent(id);
  }

  @override
  Future<EventModel> updateEvent(EventParams params) async {
    // همه مراحل در یک تراکنش تا شکست هر مرحله، مراحل قبلی را هم برگرداند
    return _eventsDao.transaction(() async {
      final prevTeam = (await _eventsDao.fetchEvent(params.id!)).teamID;

      if (prevTeam != params.teamInfo.id) {
        await _memberAllocationsDao.deleteAllMemberRatiosByEvent(params.id!);
        await _fundAllocationsDao.deleteAllFundRatiosByEvent(params.id!);
        await _insertMembersAllocations(params.id!, params);
        await _insertFundsAllocations(params.id!, params);
      }

      await _eventsDao.updateEvent(params);

      final account = await _accountsDao.fetchEventAccount(params.id!);

      return EventModel(
        id: params.id!,
        title: params.title.trim(),
        date: params.date,
        isClosed: true,
        detailedAccountInfo: (
          id: account.id,
          name: params.title.trim(),
          code: account.code,
        ),
        entranceFee: BigInt.zero,
        snacksFee: BigInt.zero,
        teamInfo: params.teamInfo,
        hostInfo: params.hostInfo,
      );
    });
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

  @override
  Future<List<int>> fetchRegisteredGuestsID(int eventID) async {
    final allRegisteredGuests = await _registrationsDao.fetchAllRegistrations(
      eventID,
    );

    return allRegisteredGuests.map((e) => e.guest.id).toList();
  }

  @override
  Future<List<UserModel>> fetchAllUsers() async {
    final users = await _usersDao.fetchAllActiveUsers();
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
