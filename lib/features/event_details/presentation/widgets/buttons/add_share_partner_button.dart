import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_ratios_cubit/event_ratios_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/modals/add_share_partner_modal_view.dart';

class AddSharePartnerButton extends StatelessWidget {
  final String serializedEventInfo;
  final List<UserModel> allUsers;
  const AddSharePartnerButton({
    super.key,
    required this.allUsers,
    required this.serializedEventInfo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventRatiosCubit, EventRatiosState>(
      builder: (context, state) {
        final ratiosCubit = context.read<EventRatiosCubit>();

        return RawMaterialButton(
          onPressed: () {
            AppBottomModalSheet.minHeightWithAppBar(
              header: S.current.button_title_addNewRatio,
              child: AddSharePartnerModalView(
                memberRatios: state.memberRatios,
                fundRatios: state.fundRatios,
                users: allUsers,
                eventDetails: EventModel.fromJson(serializedEventInfo),
                onSubmit: (newRatio) {
                  ratiosCubit.addMemberRatio(newRatio);
                },
              ),
            );
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: Icon(
            Icons.pie_chart_outline,
            color: context.colorScheme.onSurface,
          ),
        );
      },
    );
  }
}
