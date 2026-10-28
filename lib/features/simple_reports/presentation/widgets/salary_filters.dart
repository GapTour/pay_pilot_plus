import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_pick_jalali_date.dart';
import 'package:pay_pilot_plus/core/widgets/app_select_raw_item_modal_view.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/features/simple_reports/presentation/cubits/salary_report_cubit/salary_report_cubit.dart';

class SalaryFilters extends StatefulWidget {
  const SalaryFilters({super.key});

  @override
  State<SalaryFilters> createState() => _SalaryFiltersState();
}

class _SalaryFiltersState extends State<SalaryFilters> {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final eventController = TextEditingController();

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    eventController.dispose();
    super.dispose();
  }

  void _syncControllers(SalaryReportState state) {
    fromController.text = state.from?.formattedToJalali_yearMonthDay ?? '';
    toController.text = state.to?.formattedToJalali_yearMonthDay ?? '';
    eventController.text = state.selectedEvent?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SalaryReportCubit>();

    return BlocConsumer<SalaryReportCubit, SalaryReportState>(
      listenWhen: (p, c) =>
          p.from != c.from ||
          p.to != c.to ||
          p.selectedEvent != c.selectedEvent,
      listener: (context, state) => _syncControllers(state),
      buildWhen: (p, c) => p.hasFilters != c.hasFilters,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      hint: 'از تاریخ',
                      controller: fromController,
                      suffixIcon: Icons.arrow_drop_down_circle_rounded,
                      readOnly: true,
                      onTap: (focusNode) {
                        AppPickJalaliDateModalView.pickDate(
                          header: 'از تاریخ',
                          initialedDate: cubit.state.from ?? DateTime.now(),
                          endDate: cubit.state.to,
                          onSelectedDate: cubit.changeFromDate,
                        );
                      },
                    ),
                  ),
                  Gap(12),
                  Expanded(
                    child: AppTextField(
                      hint: 'تا تاریخ',
                      controller: toController,
                      suffixIcon: Icons.arrow_drop_down_circle_rounded,
                      readOnly: true,
                      onTap: (focusNode) {
                        AppPickJalaliDateModalView.pickDate(
                          header: 'تا تاریخ',
                          initialedDate: cubit.state.to ?? DateTime.now(),
                          startDate: cubit.state.from,
                          onSelectedDate: cubit.changeToDate,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Gap(12),
              AppTextField(
                hint: 'همه رویدادها',
                controller: eventController,
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                readOnly: true,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'انتخاب رویداد',
                    child: AppSelectRawItemModalView(
                      items: cubit.state.events,
                      onSelect: cubit.changeEvent,
                    ),
                  );
                },
              ),
              if (state.hasFilters) ...[
                Gap(8),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton.icon(
                    onPressed: cubit.clearFilters,
                    icon: Icon(Icons.filter_alt_off_rounded),
                    label: Text('حذف فیلترها'),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
