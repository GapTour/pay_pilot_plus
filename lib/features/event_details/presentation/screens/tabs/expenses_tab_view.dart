import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_list.dart';
import 'package:pay_pilot_plus/core/widgets/app_loading_state.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_details_cubit/event_details_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_expenses_cubit/event_expenses_cubit.dart';

class ExpensesTabView extends StatefulWidget {
  final EventModel eventDetails;
  const new(this.eventDetails, {super.key});

  @override
  State<ExpensesTabView> createState() => _ExpensesTabViewState();
}

class _ExpensesTabViewState extends State<ExpensesTabView> {
  @override
  void initState() {
    super.initState();

    context.read<EventDetailsCubit>().changeTabStatus(.expenses);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventExpensesCubit, EventExpensesState>(
      buildWhen: (p, c) {
        final isFetched = p.expensesFetchStatus != c.expensesFetchStatus;
        final isModified =
            p.expenseModificationStatus != c.expenseModificationStatus;

        if (isFetched || isModified) return true;

        return false;
      },
      builder: (context, state) {
        final allExpenses = state.allExpenses;

        final isLoadingToFetch =
            state.expensesFetchStatus.isInitial ||
            state.expensesFetchStatus.isLoading;
        final isLoadingToModified = state.expenseModificationStatus.isLoading;

        if (isLoadingToFetch || isLoadingToModified) {
          return AppLoadingState();
        }

        return AppList(
          itemCount: allExpenses.length,
          emptyInboxMessage: 'هیچ هزینه ای ثبت نشده!',
          itemBuilder: (context, index) {
            return AppTileInRow(
              onDelete: widget.eventDetails.isClosed
                  ? null
                  : () {
                      final element = allExpenses[index];

                      context.read<EventExpensesCubit>().deleteExpense(
                        element.series,
                      );
                    },
              parent: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    children: [
                      Text(
                        allExpenses[index].subsidiaryAccountType.title,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Spacer(),
                      Text(allExpenses[index].amount.addSeparator()),
                    ],
                  ),
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            if (allExpenses[index].bankInfo?.name != null) ...[
                              TextSpan(
                                text: 'پرداخت از بانک  ',
                                style: context.themeOf.textTheme.headlineSmall,
                              ),
                              TextSpan(
                                text: allExpenses[index].bankInfo!.name,
                                style: context.themeOf.textTheme.displayMedium,
                              ),
                            ],
                            if (allExpenses[index].staffInfo?.name != null) ...[
                              TextSpan(
                                text: 'واگذاری به حساب  ',
                                style: context.themeOf.textTheme.headlineSmall,
                              ),
                              TextSpan(
                                text: allExpenses[index].staffInfo!.name,
                                style: context.themeOf.textTheme.displayMedium,
                              ),
                            ],
                          ],
                        ),
                      ),
                      Spacer(),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '      در تاریخ   ',
                              style: context.themeOf.textTheme.headlineSmall,
                            ),
                            TextSpan(
                              text: allExpenses[index]
                                  .paidAt
                                  .formattedToJalali_yearMonthDay,
                              style: context.themeOf.textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (allExpenses[index].fundBalance != null)
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'کسر از کیف ذخیره  ',
                            style: context.themeOf.textTheme.headlineSmall,
                          ),
                          TextSpan(
                            text: allExpenses[index].fundBalance!.title,
                            style: context.themeOf.textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
