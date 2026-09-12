import 'package:pay_pilot_plus/core/data/models/event_registration_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/delete_registration_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_registration_params.dart';
import 'package:pay_pilot_plus/core/data/params/guest_registration_journal_params.dart';
import 'package:pay_pilot_plus/core/data/params/journal_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_registrations/event_registrations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/utils/helpers/journal_lines_helper.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/features/event_details/data/sources/i_event_registrations_source.dart';

abstract class IEventRegistrationsLocalProvider
    implements IEventRegistrationsSource<List<EventRegistrationModel>, int> {}

class EventRegistrationsLocalProvider extends BaseRepository
    implements IEventRegistrationsLocalProvider {
  final JournalsDao _journalsDao;
  final SubsidiaryAccountsDao _subsidiaryAccountsDao;
  final DetailedAccountsDao _accountsDao;
  final EventRegistrationsDao _registrationsDao;

  EventRegistrationsLocalProvider(
    this._journalsDao,
    this._subsidiaryAccountsDao,
    this._accountsDao,
    this._registrationsDao,
  );

  @override
  Future<List<EventRegistrationModel>> registerGuests(
    EventRegistrationParams params,
  ) async {
    int counter = 0;

    await _registrationsDao.insertRegistration(params);

    final allRegistrations = await _registrationsDao.fetchAllRegistrations(
      params.eventInfo.id,
    );

    await _recordGuestRegistrations(params);
    if (params.status.isConfirmed) await _recordPayments(params);

    return allRegistrations.map((e) {
      counter++;
      final register = e.registration;
      final user = e.user;
      final userAccount = e.userAccount;

      return EventRegistrationModel(
        id: register.id,
        status: register.status,
        discountAmount: register.discountAmount,
        grossAmount: register.grossAmount,
        netAmount: register.netAmount,
        registeredAt: register.registeredAt,
        wasAbsent: register.wasAbsent,
        counter: counter,
        description: register.description,
        user: UserModel(
          id: user.id,
          name: user.name,
          description: user.description,
          phoneNumber: user.phoneNumber,
          isActive: user.isActive,
          profileImage: user.profileImage,
          telegramID: user.telegramId,
          instagramID: user.instagramId,
          birthday: user.birthday,
          role: user.role,
          detailedAccountInfo: (
            id: userAccount.id,
            code: userAccount.code,
            name: userAccount.name,
          ),
        ),
      );
    }).toList();
  }

  Future<void> _recordGuestRegistrations(EventRegistrationParams params) async {
    final subsidiariesMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();
    final usersAccounts = await _accountsDao.fetchAllUserAccounts();
    final eventAccountID = (await _accountsDao.fetchEventAccount(
      params.eventInfo.id,
    )).id;

    final eventJournals = JournalLinesHelper.recordGuestRegistration(
      GuestRegistrationJournalParams(
        subsidiaryAccountsMap: subsidiariesMap,
        eventInfo: (
          id: params.eventInfo.id,
          name: params.eventInfo.name,
          accountID: eventAccountID,
        ),
        usersInfo: params.usersInfo,
        usersAccounts: usersAccounts,
        discountAmount: params.discountAmount,
        grossAmount: params.grossAmount,
        netAmount: params.netAmount,
      ),
    );

    final headerID = await _journalsDao.fetchCreditJournalsHeader(
      detailedAccountID: eventAccountID,
      subsidiaryID: subsidiariesMap[SubsidiaryAccountType.eventRevenue]!.id,
    );

    await _journalsDao.insertJournal(
      JournalParams(
        date: params.registeredAt,
        lines: eventJournals,
        headerID: headerID,
      ),
    );
  }

  Future<void> _recordPayments(EventRegistrationParams params) async {
    final subsidiariesMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();

    final usersAccounts = await _accountsDao.fetchAllUserAccounts();
    final eventAccountID = (await _accountsDao.fetchEventAccount(
      params.eventInfo.id,
    )).id;
    final usersInfo = params.usersInfo.map((e) {
      final account = usersAccounts.firstWhere((s) => s.userID == e.id);
      return (id: e.id, name: e.name, accountID: account.id);
    }).toList();

    final bankAccountID = params.bankInfo == null
        ? null
        : (await _accountsDao.fetchBankAccount(params.bankInfo!.id)).id;

    final eventJournals = bankAccountID != null
        ? JournalLinesHelper.recordBankDeposit(
            subsidiariesMap,
            usersInfo,
            bankAccountID,
            params.netAmount,
            params.eventInfo.name,
            eventAccountID,
          )
        : JournalLinesHelper.recordCashReceipt(
            subsidiariesMap,
            usersInfo,
            params.netAmount,
            params.eventInfo.name,
            eventAccountID,
          );

    final headerID = await _journalsDao.fetchCreditJournalsHeader(
      detailedAccountID: bankAccountID,
      detailedSecondAccountID: eventAccountID,
      subsidiaryID: subsidiariesMap[SubsidiaryAccountType.eventRevenue]!.id,
    );

    await _journalsDao.insertJournal(
      JournalParams(
        date: params.registeredAt,
        lines: eventJournals,
        headerID: headerID,
      ),
    );
  }

  @override
  Future<int> deleteRegistration(DeleteRegistrationParams params) async {
    await _registrationsDao.deleteRegistration(params.eventRegistrationID);

    final eventAccountID = (await _accountsDao.fetchEventAccount(
      params.eventID,
    )).id;
    final userAccountID = (await _accountsDao.fetchUserAccount(params.userID))
        .id;

    final registrationSeries = await _journalsDao.findRegistrationJournalSeries(
      eventAccountID,
      userAccountID,
    );

    await _journalsDao.deleteJournalsLines(registrationSeries);

    if (params.status.isConfirmed) {
      final paymentSeries = await _journalsDao.findPaymentJournalSeries(
        eventAccountID,
        userAccountID,
      );

      await _journalsDao.deleteJournalsLines(paymentSeries);
    }

    return params.userID;
  }

  @override
  Future<List<EventRegistrationModel>> fetchAllRegistrations(
    int eventID,
  ) async {
    int counter = 0;

    final rawRegistrations = await _registrationsDao.fetchAllRegistrations(
      eventID,
    );

    return rawRegistrations.map((row) {
      counter++;

      return EventRegistrationModel(
        id: row.registration.id,
        user: UserModel(
          id: row.user.id,
          name: row.user.name,
          description: row.user.description,
          phoneNumber: row.user.phoneNumber,
          isActive: row.user.isActive,
          profileImage: row.user.profileImage,
          telegramID: row.user.telegramId,
          instagramID: row.user.instagramId,
          birthday: row.user.birthday,
          role: row.user.role,
          detailedAccountInfo: (
            id: row.userAccount.id,
            code: row.userAccount.code,
            name: row.userAccount.name,
          ),
        ),
        status: row.registration.status,
        grossAmount: row.registration.grossAmount,
        discountAmount: row.registration.discountAmount,
        netAmount: row.registration.netAmount,
        registeredAt: row.registration.registeredAt,
        wasAbsent: row.registration.wasAbsent,
        counter: counter,
        description: row.registration.description,
      );
    }).toList();
  }

  @override
  Future<int> changeAbsentStatus(int registrationID, bool isAbsent) async {
    return _registrationsDao.changeAbsentStatus(registrationID, isAbsent);
  }

  @override
  Future<List<EventRegistrationModel>> registerMembers(
    EventRegistrationParams params,
  ) async {
    int counter = 0;

    await _registrationsDao.insertRegistration(params);

    final allRegistrations = await _registrationsDao.fetchAllRegistrations(
      params.eventInfo.id,
    );

    await _recordMemberRegistrations(params);

    return allRegistrations.map((e) {
      counter++;
      final register = e.registration;
      final user = e.user;
      final userAccount = e.userAccount;

      return EventRegistrationModel(
        id: register.id,
        status: register.status,
        discountAmount: register.discountAmount,
        grossAmount: register.grossAmount,
        netAmount: register.netAmount,
        registeredAt: register.registeredAt,
        wasAbsent: register.wasAbsent,
        counter: counter,
        description: register.description,
        user: UserModel(
          id: user.id,
          name: user.name,
          description: user.description,
          phoneNumber: user.phoneNumber,
          isActive: user.isActive,
          profileImage: user.profileImage,
          telegramID: user.telegramId,
          instagramID: user.instagramId,
          birthday: user.birthday,
          role: user.role,
          detailedAccountInfo: (
            id: userAccount.id,
            code: userAccount.code,
            name: userAccount.name,
          ),
        ),
      );
    }).toList();
  }

  Future<void> _recordMemberRegistrations(
    EventRegistrationParams params,
  ) async {
    final subsidiariesMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();
    final usersAccounts = await _accountsDao.fetchAllUserAccounts();
    final eventAccountID = (await _accountsDao.fetchEventAccount(
      params.eventInfo.id,
    )).id;

    final eventJournals = JournalLinesHelper.recordMemberRegistration(
      GuestRegistrationJournalParams(
        subsidiaryAccountsMap: subsidiariesMap,
        eventInfo: (
          id: params.eventInfo.id,
          name: params.eventInfo.name,
          accountID: eventAccountID,
        ),
        usersInfo: params.usersInfo,
        usersAccounts: usersAccounts,
        discountAmount: params.discountAmount,
        grossAmount: params.grossAmount,
        netAmount: params.netAmount,
      ),
    );

    final headerID = await _journalsDao.fetchCreditJournalsHeader(
      detailedAccountID: eventAccountID,
      subsidiaryID: subsidiariesMap[SubsidiaryAccountType.eventRevenue]!.id,
    );

    await _journalsDao.insertJournal(
      JournalParams(
        date: params.registeredAt,
        lines: eventJournals,
        headerID: headerID,
      ),
    );
  }
}
