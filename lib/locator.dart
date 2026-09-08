import 'package:get_it/get_it.dart';
import 'package:pay_pilot_plus/core/database/daos/banks/banks_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_orders/event_orders_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_partner_shares/event_partner_shares_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_registrations/event_registrations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/events/events_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/menu_items/menu_items_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/team_members/team_members_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/teams/teams_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/core/database/platform/platform.dart';
import 'package:pay_pilot_plus/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot_plus/features/change_language/data/language_local_provider.dart';
import 'package:pay_pilot_plus/features/change_language/repository/language_repository.dart';
import 'package:pay_pilot_plus/features/guests/data/providers/guest_local_provider.dart';
import 'package:pay_pilot_plus/features/guests/repository/guest_repository.dart';
import 'package:pay_pilot_plus/features/hosts/data/providers/host_local_provider.dart';
import 'package:pay_pilot_plus/features/hosts/repository/host_repository.dart';
import 'package:pay_pilot_plus/features/members/data/providers/member_local_provider.dart';
import 'package:pay_pilot_plus/features/members/repository/member_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/database/app_database.dart';

GetIt locator = GetIt.instance;

Future<void> locatorSetup() async {
  await _callServices();
  _callSources();
  _callProviders();
  _callRepositories();
}

Future<void> _callServices() async {
  locator.registerSingleton(
    AppDatabase(Platform.createDatabaseConnection('pay-pilot-plus-db')),
  );

  /// shared preferences
  final SharedPreferences initSharedPreferences =
      await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferencesService>(
    SharedPreferencesService(initSharedPreferences),
  );

  // locator.registerSingleton<TeamDao>(TeamDao(locator()));
}

void _callSources() {
  locator.registerLazySingleton<BanksDao>(() => BanksDao(locator()));
  locator.registerLazySingleton<DetailedAccountsDao>(
    () => DetailedAccountsDao(locator()),
  );
  locator.registerLazySingleton<EventOrdersDao>(
    () => EventOrdersDao(locator()),
  );
  locator.registerLazySingleton<EventPartnerSharesDao>(
    () => EventPartnerSharesDao(locator()),
  );
  locator.registerLazySingleton<EventRegistrationsDao>(
    () => EventRegistrationsDao(locator()),
  );
  locator.registerLazySingleton<EventsDao>(() => EventsDao(locator()));
  locator.registerLazySingleton<JournalsDao>(() => JournalsDao(locator()));
  locator.registerLazySingleton<MenuItemsDao>(() => MenuItemsDao(locator()));
  locator.registerLazySingleton<SubsidiaryAccountsDao>(
    () => SubsidiaryAccountsDao(locator()),
  );
  locator.registerLazySingleton<TeamMembersDao>(
    () => TeamMembersDao(locator()),
  );
  locator.registerLazySingleton<TeamsDao>(() => TeamsDao(locator()));
  locator.registerLazySingleton<UsersDao>(() => UsersDao(locator()));
}

void _callProviders() {
  locator.registerLazySingleton<LanguageLocalProvider>(
    () => LanguageLocalProvider(locator()),
  );

  locator.registerLazySingleton<IMemberLocalProvider>(
    () => MemberLocalProvider(locator(), locator()),
  );
  locator.registerLazySingleton<IGuestLocalProvider>(
    () => GuestLocalProvider(locator(), locator()),
  );
  locator.registerLazySingleton<IHostLocalProvider>(
    () => HostLocalProvider(locator(), locator()),
  );
}

void _callRepositories() {
  locator.registerLazySingleton<LanguageRepository>(
    () => LanguageRepository(locator()),
  );

  locator.registerLazySingleton<IMemberRepository>(
    () => MemberRepository(locator()),
  );
  locator.registerLazySingleton<IGuestRepository>(
    () => GuestRepository(locator()),
  );
  locator.registerLazySingleton<IHostRepository>(
    () => HostRepository(locator()),
  );
}
