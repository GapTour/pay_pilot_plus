import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/member_salary_summary_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/simple_reports/presentation/widgets/member_balance_text.dart';
import 'package:pay_pilot_plus/features/simple_reports/presentation/widgets/simple_report_info_text.dart';

class MemberSalaryTile extends StatelessWidget {
  final MemberSalarySummaryModel summary;
  final VoidCallback onPreview;
  const new({required this.summary, required this.onPreview, super.key});

  @override
  Widget build(BuildContext context) {
    return AppTileInRow(
      onPreview: onPreview,
      parent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            summary.memberInfo.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Gap(8),
          SimpleReportInfoText(
            title: S.current.simpleReport_totalSalary,
            value: summary.totalSalary.addSeparator(),
          ),
          SimpleReportInfoText(
            title: S.current.simpleReport_eventsCount,
            value: '${summary.eventsCount}',
          ),
          SimpleReportInfoText(
            title: S.current.simpleReport_accountStatus,
            value: summary.currentBalance.memberBalanceText,
          ),
        ],
      ),
    );
  }
}
