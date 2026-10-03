import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_registrations_cubit/event_registrations_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/modals/attend_guest_modal_view.dart';

class AttendGuestButton extends StatelessWidget {
  final List<UserModel> allUsers;
  final List<FundModel> allFunds;
  final List<BankModel> allBanks;
  final String serializedEventInfo;
  const AttendGuestButton({
    super.key,
    required this.allUsers,
    required this.allFunds,
    required this.allBanks,
    required this.serializedEventInfo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventRegistrationsCubit, EventRegistrationsState>(
      buildWhen: (p, c) =>
          p.registrationFetchStatus != c.registrationFetchStatus ||
          p.registrationModificationStatus != c.registrationModificationStatus,
      builder: (context, state) {
        final registrationsCubit = context.read<EventRegistrationsCubit>();

        return RawMaterialButton(
          onPressed: state.registrationFetchStatus.isSuccess
              ? () {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'ثبت نام مهمان',
                    child: AttendGuestModalView(
                      eventModel: EventModel.fromJson(serializedEventInfo),
                      addedUsersID: state.addedUsersID,
                      users: allUsers,
                      banks: allBanks,
                      funds: allFunds,
                      onSubmit: (registrationParams) {
                        registrationsCubit.registerGuest(registrationParams);
                      },
                    ),
                  );
                }
              : null,
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: Icon(Icons.group_add_outlined, color: Colors.white),
        );
      },
    );
  }
}
