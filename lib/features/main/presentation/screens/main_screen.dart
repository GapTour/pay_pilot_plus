import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_settings.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/resources/app_routes.dart';
import 'package:pay_pilot_plus/core/widgets/app_menu_tile.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main';

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget tile(IconData icon, String title, String route) => AppMenuTile(
      icon: icon,
      title: title,
      onTap: () => context.pushNamed(route),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Pilot +', textDirection: .ltr),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: S.current.button_title_settings,
            onPressed: () => context.pushNamed(AppRoutes.settingsScreen),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        children: [
          // کار روزانه؛ برای همین جدا و پررنگ‌تر از بقیه
          const _EventsCard(),
          AppMenuSection(
            title: S.current.mainMenu_people,
            children: [
              tile(
                Icons.badge_outlined,
                S.current.button_title_members,
                AppRoutes.membersScreen,
              ),
              tile(
                Icons.person_outline,
                S.current.button_title_guests,
                AppRoutes.guestsScreen,
              ),
              tile(
                Icons.home_outlined,
                S.current.host_appBarTitle,
                AppRoutes.hostsScreen,
              ),
            ],
          ),
          AppMenuSection(
            title: S.current.mainMenu_money,
            children: [
              tile(
                Icons.account_balance_outlined,
                S.current.button_title_banks,
                AppRoutes.banksScreen,
              ),
              tile(
                Icons.savings_outlined,
                S.current.button_title_funds,
                AppRoutes.fundsScreen,
              ),
            ],
          ),
          AppMenuSection(
            title: S.current.mainMenu_reports,
            children: [
              tile(
                Icons.insert_chart_outlined,
                S.current.button_title_simpleReports,
                AppRoutes.simpleReportsScreen,
              ),
              tile(
                Icons.calculate_outlined,
                S.current.button_title_accountingTools,
                AppRoutes.accountingToolsScreen,
              ),
            ],
          ),
          Gap(24),
          Text(
            'Version ${AppSettings.version}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.colorScheme.onSurfaceVariant.withAlpha(180),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _EventsCard extends StatelessWidget {
  const _EventsCard();

  @override
  Widget build(BuildContext context) {
    final onPrimary = context.colorScheme.onPrimary;
    final textTheme = context.themeOf.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Material(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.pushNamed(AppRoutes.eventsScreen),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Row(
              children: [
                Icon(Icons.event_outlined, color: onPrimary, size: 32),
                Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 4,
                    children: [
                      Text(
                        S.current.button_title_events,
                        style: textTheme.titleLarge?.copyWith(color: onPrimary),
                      ),
                      Text(
                        S.current.mainMenu_eventsSubtitle,
                        style: textTheme.bodyMedium?.copyWith(color: onPrimary),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: onPrimary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
