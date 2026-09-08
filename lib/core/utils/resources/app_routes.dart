import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/features/guests/presentation/cubit/guests_cubit.dart';
import 'package:pay_pilot_plus/features/guests/presentation/screens/guests_screen.dart';
import 'package:pay_pilot_plus/features/main/presentation/screens/main_screen.dart';
import 'package:pay_pilot_plus/features/members/presentation/cubit/members_cubit.dart';
import 'package:pay_pilot_plus/features/members/presentation/screens/members_screen.dart';
import 'package:pay_pilot_plus/features/splash/presentation/screens/splash_screen.dart';
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
      //   name: menuItemsScreen,
      //   path: MenuItemsScreen.routeName,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => MenuCubit(locator()),
      //     child: const MenuItemsScreen(),
      //   ),
      // ),
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
      // GoRoute(
      //   name: eventsScreen,
      //   path: EventsScreen.routeName,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => EventsCubit(locator()),
      //     child: const EventsScreen(),
      //   ),
      // ),
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
      // GoRoute(
      //   name: teamMembersScreen,
      //   path: TeamMembersScreen.routeName,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => RatiosCubit(locator()),
      //     child: TeamMembersScreen(
      //       teamID: state.pathParameters[AppArguments.teamDetails]!,
      //     ),
      //   ),
      // ),
      // GoRoute(
      //   name: teamsScreen,
      //   path: TeamsScreen.routeName,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => TeamsCubit(locator()),
      //     child: TeamsScreen(),
      //   ),
      // ),
      // GoRoute(
      //   name: settingsScreen,
      //   path: SettingsScreen.routeName,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => BackupBloc(locator()),
      //     child: SettingsScreen(),
      //   ),
      // ),
      // GoRoute(
      //   name: eventStoryScreen,
      //   path: EventStoryScreen.routeName,
      //   builder: (context, state) => EventStoryScreen(),
      // ),
    ],
  );
}
