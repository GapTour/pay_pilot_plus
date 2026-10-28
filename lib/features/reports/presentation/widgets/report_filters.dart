import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_pick_jalali_date.dart';
import 'package:pay_pilot_plus/core/widgets/app_select_raw_item_modal_view.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/features/reports/presentation/bloc/report_bloc.dart';

class ReportFilters extends StatefulWidget {
  const ReportFilters({super.key});

  @override
  State<ReportFilters> createState() => _ReportFiltersState();
}

class _ReportFiltersState extends State<ReportFilters> {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final subsidiaryController = TextEditingController();
  final detailedController = TextEditingController();

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    subsidiaryController.dispose();
    detailedController.dispose();
    super.dispose();
  }

  void _syncControllers(ReportState state) {
    fromController.text = state.from?.formattedToJalali_yearMonthDay ?? '';
    toController.text = state.to?.formattedToJalali_yearMonthDay ?? '';
    subsidiaryController.text =
        state.selectedSubsidiary?.type.localizedTitle ?? '';
    detailedController.text = state.selectedDetailed?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReportBloc>();

    return BlocConsumer<ReportBloc, ReportState>(
      listenWhen: (p, c) =>
          p.from != c.from ||
          p.to != c.to ||
          p.selectedSubsidiary?.id != c.selectedSubsidiary?.id ||
          p.selectedDetailed?.id != c.selectedDetailed?.id,
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
                      hint: S.current.report_fromDate,
                      controller: fromController,
                      suffixIcon: Icons.arrow_drop_down_circle_rounded,
                      readOnly: true,
                      onTap: (focusNode) {
                        AppPickJalaliDateModalView.pickDate(
                          header: S.current.report_fromDate,
                          initialedDate: bloc.state.from ?? DateTime.now(),
                          endDate: bloc.state.to,
                          onSelectedDate: (pickedDate) {
                            bloc.add(ReportFromDateChanged(pickedDate));
                          },
                        );
                      },
                    ),
                  ),
                  Gap(12),
                  Expanded(
                    child: AppTextField(
                      hint: S.current.report_toDate,
                      controller: toController,
                      suffixIcon: Icons.arrow_drop_down_circle_rounded,
                      readOnly: true,
                      onTap: (focusNode) {
                        AppPickJalaliDateModalView.pickDate(
                          header: S.current.report_toDate,
                          initialedDate: bloc.state.to ?? DateTime.now(),
                          startDate: bloc.state.from,
                          onSelectedDate: (pickedDate) {
                            bloc.add(ReportToDateChanged(pickedDate));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Gap(12),
              AppTextField(
                hint: S.current.journal_subsidiaryAccount,
                controller: subsidiaryController,
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                readOnly: true,
                onTap: (focusNode) {
                  final subsidiaries = bloc.state.subsidiaries;

                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: S.current.modalBottom_title_selectSubsidiary,
                    child: AppSelectRawItemModalView(
                      items: subsidiaries
                          .map(
                            (e) => (
                              id: e.id,
                              name:
                                  '${e.type.completeCode}  ${e.type.localizedTitle}',
                            ),
                          )
                          .toList(),
                      onSelect: (selected) {
                        bloc.add(
                          ReportSubsidiaryChanged(
                            subsidiaries.firstWhere((e) => e.id == selected.id),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Gap(12),
              AppTextField(
                hint: S.current.report_detailedAccount,
                controller: detailedController,
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                readOnly: true,
                onTap: (focusNode) {
                  final detailedAccounts = bloc.state.detailedAccounts;

                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: S.current.modalBottom_title_selectDetailed,
                    child: AppSelectRawItemModalView(
                      items: detailedAccounts
                          .map((e) => (id: e.id, name: '${e.code}  ${e.name}'))
                          .toList(),
                      onSelect: (selected) {
                        bloc.add(
                          ReportDetailedChanged(
                            detailedAccounts.firstWhere(
                              (e) => e.id == selected.id,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              if (state.hasFilters) ...[
                Gap(8),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton.icon(
                    onPressed: () => bloc.add(ReportFiltersCleared()),
                    icon: Icon(Icons.filter_alt_off_rounded),
                    label: Text(S.current.report_clearFilters),
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
