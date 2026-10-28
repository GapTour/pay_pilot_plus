import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_ratios_cubit/event_ratios_cubit.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/modals/add_event_fund_modal_view.dart';

class AddFundRatioButton extends StatelessWidget {
  final String serializedEventInfo;
  final List<FundModel> allFunds;
  const AddFundRatioButton({
    super.key,
    required this.allFunds,
    required this.serializedEventInfo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventRatiosCubit, EventRatiosState>(
      builder: (context, state) {
        return RawMaterialButton(
          onPressed: () {
            final ratiosCubit = context.read<EventRatiosCubit>();

            AppBottomModalSheet.minHeightWithAppBar(
              header: S.current.button_title_addNewRatio,
              child: AddEventFundModalView(
                memberRatios: state.memberRatios,
                fundRatios: state.fundRatios,
                funds: allFunds,
                eventDetails: EventModel.fromJson(serializedEventInfo),
                onSubmit: (newRatio) {
                  ratiosCubit.addFundRatio(newRatio);
                },
              ),
            );
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: Icon(Icons.wallet_rounded, color: Colors.white),
        );
      },
    );
  }
}
