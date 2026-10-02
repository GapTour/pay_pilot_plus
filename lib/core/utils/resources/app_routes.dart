import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/features/banks/presentation/cubits/bank_balance/bank_balance_cubit.dart';
import 'package:pay_pilot_plus/features/banks/presentation/cubits/banks/banks_cubit.dart';
import 'package:pay_pilot_plus/features/banks/presentation/screens/bank_balance_screen.dart';
import 'package:pay_pilot_plus/features/banks/presentation/screens/banks_screen.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_details_cubit/event_details_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_expenses_cubit/event_expenses_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_orders_cubit/event_orders_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_ratios_cubit/event_ratios_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_registrations_cubit/event_registrations_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/screens/event_details_screen.dart';
import 'package:pay_pilot_plus/features/events/presentation/blocs/events_cubit/events_cubit.dart';
import 'package:pay_pilot_plus/features/events/presentation/screens/events_screen.dart';
import 'package:pay_pilot_plus/features/funds/presentation/cubit/fund_balance/fund_balance_cubit.dart';
import 'package:pay_pilot_plus/features/funds/presentation/cubit/funds/funds_cubit.dart';
import 'package:pay_pilot_plus/features/funds/presentation/screens/fund_balance_screen.dart';
import 'package:pay_pilot_plus/features/funds/presentation/screens/funds_screen.dart';
import 'package:pay_pilot_plus/features/guests/presentation/cubit/guest_balance/guest_balance_cubit.dart';
import 'package:pay_pilot_plus/features/guests/presentation/cubit/guests/guests_cubit.dart';
import 'package:pay_pilot_plus/features/guests/presentation/screens/guest_balance_screen.dart';
import 'package:pay_pilot_plus/features/guests/presentation/screens/guests_screen.dart';
import 'package:pay_pilot_plus/features/hosts/presentation/cubit/host_balance/host_balance_cubit.dart';
import 'package:pay_pilot_plus/features/hosts/presentation/cubit/hosts/hosts_cubit.dart';
import 'package:pay_pilot_plus/features/hosts/presentation/screens/host_balance_screen.dart';
import 'package:pay_pilot_plus/features/hosts/presentation/screens/hosts_screen.dart';
import 'package:pay_pilot_plus/features/journal_headers/presentation/cubits/headers_cubit/headers_cubit.dart';
import 'package:pay_pilot_plus/features/journal_headers/presentation/cubits/journals_cubit/journals_cubit.dart';
import 'package:pay_pilot_plus/features/journal_headers/presentation/screens/headers_screen.dart';
import 'package:pay_pilot_plus/features/journal_headers/presentation/screens/journals_screen.dart';
import 'package:pay_pilot_plus/features/main/presentation/screens/main_screen.dart';
import 'package:pay_pilot_plus/features/members/presentation/cubit/member_balance/member_balance_cubit.dart';
import 'package:pay_pilot_plus/features/members/presentation/cubit/members/members_cubit.dart';
import 'package:pay_pilot_plus/features/members/presentation/screens/member_balance_screen.dart';
import 'package:pay_pilot_plus/features/members/presentation/screens/members_screen.dart';
import 'package:pay_pilot_plus/features/menu_items/presentation/cubit/menu_items_cubit.dart';
import 'package:pay_pilot_plus/features/menu_items/presentation/screens/menu_items_screen.dart';
import 'package:pay_pilot_plus/features/settings/presentation/bloc/backup_bloc.dart';
import 'package:pay_pilot_plus/features/settings/presentation/screens/settings_screen.dart';
import 'package:pay_pilot_plus/features/splash/presentation/screens/splash_screen.dart';
import 'package:pay_pilot_plus/features/team_details/presentation/cubit/ratios_cubit.dart';
import 'package:pay_pilot_plus/features/team_details/presentation/screens/team_members_screen.dart';
import 'package:pay_pilot_plus/features/teams/presentation/cubit/teams_cubit.dart';
import 'package:pay_pilot_plus/features/teams/presentation/screens/teams_screen.dart';
import 'package:pay_pilot_plus/locator.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static const String mainScreen = 'mainScreen';
  static const String menuItemsScreen = 'menuItemsScreen';
  static const String loginScreen = 'loginScreen';
  static const String registerScreen = 'registerScreen';
  static const String splashScreen = 'splashScreen';
  static const String membersScreen = 'membersScreen';
  static const String memberBalanceScreen = 'memberBalanceScreen';
  static const String banksScreen = 'banksScreen';
  static const String bankBalanceScreen = 'bankBalanceScreen';
  static const String hostsScreen = 'hostsScreen';
  static const String hostBalanceScreen = 'hostBalanceScreen';
  static const String guestsScreen = 'guestsScreen';
  static const String guestBalanceScreen = 'guestBalanceScreen';
  static const String eventsScreen = 'eventsScreen';
  static const String eventDetailsScreen = 'eventDetailsScreen';
  static const String eventStoryScreen = 'eventStoryScreen';
  static const String reportsScreen = 'reportsScreen';
  static const String reportDetailsScreen = 'reportDetailsScreen';
  static const String teamsScreen = 'teamsScreen';
  static const String teamMembersScreen = 'teamMembersScreen';
  static const String fundsScreen = 'fundsScreen';
  static const String fundBalanceScreen = 'fundBalanceScreen';
  static const String fundAllocationsScreen = 'fundAllocationsScreen';
  static const String settingsScreen = 'settingsScreen';
  static const String headersScreen = 'headersScreen';
  static const String journalsScreen = 'journalsScreen';

  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: kDebugMode,
    initialLocation: SplashScreen.routeName,
    routes: [
      GoRoute(
        name: splashScreen,
        path: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: mainScreen,
        path: MainScreen.routeName,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        name: headersScreen,
        path: HeadersScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => HeadersCubit(locator()),
          child: const HeadersScreen(),
        ),
      ),
      GoRoute(
        name: journalsScreen,
        path: JournalsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => JournalsCubit(locator()),
          child: const JournalsScreen(),
        ),
      ),
      GoRoute(
        name: membersScreen,
        path: MembersScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => MembersCubit(locator()),
          child: const MembersScreen(),
        ),
      ),
      GoRoute(
        name: memberBalanceScreen,
        path: MemberBalanceScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => MemberBalanceCubit(locator()),
          child: MemberBalanceScreen(),
        ),
      ),
      GoRoute(
        name: banksScreen,
        path: BanksScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => BanksCubit(locator()),
          child: const BanksScreen(),
        ),
      ),
      GoRoute(
        name: bankBalanceScreen,
        path: BankBalanceScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => BankBalanceCubit(locator()),
          child: const BankBalanceScreen(),
        ),
      ),
      GoRoute(
        name: menuItemsScreen,
        path: MenuItemsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => MenuItemsCubit(locator()),
          child: const MenuItemsScreen(),
        ),
      ),
      GoRoute(
        name: hostsScreen,
        path: HostsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => HostsCubit(locator()),
          child: const HostsScreen(),
        ),
      ),
      GoRoute(
        name: hostBalanceScreen,
        path: HostBalanceScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => HostBalanceCubit(locator()),
          child: HostBalanceScreen(),
        ),
      ),
      GoRoute(
        name: guestsScreen,
        path: GuestsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => GuestsCubit(locator()),
          child: const GuestsScreen(),
        ),
      ),
      GoRoute(
        name: guestBalanceScreen,
        path: GuestBalanceScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => GuestBalanceCubit(locator()),
          child: GuestBalanceScreen(),
        ),
      ),
      // GoRoute(
      //   name: reportsScreen,
      //   path: ReportsScreen.routeName,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => ReportsCubit(locator()),
      //     child: const ReportsScreen(),
      //   ),
      // ),
      GoRoute(
        name: eventsScreen,
        path: EventsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => EventsCubit(locator()),
          child: const EventsScreen(),
        ),
      ),
      GoRoute(
        name: eventDetailsScreen,
        path: EventDetailsScreen.routeName,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => EventDetailsCubit(locator())),
            BlocProvider(
              create: (context) => EventRegistrationsCubit(locator()),
            ),
            BlocProvider(create: (context) => EventRatiosCubit(locator())),
            BlocProvider(create: (context) => EventOrdersCubit(locator())),
            BlocProvider(create: (context) => EventExpensesCubit(locator())),
          ],
          child: EventDetailsScreen(),
        ),
      ),
      // GoRoute(
      //   name: reportDetailsScreen,
      //   path: ReportDetailsScreen.routeName,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => ReportDetailsBloc(locator()),
      //     child: ReportDetailsScreen(
      //       reportID: state.pathParameters[AppArguments.reportDetails]!,
      //     ),
      //   ),
      // ),
      GoRoute(
        name: fundsScreen,
        path: FundsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => FundsCubit(locator()),
          child: FundsScreen(),
        ),
      ),
      GoRoute(
        name: fundBalanceScreen,
        path: FundBalanceScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => FundBalanceCubit(locator()),
          child: FundBalanceScreen(),
        ),
      ),
      GoRoute(
        name: teamsScreen,
        path: TeamsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => TeamsCubit(locator()),
          child: TeamsScreen(),
        ),
      ),
      GoRoute(
        name: teamMembersScreen,
        path: TeamMembersScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => RatiosCubit(locator()),
          child: TeamMembersScreen(),
        ),
      ),
      GoRoute(
        name: settingsScreen,
        path: SettingsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => BackupBloc(locator()),
          child: SettingsScreen(),
        ),
      ),
      // GoRoute(
      //   name: eventStoryScreen,
      //   path: EventStoryScreen.routeName,
      //   builder: (context, state) => EventStoryScreen(),
      // ),
    ],
  );
}
