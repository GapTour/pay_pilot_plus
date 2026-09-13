import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/detailed_account_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_partner_share_params.dart';
import 'package:pay_pilot_plus/core/data/params/journal_params.dart';
import 'package:pay_pilot_plus/core/data/params/user_salary_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_partner_shares/event_partner_shares_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/events/events_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/team_members/team_members_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/teams/teams_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/core/utils/helpers/journal_lines_helper.dart';
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
  final EventPartnerSharesDao _partnerSharesDao;
  final TeamsDao _teamsDao;
  final UsersDao _usersDao;

  EventLocalProvider(
    this._eventsDao,
    this._journalsDao,
    this._subsidiaryAccountsDao,
    this._accountsDao,
    this._teamMembersDao,
    this._partnerSharesDao,
    this._teamsDao,
    this._usersDao,
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

    final journalLines = await JournalLinesHelper.recordMembersSalary(
      subsidiaryMap,
      usersAccount,
      usersSalary,
      eventProfit,
      params.title,
      eventAccount.id,
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
        userInfo: (id: user.id, name: user.name),
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
    await _insertPartnerShares(eventID, params);

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
      entranceFee: params.entranceFee,
      snacksFee: params.snacksFee,
      detailedAccountInfo: (
        id: newAccount.id,
        name: params.title.trim(),
        code: newAccount.code,
      ),
      teamInfo: params.teamInfo,
      userInfo: params.userInfo,
    );
  }

  @override
  Future<int> openEvent(int id) async {
    final eventAccountID = (await _accountsDao.fetchEventAccount(id)).id;

    final expenseID = (await _subsidiaryAccountsDao.fetchSubsidiaryAccount(
      .salaryExpense,
    )).id;

    final headerID = await _journalsDao.fetchDebitJournalsHeader(
      detailedAccountID: eventAccountID,
      subsidiaryID: expenseID,
    );

    if (headerID != null) await _journalsDao.deleteJournalHeader(headerID);

    return await _eventsDao.openEvent(id);
  }

  @override
  Future<EventModel> updateEvent(EventParams params) async {
    final prevTeam = (await _eventsDao.fetchEvent(params.id!)).teamID;

    if (prevTeam != params.teamInfo.id) {
      await _partnerSharesDao.deleteAllPartnerSharesByEvent(params.id!);
      await _insertPartnerShares(params.id!, params);
    }

    await _eventsDao.updateEvent(params);

    final account = await _accountsDao.fetchEventAccount(params.id!);

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
      userInfo: params.userInfo,
    );
  }

  Future<void> _insertPartnerShares(int eventID, EventParams params) async {
    final teamMembers = await _teamMembersDao.fetchAllTeamMembers(
      params.teamInfo.id,
    );
    final partnerShareParams = EventPartnerShareParams(
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

    await _partnerSharesDao.insertMultiPartnerShare(partnerShareParams);
  }

  Future<BigInt> _calculateProfit(int eventID) async {
    final subsidiaryMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();

    final eventAccount = await _accountsDao.fetchEventAccount(eventID);
    final eventJournals = await _journalsDao.fetchJournals(eventAccount.id);

    final revenueID = subsidiaryMap[SubsidiaryAccountType.eventRevenue]?.id;
    final discountsID = subsidiaryMap[SubsidiaryAccountType.saleDiscounts]?.id;
    final expenseID = subsidiaryMap[SubsidiaryAccountType.eventExpenses]?.id;

    final eventProfit = eventJournals.fold<BigInt>(BigInt.zero, (prev, crr) {
      if (crr.subsidiaryId == revenueID) return prev + crr.credit;
      if (crr.subsidiaryId == expenseID) return prev - crr.debit;
      if (crr.subsidiaryId == discountsID) return prev - crr.debit;

      return prev;
    });

    return eventProfit;
  }

  Future<List<UserSalaryParams>> _calculateUsersSalary(
    int eventID,
    BigInt eventProfit,
  ) async {
    final usersSalary = <UserSalaryParams>[];

    final partnerShares = await _partnerSharesDao.fetchAllPartnerShares(
      eventID,
    );

    for (var partner in partnerShares) {
      final userProfit =
          (eventProfit * BigInt.from(partner.partnerShare.sharePercentage)) ~/
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

    return users.map((e) {
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
        detailedAccountInfo: (
          id: e.account.id,
          code: e.account.code,
          name: e.account.name,
        ),
      );
    }).toList();
  }
}
