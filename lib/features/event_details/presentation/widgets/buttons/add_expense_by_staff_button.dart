import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_expenses_cubit/event_expenses_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_registrations_cubit/event_registrations_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/modals/add_expense_settled_by_staff_modal_view.dart';

class AddExpenseByStaffButton extends StatelessWidget {
  final List<UserModel> allUsers;
  final String serializedEventInfo;
  const AddExpenseByStaffButton({
    super.key,
    required this.allUsers,
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
                    header: S.current.button_title_payEventExpenseByStaff,
                    child: AddExpenseSettledByStaffModalView(
                      eventModel: EventModel.fromJson(serializedEventInfo),
                      users: allUsers,
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
            Icons.supervised_user_circle_outlined,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
