import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/features/banks/presentation/cubit/banks_cubit.dart';
import 'package:pay_pilot_plus/features/banks/presentation/screens/banks_screen.dart';
import 'package:pay_pilot_plus/features/events/presentation/cubit/events_cubit.dart';
import 'package:pay_pilot_plus/features/events/presentation/screens/events_screen.dart';
import 'package:pay_pilot_plus/features/guests/presentation/cubit/guests_cubit.dart';
import 'package:pay_pilot_plus/features/guests/presentation/screens/guests_screen.dart';
import 'package:pay_pilot_plus/features/hosts/presentation/cubit/hosts_cubit.dart';
import 'package:pay_pilot_plus/features/hosts/presentation/screens/hosts_screen.dart';
import 'package:pay_pilot_plus/features/main/presentation/screens/main_screen.dart';
import 'package:pay_pilot_plus/features/members/presentation/cubit/members_cubit.dart';
import 'package:pay_pilot_plus/features/members/presentation/screens/members_screen.dart';
import 'package:pay_pilot_plus/features/menu_items/presentation/cubit/menu_items_cubit.dart';
import 'package:pay_pilot_plus/features/menu_items/presentation/screens/menu_items_screen.dart';
import 'package:pay_pilot_plus/features/settings/presentation/bloc/backup_bloc.dart';
import 'package:pay_pilot_plus/features/settings/presentation/screens/settings_screen.dart';
import 'package:pay_pilot_plus/features/splash/presentation/screens/splash_screen.dart';
import 'package:pay_pilot_plus/features/team_members/presentation/cubit/ratios_cubit.dart';
import 'package:pay_pilot_plus/features/team_members/presentation/screens/team_members_screen.dart';
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
  static const String memberDetailsScreen = 'memberDetailsScreen';
  static const String banksScreen = 'banksScreen';
  static const String bankDetailsScreen = 'bankDetailsScreen';
  static const String hostsScreen = 'hostsScreen';
  static const String hostDetailsScreen = 'hostDetailsScreen';
  static const String guestsScreen = 'guestsScreen';
  static const String guestDetailsScreen = 'guestDetailsScreen';
  static const String eventsScreen = 'eventsScreen';
  static const String eventDetailsScreen = 'eventDetailsScreen';
  static const String eventStoryScreen = 'eventStoryScreen';
  static const String reportsScreen = 'reportsScreen';
  static const String reportDetailsScreen = 'reportDetailsScreen';
  static const String teamsScreen = 'teamsScreen';
  static const String teamMembersScreen = 'teamMembersScreen';
  static const String settingsScreen = 'settingsScreen';

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
        name: membersScreen,
        path: MembersScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => MembersCubit(locator()),
          child: const MembersScreen(),
        ),
      ),
      // GoRoute(
      //   name: memberDetailsScreen,
      //   path: MemberDetailsScreen.routeName,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => MembersDetailsCubit(locator()),
      //     child: MemberDetailsScreen(
      //       memberID: state.pathParameters[AppArguments.memberDetails]!,
      //     ),
      //   ),
      // ),
      GoRoute(
        name: banksScreen,
        path: BanksScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => BanksCubit(locator()),
          child: const BanksScreen(),
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
        name: guestsScreen,
        path: GuestsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => GuestsCubit(locator()),
          child: const GuestsScreen(),
        ),
      ),
      // GoRoute(
      //   name: guestDetailsScreen,
      //   path: GuestDetailsScreen.routeName,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => GuestsDetailsCubit(locator()),
      //     child: GuestDetailsScreen(
      //       guestID: state.pathParameters[AppArguments.guestDetails]!,
      //     ),
      //   ),
      // ),
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
      // GoRoute(
      //   name: eventDetailsScreen,
      //   path: EventDetailsScreen.routeName,
      //   builder: (context, state) => MultiBlocProvider(
      //     providers: [
      //       BlocProvider(create: (context) => EventDetailsBloc(locator())),
      //     ],
      //     child: EventDetailsScreen(
      //       eventID: state.pathParameters[AppArguments.eventDetails]!,
      //     ),
      //   ),
      // ),
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
