import 'package:drift/drift.dart' show Value;
import 'package:pay_pilot_plus/core/data/models/event_registration_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/delete_registration_params.dart';
import 'package:pay_pilot_plus/core/data/params/event_registration_params.dart';
import 'package:pay_pilot_plus/core/data/params/journal_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_registrations/event_registrations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/utils/helpers/record_assignment_journals_helper.dart';
import 'package:pay_pilot_plus/core/utils/helpers/record_event_journals_helper.dart';
import 'package:pay_pilot_plus/core/utils/helpers/record_transferring_journals_helper.dart';
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
    await _registrationsDao.insertRegistration(params);
    await _recordGuestRegistrations(params);
    if (params.status.isConfirmed) await _recordPayments(params);

    return fetchAllRegistrations(params.eventInfo.id);
  }

  Future<void> _recordGuestRegistrations(EventRegistrationParams params) async {
    final subsidiariesMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();
    final usersAccounts = await _accountsDao.fetchAllUserAccounts();
    final eventAccountID = (await _accountsDao.fetchEventAccount(
      params.eventInfo.id,
    )).id;

    final eventJournals =
        RecordEventJournalsHelper.identificationGuestAttending(
          subsidiaryAccountsMap: subsidiariesMap,
          eventInfo: (
            id: params.eventInfo.id,
            name: params.eventInfo.name,
            accountID: eventAccountID,
          ),
          guestsInfo: params.guestsInfo.map((e) {
            final detailedAccount = usersAccounts.firstWhere(
              (s) => s.userID == e.id,
            );

            return (id: e.id, name: e.name, accountID: detailedAccount.id);
          }).toList(),
          discountAmount: params.discountAmount,
          grossAmount: params.grossAmount,
          netAmount: params.netAmount,
        );

    await _journalsDao.insertJournal(
      JournalParams(
        date: params.registeredAt,
        noticeMemo: params.description,
        hasSource: true,
        lines: eventJournals,
        headerID: null,
        description:
            'ثبت نام در رویداد ${params.eventInfo.name} توسط ${params.guestsInfo.map((e) => '${e.name}, ')}',
      ),
    );
  }

  Future<void> _recordPayments(EventRegistrationParams params) async {
    if (params.netAmount <= BigInt.zero) return;

    final subsidiariesMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();

    final usersAccounts = await _accountsDao.fetchAllUserAccounts();
    final eventAccountID = (await _accountsDao.fetchEventAccount(
      params.eventInfo.id,
    )).id;
    final guestsInfo = params.guestsInfo.map((e) {
      final account = usersAccounts.firstWhere((s) => s.userID == e.id);
      return (id: e.id, name: e.name, accountID: account.id);
    }).toList();

    final eventJournals = <JournalLinesCompanion>[];

    if (params.bankInfo != null) {
      final bankAccountID = (await _accountsDao.fetchBankAccount(
        params.bankInfo!.id,
      )).id;

      eventJournals.addAll(
        RecordTransferringJournalsHelper.registerPaymentFromGuest(
          subsidiaryAccountsMap: subsidiariesMap,
          guestsInfo: guestsInfo,
          bankInfo: (
            id: params.bankInfo!.id,
            name: params.bankInfo!.name,
            accountID: bankAccountID,
          ),
          eventInfo: (
            id: params.eventInfo.id,
            name: params.eventInfo.name,
            accountID: eventAccountID,
          ),
          receivedAmount: params.netAmount,
        ),
      );
    }

    if (params.assignmentInfo != null) {
      final assignedAccountID = (await _accountsDao.fetchUserAccount(
        params.assignmentInfo!.id,
      )).id;

      eventJournals.addAll(
        RecordAssignmentJournalsHelper.fromGuestsToStaff(
          subsidiaryAccountsMap: subsidiariesMap,
          guestsInfo: guestsInfo,
          eventInfo: (
            id: params.eventInfo.id,
            name: params.eventInfo.name,
            accountID: eventAccountID,
          ),
          staffInfo: (
            id: params.assignmentInfo!.id,
            name: params.assignmentInfo!.name,
            accountID: assignedAccountID,
          ),
          receivedAmount: params.netAmount,
        ),
      );
    }

    // if (params.assignmentInfo == null && params.bankInfo == null) {
    //   eventJournals.addAll(
    //     RecordRegistrationJournalsHelper.receiptCash(
    //       subsidiariesMap,
    //       usersInfo,
    //       params.netAmount,
    //       params.eventInfo.name,
    //       eventAccountID,
    //     ),
    //   );
    // }

    await _journalsDao.insertJournal(
      JournalParams(
        date: params.registeredAt,
        noticeMemo: params.description,
        hasSource: true,
        lines: eventJournals,
        headerID: null,
        description:
            'ثبت پرداختی های رویداد ${params.eventInfo.name} توسط ${params.guestsInfo.map((e) => '${e.name}, ')}',
      ),
    );
  }

  @override
  Future<int> deleteRegistration(DeleteRegistrationParams params) async {
    await _registrationsDao.deleteRegistration(params.eventRegistrationID);

    final series = await _findRegistrationSeries(
      subsidiariesMap: await _subsidiaryAccountsDao.fetchSubsidiaryAccounts(),
      eventAccountID: (await _accountsDao.fetchEventAccount(params.eventID)).id,
      userAccountID: (await _accountsDao.fetchUserAccount(params.userID)).id,
    );

    if (series.registration != null) {
      await _journalsDao.deleteJournalsLines(series.registration!);
    }
    if (series.payment != null) {
      await _journalsDao.deleteJournalsLines(series.payment!);
    }

    return params.userID;
  }

  /// ثبت‌نام و اسناد همان سری‌ها را در یک تراکنش ویرایش می‌کند؛
  /// سری و شماره سند ثابت می‌مانند و ردیف‌های اشخاص دیگرِ همان سند دست نمی‌خورند.
  @override
  Future<List<EventRegistrationModel>> updateRegistration(
    EventRegistrationParams params,
  ) async {
    await _journalsDao.transaction(() async {
      await _registrationsDao.updateRegistration(params);

      final subsidiariesMap = await _subsidiaryAccountsDao
          .fetchSubsidiaryAccounts();
      final person = params.guestsInfo.single;
      final isGuest = (await _registrationsDao.fetchUserRole(person.id))
          .isGuest;
      final personsInfo = [
        (
          id: person.id,
          name: person.name,
          accountID: (await _accountsDao.fetchUserAccount(person.id)).id,
        ),
      ];
      final eventInfo = (
        id: params.eventInfo.id,
        name: params.eventInfo.name,
        accountID: (await _accountsDao.fetchEventAccount(params.eventInfo.id))
            .id,
      );
      final series = await _findRegistrationSeries(
        subsidiariesMap: subsidiariesMap,
        eventAccountID: eventInfo.accountID,
        userAccountID: personsInfo.single.accountID,
      );

      final registrationLines = isGuest
          ? RecordEventJournalsHelper.identificationGuestAttending(
              subsidiaryAccountsMap: subsidiariesMap,
              eventInfo: eventInfo,
              guestsInfo: personsInfo,
              grossAmount: params.grossAmount,
              discountAmount: params.discountAmount,
              netAmount: params.netAmount,
              series: series.registration,
            )
          : params.netAmount > BigInt.zero
          ? RecordEventJournalsHelper.identificationStaffAttending(
              subsidiaryAccountsMap: subsidiariesMap,
              eventInfo: eventInfo,
              staffsInfo: personsInfo,
              grossAmount: params.grossAmount,
              discountAmount: params.discountAmount,
              netAmount: params.netAmount,
              series: series.registration,
            )
          : <JournalLinesCompanion>[];

      await _writeSeries(
        series: series.registration,
        lines: registrationLines,
        params: params,
        description:
            'ثبت نام در رویداد ${params.eventInfo.name} توسط ${person.name}',
      );

      final paymentLines = <JournalLinesCompanion>[];
      final isPaid =
          isGuest &&
          params.status.isConfirmed &&
          params.netAmount > BigInt.zero;

      if (isPaid && params.bankInfo != null) {
        paymentLines.addAll(
          RecordTransferringJournalsHelper.registerPaymentFromGuest(
            subsidiaryAccountsMap: subsidiariesMap,
            guestsInfo: personsInfo,
            bankInfo: (
              id: params.bankInfo!.id,
              name: params.bankInfo!.name,
              accountID: (await _accountsDao.fetchBankAccount(
                params.bankInfo!.id,
              )).id,
            ),
            eventInfo: eventInfo,
            receivedAmount: params.netAmount,
            series: series.payment,
          ),
        );
      }

      if (isPaid && params.assignmentInfo != null) {
        paymentLines.addAll(
          RecordAssignmentJournalsHelper.fromGuestsToStaff(
            subsidiaryAccountsMap: subsidiariesMap,
            guestsInfo: personsInfo,
            eventInfo: eventInfo,
            staffInfo: (
              id: params.assignmentInfo!.id,
              name: params.assignmentInfo!.name,
              accountID: (await _accountsDao.fetchUserAccount(
                params.assignmentInfo!.id,
              )).id,
            ),
            receivedAmount: params.netAmount,
            series: series.payment,
          ),
        );
      }

      await _writeSeries(
        series: series.payment,
        lines: paymentLines,
        params: params,
        description:
            'ثبت پرداختی های رویداد ${params.eventInfo.name} توسط ${person.name}',
      );
    });

    return fetchAllRegistrations(params.eventInfo.id);
  }

  /// سری موجود در همان سند جایگزین می‌شود؛ سری جدید سند جدید می‌گیرد.
  Future<void> _writeSeries({
    required String? series,
    required List<JournalLinesCompanion> lines,
    required EventRegistrationParams params,
    required String description,
  }) async {
    if (series != null) {
      return _journalsDao.replaceSeriesLines(
        series: series,
        lines: lines
            .map((l) => l.copyWith(noticeMemo: Value(params.description)))
            .toList(),
        date: params.registeredAt,
      );
    }

    if (lines.isEmpty) return;

    await _journalsDao.insertJournal(
      JournalParams(
        date: params.registeredAt,
        noticeMemo: params.description,
        hasSource: true,
        lines: lines,
        description: description,
      ),
    );
  }

  /// سری‌ها روی ثبت‌نام ذخیره نمی‌شوند؛ از روی تفصیلی‌های ردیف‌ها پیدا می‌شوند.
  /// سری ثبت‌نام: ردیف درآمد (تفصیلی اول رویداد، دوم شخص).
  /// سری پرداخت: ردیف بستانکار دریافتنی مهمان (تفصیلی اول شخص، دوم رویداد)؛
  /// ردیف بدهکار همین حساب متعلق به خود سری ثبت‌نام است.
  Future<({String? registration, String? payment})> _findRegistrationSeries({
    required Map<SubsidiaryAccountType, SubsidiaryAccount> subsidiariesMap,
    required int eventAccountID,
    required int userAccountID,
  }) async {
    final revenueLines = await _journalsDao.fetchJournalLinesBySubsidiaryId(
      subsidiaryID: subsidiariesMap[SubsidiaryAccountType.eventRevenue]!.id,
      firstDetailedID: eventAccountID,
      secondDetailedID: userAccountID,
    );
    final receivableLines = await _journalsDao.fetchJournalLinesBySubsidiaryId(
      subsidiaryID: subsidiariesMap[SubsidiaryAccountType.guestReceivables]!.id,
      firstDetailedID: userAccountID,
      secondDetailedID: eventAccountID,
    );

    return (
      registration: revenueLines.firstOrNull?.journalLine.series,
      payment: receivableLines
          .where((l) => l.journalLine.credit > BigInt.zero)
          .firstOrNull
          ?.journalLine
          .series,
    );
  }

  @override
  Future<List<EventRegistrationModel>> fetchAllRegistrations(
    int eventID,
  ) async {
    int counter = 0;

    final rawRegistrations = await _registrationsDao.fetchAllRegistrations(
      eventID,
    );
    final counterparties = await _journalsDao.fetchPaymentCounterparties(
      eventAccountID: (await _accountsDao.fetchEventAccount(eventID)).id,
      receivablesID:
          (await _subsidiaryAccountsDao
                  .fetchSubsidiaryAccounts())[SubsidiaryAccountType
                  .guestReceivables]!
              .id,
    );

    return rawRegistrations.map((row) {
      counter++;
      final counterparty = counterparties[row.userAccount.id];
      final snacksUser = row.snacksAssignmentUser;
      final snacksFund = row.snacksAssignmentFund;

      return EventRegistrationModel(
        id: row.registration.id,
        user: UserModel(
          id: row.guest.id,
          name: row.guest.name,
          description: row.guest.description,
          phoneNumber: row.guest.phoneNumber,
          isActive: row.guest.isActive,
          profileImage: row.guest.profileImage,
          telegramID: row.guest.telegramId,
          instagramID: row.guest.instagramId,
          birthday: row.guest.birthday,
          role: row.guest.role,
          openingBalance: BigInt.zero,
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
        bankInfo: counterparty?.bankID == null
            ? null
            : (id: counterparty!.bankID!, name: counterparty.name),
        assignmentInfo: counterparty?.userID == null
            ? null
            : (id: counterparty!.userID!, name: counterparty.name),
        snacksAssignmentStatus: row.registration.snacksFeeAssignmentStatus,
        snacksAssignmentInfo: snacksUser != null
            ? (id: snacksUser.id, name: snacksUser.name)
            : snacksFund != null
            ? (id: snacksFund.id, name: snacksFund.title)
            : null,
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
    await _registrationsDao.insertRegistration(params);
    await _recordMemberRegistrations(params);

    return fetchAllRegistrations(params.eventInfo.id);
  }

  Future<void> _recordMemberRegistrations(
    EventRegistrationParams params,
  ) async {
    if (params.netAmount <= BigInt.zero) return;

    final subsidiariesMap = await _subsidiaryAccountsDao
        .fetchSubsidiaryAccounts();
    final usersAccounts = await _accountsDao.fetchAllUserAccounts();
    final eventAccountID = (await _accountsDao.fetchEventAccount(
      params.eventInfo.id,
    )).id;
    final staffsInfo = params.guestsInfo.map((e) {
      final account = usersAccounts.firstWhere((s) => s.userID == e.id);
      return (id: e.id, name: e.name, accountID: account.id);
    }).toList();

    final eventJournals =
        RecordEventJournalsHelper.identificationStaffAttending(
          subsidiaryAccountsMap: subsidiariesMap,
          eventInfo: (
            id: params.eventInfo.id,
            name: params.eventInfo.name,
            accountID: eventAccountID,
          ),
          staffsInfo: staffsInfo,
          discountAmount: params.discountAmount,
          grossAmount: params.grossAmount,
          netAmount: params.netAmount,
        );

    await _journalsDao.insertJournal(
      JournalParams(
        date: params.registeredAt,
        noticeMemo: params.description,
        hasSource: true,
        lines: eventJournals,
        headerID: null,
        description:
            'ثبت نام در رویداد ${params.eventInfo.name} توسط ${params.guestsInfo.map((e) => '${e.name}, ')}',
      ),
    );
  }
}
