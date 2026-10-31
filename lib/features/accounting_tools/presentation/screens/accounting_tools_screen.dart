import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/resources/app_routes.dart';
import 'package:pay_pilot_plus/core/widgets/app_elevated_button.dart';

/// ابزارهای حسابداری: صفحه‌هایی که کار با آن‌ها به دانش حسابداری نیاز دارد
class AccountingToolsScreen extends StatelessWidget {
  static const routeName = '/accounting-tools';

  const AccountingToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget tool(String title, String route) => AppElevatedButton(
      child: Center(
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
      onTap: () => context.pushNamed(route),
    );

    return Scaffold(
      appBar: AppBar(title: Text(S.current.button_title_accountingTools)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          children: [
            tool(S.current.button_title_reports, AppRoutes.reportsScreen),
            tool(S.current.button_title_journals, AppRoutes.headersScreen),
          ],
        ),
      ),
    );
  }
}
