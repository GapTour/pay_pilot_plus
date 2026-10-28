import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_expenses_cubit/event_expenses_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_registrations_cubit/event_registrations_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/modals/add_expense_settled_by_bank_modal_view.dart';

class AddExpenseByBankButton extends StatelessWidget {
  final List<BankModel> allBanks;
  final List<FundModel> allFunds;
  final String serializedEventInfo;
  const AddExpenseByBankButton({
    super.key,
    required this.allBanks,
    required this.allFunds,
    required this.serializedEventInfo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventRegistrationsCubit, EventRegistrationsState>(
      buildWhen: (p, c) =>
          p.registrationFetchStatus != c.registrationFetchStatus,
      builder: (context, state) {
        final expenseCubit = context.read<EventExpensesCubit>();

        return RawMaterialButton(
          onPressed: state.registrationFetchStatus.isSuccess
              ? () {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: S.current.button_title_payEventExpenseByBank,
                    child: AddExpenseSettledByBankModalView(
                      eventModel: EventModel.fromJson(serializedEventInfo),
                      funds: allFunds,
                      banks: allBanks,
                      onSubmit: (params) {
                        expenseCubit.insertExpense(params);
                      },
                    ),
                  );
                }
              : null,
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: Icon(
            Icons.payments_outlined,
            color: context.colorScheme.onSurface,
          ),
        );
      },
    );
  }
}
