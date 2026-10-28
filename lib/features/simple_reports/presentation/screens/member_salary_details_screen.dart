import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/member_salary_summary_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/simple_reports/presentation/widgets/member_balance_text.dart';
import 'package:pay_pilot_plus/features/simple_reports/presentation/widgets/simple_report_banner.dart';
import 'package:pay_pilot_plus/features/simple_reports/presentation/widgets/simple_report_info_text.dart';

class MemberSalaryDetailsScreen extends StatelessWidget {
  static const routeName = '/member-salary-details';

  const MemberSalaryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final summary = MemberSalarySummaryModel.fromJson(
      (context.goRouterState
          as Map<String, String>)[AppArguments.serializedSalarySummary]!,
    );
    final items = summary.items;

    return Scaffold(
      appBar: AppBar(title: Text(S.current.simpleReport_salaryDetails)),
      body: Column(
        children: [
          Gap(20),
          SimpleReportBanner(
            title: summary.memberInfo.name,
            rows: [
              (
                title: S.current.simpleReport_totalSalary,
                value: summary.totalSalary.addSeparator(),
              ),
              (
                title: S.current.simpleReport_eventsCount,
                value: '${summary.eventsCount}',
              ),
              (
                title: S.current.simpleReport_accountStatus,
                value: summary.currentBalance.memberBalanceText,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              S.current.simpleReport_accountStatusNote,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: AppList(
              itemCount: items.length,
              emptyInboxMessage: S.current.simpleReport_noSalary,
              itemBuilder: (context, index) {
                final item = items[index];

                return AppTileInRow(
                  parent: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.eventInfo?.name ?? S.current.simpleReport_noEvent,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Gap(8),
                      SimpleReportInfoText(
                        title: S.current.textField_label_date,
                        value: item.date.formattedToJalali_yearMonthDay,
                      ),
                      SimpleReportInfoText(
                        title: S.current.simpleReport_salaryAmount,
                        value: item.amount.addSeparator(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
