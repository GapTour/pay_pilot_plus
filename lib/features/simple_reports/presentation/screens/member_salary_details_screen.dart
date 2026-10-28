import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/member_salary_summary_model.dart';
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
      appBar: AppBar(title: Text('جزییات حقوق')),
      body: Column(
        children: [
          Gap(20),
          SimpleReportBanner(
            title: summary.memberInfo.name,
            rows: [
              (title: 'جمع حقوق', value: summary.totalSalary.addSeparator()),
              (title: 'تعداد رویدادها', value: '${summary.eventsCount}'),
              (
                title: 'وضعیت حساب',
                value: summary.currentBalance.memberBalanceText,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              'وضعیت حساب شامل همه پرداخت‌ها و طلب‌های عضو است، نه فقط حقوق.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: AppList(
              itemCount: items.length,
              emptyInboxMessage: 'حقوقی ثبت نشده است!',
              itemBuilder: (context, index) {
                final item = items[index];

                return AppTileInRow(
                  parent: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.eventInfo?.name ?? 'بدون رویداد',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Gap(8),
                      SimpleReportInfoText(
                        title: 'تاریخ',
                        value: item.date.formattedToJalali_yearMonthDay,
                      ),
                      SimpleReportInfoText(
                        title: 'مبلغ حقوق',
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
