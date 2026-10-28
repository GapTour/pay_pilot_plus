import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/widgets/app_journal_tile.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/features/reports/presentation/bloc/report_bloc.dart';
import 'package:pay_pilot_plus/features/reports/presentation/widgets/report_filters.dart';
import 'package:pay_pilot_plus/features/reports/presentation/widgets/report_summary_banner.dart';

class ReportsScreen extends StatefulWidget {
  static const routeName = '/reports';

  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ReportBloc>().add(ReportStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.button_title_reports)),
      body: Column(
        children: [
          ReportFilters(),
          Expanded(
            child: BlocBuilder<ReportBloc, ReportState>(
              buildWhen: (p, c) => p.reportStatus != c.reportStatus,
              builder: (context, state) {
                final lines = state.lines;
                final isLoading =
                    state.reportStatus == .loading ||
                    state.reportStatus == .initial;

                if (isLoading) {
                  return AppLoadingState();
                }

                if (state.reportStatus == .failure) {
                  return Center(child: Text('خطا در دریافت گزارش!'));
                }

                return Column(
                  children: [
                    ReportSummaryBanner(
                      totalDebit: state.totalDebit,
                      totalCredit: state.totalCredit,
                      balance: state.balance,
                      linesCount: lines.length,
                    ),
                    Gap(12),
                    Expanded(
                      child: AppList(
                        itemCount: lines.length,
                        emptyInboxMessage: 'هیچ ردیفی برای این گزارش یافت نشد!',
                        itemBuilder: (context, index) {
                          return AppJournalTile(journal: lines[index]);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
