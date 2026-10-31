import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';
import 'package:pay_pilot_plus/core/data/params/detailed_account_params.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_registrations/event_registrations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/services/accounts_chart_seeder_service.dart';
import 'package:pay_pilot_plus/features/guests/data/providers/guest_balance_local_provider.dart';
import 'package:pay_pilot_plus/features/guests/data/providers/guest_local_provider.dart';
import 'package:pay_pilot_plus/features/guests/presentation/cubit/guest_balance/guest_balance_cubit.dart';

void main() {
  setUpAll(() => S.load(const Locale('en')));

  test('guest registrations: full event info, newest first, '
      'summary skips cancelled', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await AccountsChartSeederService(db).seedDefaultChartOfAccounts();

    final subsidiaryDao = SubsidiaryAccountsDao(db);
    final accountsDao = DetailedAccountsDao(db);
    final journalsDao = JournalsDao(db);
    final usersDao = UsersDao(db);

    final guest =
        await GuestLocalProvider(
          usersDao,
          subsidiaryDao,
          accountsDao,
          journalsDao,
        ).insertGuest(
          UserParams(
            id: null,
            name: 'Guest',
            description: null,
            profileImage: null,
            isActive: true,
            telegramID: null,
            instagramID: null,
            phone: null,
            birthday: null,
            openingBalance: null,
            role: UserAccountRole.guest,
          ),
        );

    final hostID = await db
        .into(db.users)
        .insert(
          UsersCompanion.insert(name: 'Host', role: UserAccountRole.staff),
        );
    final teamID = await db
        .into(db.teams)
        .insert(TeamsCompanion.insert(title: 'Team'));

    Future<int> event(String title, DateTime date) async {
      final id = await db
          .into(db.events)
          .insert(
            EventsCompanion.insert(
              title: title,
              teamID: teamID,
              userID: hostID,
              entranceFee: BigInt.zero,
              snacksFee: BigInt.zero,
              date: Value(date),
            ),
          );
      await accountsDao.insertAccount(
        DetailedAccountParams(
          id: null,
          attachmentID: id,
          name: title,
          type: .event,
        ),
      );
      return id;
    }

    Future<void> register(
      int eventID,
      int gross,
      int discount,
      RegistrationStatus status,
    ) => db
        .into(db.eventRegistrations)
        .insert(
          EventRegistrationsCompanion.insert(
            eventID: eventID,
            userID: guest.id,
            grossAmount: BigInt.from(gross),
            discountAmount: BigInt.from(discount),
            netAmount: BigInt.from(gross - discount),
            status: Value(status),
          ),
        );

    final oldEvent = await event('Old', DateTime(2026, 1, 1));
    final newEvent = await event('New', DateTime(2026, 6, 1));
    final cancelledEvent = await event('Cancelled', DateTime(2026, 3, 1));
    await register(oldEvent, 1000, 0, .confirmed);
    await register(newEvent, 2000, 500, .pending);
    await register(cancelledEvent, 3000, 1000, .cancelled);

    final registrations = await GuestBalanceLocalProvider(
      subsidiaryDao,
      journalsDao,
      EventRegistrationsDao(db),
    ).fetchRegistrations(guest.id);

    expect(registrations.map((e) => e.event.title), [
      'New',
      'Cancelled',
      'Old',
    ]);
    final newest = registrations.first;
    expect(newest.event.teamInfo.name, 'Team');
    expect(newest.event.hostInfo.name, 'Host');
    expect(newest.event.detailedAccountInfo.name, 'New');
    expect(newest.discountAmount, BigInt.from(500));

    final state = GuestBalanceState(
      remainingAmount: BigInt.zero,
      journals: const [],
      balanceStatus: .success,
      remainingStatus: .success,
      registrations: registrations,
      registrationsStatus: .success,
    );
    expect(state.activeTotals, (
      count: 2,
      gross: BigInt.from(3000),
      discount: BigInt.from(500),
      net: BigInt.from(2500),
    ));

    // تیک‌خورده‌ها، حتی لغوشده، جمع زده می‌شوند
    final cancelledID = registrations[1].id;
    final selected = state.copyWith(
      selectedIDs: {registrations.first.id, cancelledID},
    );
    expect(selected.selectedTotals, (
      count: 2,
      gross: BigInt.from(5000),
      discount: BigInt.from(1500),
      net: BigInt.from(3500),
    ));
  });
}
