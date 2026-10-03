import 'package:get_it/get_it.dart';
import 'package:pay_pilot_plus/core/database/daos/accounts_chart/accounts_chart_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/banks/banks_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_orders/event_orders_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_registrations/event_registrations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/events/events_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/fund_allocations/fund_allocations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/fund_balances/fund_balances_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/funds/funds_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/member_allocations/member_allocations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/menu_items/menu_items_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/team_funds/team_funds_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/team_members/team_members_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/teams/teams_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';
import 'package:pay_pilot_plus/core/database/platform/platform.dart';
import 'package:pay_pilot_plus/core/utils/services/accounts_chart_seeder_service.dart';
import 'package:pay_pilot_plus/core/utils/services/database_backup_service.dart';
import 'package:pay_pilot_plus/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot_plus/features/banks/data/providers/bank_balance_local_provider.dart';
import 'package:pay_pilot_plus/features/banks/data/providers/bank_local_provider.dart';
import 'package:pay_pilot_plus/features/banks/repository/bank_repository.dart';
import 'package:pay_pilot_plus/features/change_language/data/language_local_provider.dart';
import 'package:pay_pilot_plus/features/change_language/repository/language_repository.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_details_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_expenses_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_fund_ratios_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_member_ratios_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_orders_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/data/providers/event_registrations_local_provider.dart';
import 'package:pay_pilot_plus/features/event_details/repository/event_details_repository.dart';
import 'package:pay_pilot_plus/features/events/data/providers/event_local_provider.dart';
import 'package:pay_pilot_plus/features/events/repository/event_repository.dart';
import 'package:pay_pilot_plus/features/funds/data/providers/fund_balance_local_provider.dart';
import 'package:pay_pilot_plus/features/funds/data/providers/fund_local_provider.dart';
import 'package:pay_pilot_plus/features/funds/repository/fund_repository.dart';
import 'package:pay_pilot_plus/features/guests/data/providers/guest_balance_local_provider.dart';
import 'package:pay_pilot_plus/features/guests/data/providers/guest_local_provider.dart';
import 'package:pay_pilot_plus/features/guests/repository/guest_repository.dart';
import 'package:pay_pilot_plus/features/hosts/data/providers/host_balance_local_provider.dart';
import 'package:pay_pilot_plus/features/hosts/data/providers/host_local_provider.dart';
import 'package:pay_pilot_plus/features/hosts/repository/host_repository.dart';
import 'package:pay_pilot_plus/features/journal_headers/data/providers/header_local_provider.dart';
import 'package:pay_pilot_plus/features/journal_headers/data/providers/line_local_provider.dart';
import 'package:pay_pilot_plus/features/journal_headers/repository/journals_repository.dart';
import 'package:pay_pilot_plus/features/members/data/providers/member_balance_local_provider.dart';
import 'package:pay_pilot_plus/features/members/data/providers/member_local_provider.dart';
import 'package:pay_pilot_plus/features/members/repository/member_repository.dart';
import 'package:pay_pilot_plus/features/menu_items/data/providers/menu_local_provider.dart';
import 'package:pay_pilot_plus/features/menu_items/repository/menu_repository.dart';
import 'package:pay_pilot_plus/features/settings/data/providers/setting_local_provider.dart';
import 'package:pay_pilot_plus/features/settings/repository/setting_repository.dart';
import 'package:pay_pilot_plus/features/team_details/data/providers/team_fund_local_provider.dart';
import 'package:pay_pilot_plus/features/team_details/data/providers/team_member_local_provider.dart';
import 'package:pay_pilot_plus/features/team_details/repository/team_details_repository.dart';
import 'package:pay_pilot_plus/features/teams/data/providers/team_local_provider.dart';
import 'package:pay_pilot_plus/features/teams/repository/team_repository.dart';
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

  locator.registerSingleton<DatabaseBackupService>(
    DatabaseBackupService(locator()),
  );
  locator.registerSingleton<AccountsChartSeederService>(
    AccountsChartSeederService(locator()),
  );
}

void _callSources() {
  locator.registerLazySingleton<BanksDao>(() => BanksDao(locator()));
  locator.registerLazySingleton<DetailedAccountsDao>(
    () => DetailedAccountsDao(locator()),
  );
  locator.registerLazySingleton<EventOrdersDao>(
    () => EventOrdersDao(locator()),
  );
  locator.registerLazySingleton<MemberAllocationsDao>(
    () => MemberAllocationsDao(locator()),
  );
  locator.registerLazySingleton<EventRegistrationsDao>(
    () => EventRegistrationsDao(locator()),
  );
  locator.registerLazySingleton<EventsDao>(() => EventsDao(locator()));
  locator.registerLazySingleton<AccountsChartDao>(
    () => AccountsChartDao(locator()),
  );
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
  locator.registerLazySingleton<TeamFundsDao>(() => TeamFundsDao(locator()));
  locator.registerLazySingleton<FundAllocationsDao>(
    () => FundAllocationsDao(locator()),
  );
  locator.registerLazySingleton<FundsDao>(() => FundsDao(locator()));
  locator.registerLazySingleton<FundBalancesDao>(
    () => FundBalancesDao(locator()),
  );
}

void _callProviders() {
  locator.registerLazySingleton<LanguageLocalProvider>(
    () => LanguageLocalProvider(locator()),
  );

  locator.registerLazySingleton<IHeaderLocalProvider>(
    () => HeaderLocalProvider(locator()),
  );
  locator.registerLazySingleton<ILineLocalProvider>(
    () => LineLocalProvider(locator()),
  );
  locator.registerLazySingleton<IMemberLocalProvider>(
    () => MemberLocalProvider(locator(), locator(), locator(), locator()),
  );
  locator.registerLazySingleton<IMemberBalanceLocalProvider>(
    () => MemberBalanceLocalProvider(locator(), locator()),
  );
  locator.registerLazySingleton<IGuestLocalProvider>(
    () => GuestLocalProvider(locator(), locator(), locator(), locator()),
  );
  locator.registerLazySingleton<IGuestBalanceLocalProvider>(
    () => GuestBalanceLocalProvider(locator(), locator()),
  );
  locator.registerLazySingleton<IHostLocalProvider>(
    () => HostLocalProvider(locator(), locator(), locator(), locator()),
  );
  locator.registerLazySingleton<IHostBalanceLocalProvider>(
    () => HostBalanceLocalProvider(locator(), locator()),
  );
  locator.registerLazySingleton<IBankLocalProvider>(
    () => BankLocalProvider(locator(), locator(), locator(), locator()),
  );
  locator.registerLazySingleton<IBankBalanceLocalProvider>(
    () => BankBalanceLocalProvider(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerLazySingleton<ITeamLocalProvider>(
    () => TeamLocalProvider(locator()),
  );
  locator.registerLazySingleton<ITeamMemberLocalProvider>(
    () => TeamMemberLocalProvider(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<ITeamFundLocalProvider>(
    () => TeamFundLocalProvider(locator(), locator()),
  );
  locator.registerLazySingleton<IFundLocalProvider>(
    () => FundLocalProvider(locator()),
  );
  locator.registerLazySingleton<IFundBalanceLocalProvider>(
    () => FundBalanceLocalProvider(locator()),
  );
  locator.registerLazySingleton<IMenuLocalProvider>(
    () => MenuLocalProvider(locator()),
  );
  locator.registerLazySingleton<IEventLocalProvider>(
    () => EventLocalProvider(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerLazySingleton<IEventDetailsLocalProvider>(
    () => EventDetailsLocalProvider(locator(), locator(), locator(), locator()),
  );
  locator.registerLazySingleton<IEventOrdersLocalProvider>(
    () => EventOrdersLocalProvider(locator()),
  );
  locator.registerLazySingleton<IEventExpensesLocalProvider>(
    () =>
        EventExpensesLocalProvider(locator(), locator(), locator(), locator()),
  );
  locator.registerLazySingleton<IEventFundRatiosLocalProvider>(
    () => EventFundRatiosLocalProvider(locator()),
  );
  locator.registerLazySingleton<IEventMemberRatiosLocalProvider>(
    () => EventMemberRatiosLocalProvider(locator()),
  );
  locator.registerLazySingleton<IEventRegistrationsLocalProvider>(
    () => EventRegistrationsLocalProvider(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerLazySingleton<ISettingLocalProvider>(
    () => SettingLocalProvider(locator()),
  );
}

void _callRepositories() {
  locator.registerLazySingleton<LanguageRepository>(
    () => LanguageRepository(locator()),
  );

  locator.registerLazySingleton<IMemberRepository>(
    () => MemberRepository(locator(), locator()),
  );
  locator.registerLazySingleton<IJournalsRepository>(
    () => JournalsRepository(locator(), locator()),
  );
  locator.registerLazySingleton<IGuestRepository>(
    () => GuestRepository(locator(), locator()),
  );
  locator.registerLazySingleton<IHostRepository>(
    () => HostRepository(locator(), locator()),
  );
  locator.registerLazySingleton<IBankRepository>(
    () => BankRepository(locator(), locator()),
  );
  locator.registerLazySingleton<ITeamRepository>(
    () => TeamRepository(locator()),
  );
  locator.registerLazySingleton<ITeamDetailsRepository>(
    () => TeamDetailsRepository(locator(), locator()),
  );
  locator.registerLazySingleton<IFundRepository>(
    () => FundRepository(locator(), locator()),
  );
  locator.registerLazySingleton<IMenuRepository>(
    () => MenuRepository(locator()),
  );
  locator.registerLazySingleton<IEventRepository>(
    () => EventRepository(locator()),
  );
  locator.registerLazySingleton<IEventDetailsRepository>(
    () => EventDetailsRepository(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerLazySingleton<ISettingRepository>(
    () => SettingRepository(locator()),
  );
}
