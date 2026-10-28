import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/resources/app_routes.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/features/simple_reports/presentation/cubits/salary_report_cubit/salary_report_cubit.dart';
import 'package:pay_pilot_plus/features/simple_reports/presentation/widgets/member_salary_tile.dart';
import 'package:pay_pilot_plus/features/simple_reports/presentation/widgets/salary_filters.dart';
import 'package:pay_pilot_plus/features/simple_reports/presentation/widgets/simple_report_banner.dart';

class SalaryReportScreen extends StatefulWidget {
  static const routeName = '/salary-report';

  const SalaryReportScreen({super.key});

  @override
  State<SalaryReportScreen> createState() => _SalaryReportScreenState();
}

class _SalaryReportScreenState extends State<SalaryReportScreen> {
  @override
  void initState() {
    super.initState();

    context.read<SalaryReportCubit>().loadReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('حقوق اعضا')),
      body: Column(
        children: [
          SalaryFilters(),
          Expanded(
            child: BlocBuilder<SalaryReportCubit, SalaryReportState>(
              buildWhen: (p, c) => p.salaryReportStatus != c.salaryReportStatus,
              builder: (context, state) {
                final summaries = state.summaries;
                final isLoading =
                    state.salaryReportStatus == .loading ||
                    state.salaryReportStatus == .initial;

                if (isLoading) {
                  return AppLoadingState();
                }

                if (state.salaryReportStatus == .failure) {
                  return Center(child: Text('خطا در دریافت گزارش!'));
                }

                return Column(
                  children: [
                    SimpleReportBanner(
                      rows: [
                        (
                          title: 'جمع حقوق همه اعضا',
                          value: state.totalSalary.addSeparator(),
                        ),
                        (title: 'تعداد اعضا', value: '${summaries.length}'),
                      ],
                    ),
                    Gap(12),
                    Expanded(
                      child: AppList(
                        itemCount: summaries.length,
                        emptyInboxMessage: 'در این بازه حقوقی ثبت نشده است!',
                        itemBuilder: (context, index) {
                          final summary = summaries[index];

                          return MemberSalaryTile(
                            summary: summary,
                            onPreview: () {
                              context.pushNamed(
                                AppRoutes.memberSalaryDetailsScreen,
                                extra: {
                                  AppArguments.serializedSalarySummary: summary
                                      .toJson(),
                                },
                              );
                            },
                          );
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
