import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/params/team_fund_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_string_to_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_select_raw_item_modal_view.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class EditFundRatioModalView extends StatefulWidget {
  final TeamFundModel fund;
  final List<FundModel> funds;
  final TeamModel team;
  final Map<int, double> addedMembers;
  final Map<int, double> addedFunds;
  final Function(TeamFundParams newRatio) onPressedSubmit;
  const EditFundRatioModalView({
    super.key,
    required this.fund,
    required this.funds,
    required this.team,
    required this.addedMembers,
    required this.addedFunds,
    required this.onPressedSubmit,
  });

  @override
  State<EditFundRatioModalView> createState() => _EditFundRatioModalViewState();
}

class _EditFundRatioModalViewState extends State<EditFundRatioModalView> {
  final TextEditingController ratioController = TextEditingController();
  final TextEditingController fundController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<FundModel> notAddedFunds = [];
  late double remindedRatio;
  late ({int id, String name}) fundInfo;

  @override
  void dispose() {
    ratioController.dispose();
    fundController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    fundInfo = widget.fund.fundInfo;
    ratioController.text = widget.fund.sharePercentage.round().toString();
    fundController.text = fundInfo.name;

    final editedAddedFunds = Map<int, double>.from(widget.addedFunds)
      ..remove(fundInfo.id);

    for (final fund in widget.funds) {
      if (!editedAddedFunds.containsKey(fund.id)) {
        notAddedFunds.add(fund);
      }
    }

    final memberSharesAssigned = widget.addedMembers.values.fold<double>(
      0.0,
      (sum, share) => sum + share,
    );

    final totalAssignedShares = editedAddedFunds.values.fold<double>(
      widget.fund.sharePercentage + memberSharesAssigned,
      (sum, share) => sum + share,
    );

    remindedRatio = (100.0 - totalAssignedShares + widget.fund.sharePercentage)
        .clamp(0.0, 100.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppModalColumnViewSkin(
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              AppTextField(
                label: 'صندوق',
                hint: 'انتخاب صندوق ذخیره',
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                readOnly: true,
                controller: fundController,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'انتخاب صندوق',
                    child: AppSelectRawItemModalView(
                      items: notAddedFunds
                          .map((e) => (id: e.id, name: e.title))
                          .toList(),
                      onSelect: (selected) {
                        fundInfo = selected;
                        fundController.text = selected.name;
                      },
                    ),
                  );
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.validator_required;
                  }
                  return null;
                },
              ),
              Gap(20),
              AppTextField(
                label: S.current.textField_label_ratio,
                hint: '${remindedRatio.round()}',
                readOnly: remindedRatio == 0,
                suffixIcon: Icons.percent,
                controller: ratioController,
                keyboardType: TextInputType.number,
                onTap: (focusNode) {
                  if (remindedRatio == 0) {
                    formKey.currentState!.validate();
                  }
                },
                validator: (value) {
                  final parsedValue = value.parseStringToNullableDouble;

                  if (parsedValue == null && remindedRatio > 0) {
                    return S.current.validator_required;
                  }
                  if (remindedRatio == 0) {
                    return S.current.validator_thereIsNoRatio;
                  }
                  if ((parsedValue ?? 0) > remindedRatio) {
                    return S.current.validator_ratioCanNotMoreThan(
                      remindedRatio.round(),
                    );
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        Gap(20),
      ],
      onSubmit: () {
        if (!formKey.currentState!.validate()) return;

        final ratio = TeamFundParams(
          id: widget.fund.id,
          fundInfo: fundInfo,
          teamInfo: (id: widget.team.id, name: widget.team.title),
          ratio: ratioController.text.parseStringToDouble,
        );
        widget.onPressedSubmit(ratio);
        context.pop();
      },
    );
  }
}
