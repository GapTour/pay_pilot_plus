import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/member_allocation_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_string_to_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_select_raw_item_modal_view.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class AddSharePartnerModalView extends StatefulWidget {
  final List<TeamMemberModel> memberRatios;
  final List<TeamFundModel> fundRatios;
  final List<UserModel> users;
  final EventModel eventDetails;
  final Function(MemberAllocationParams newRatio) onSubmit;
  const AddSharePartnerModalView({
    super.key,
    required this.memberRatios,
    required this.fundRatios,
    required this.users,
    required this.eventDetails,
    required this.onSubmit,
  });

  @override
  State<AddSharePartnerModalView> createState() =>
      _AddSharePartnerModalViewState();
}

class _AddSharePartnerModalViewState extends State<AddSharePartnerModalView> {
  final TextEditingController ratioController = TextEditingController();
  final TextEditingController memberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<UserModel> notAddedMembers = [];
  late double remindedRatio;
  ({int id, String name})? memberInfo;

  @override
  void dispose() {
    ratioController.dispose();
    memberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final sumFundRatios = widget.fundRatios.fold<double>(
      0,
      (sum, element) => sum + element.sharePercentage,
    );

    remindedRatio = widget.memberRatios.fold<double>(
      100.0 - sumFundRatios,
      (sum, ratio) => sum - ratio.sharePercentage,
    );

    final addedUserIds = widget.memberRatios.map((e) => e.userInfo.id).toSet();

    for (final user in widget.users) {
      if (user.role.isStaff && !addedUserIds.contains(user.id)) {
        notAddedMembers.add(user);
      }
    }
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
                label: S.current.dropDownButton_label_members,
                hint: S.current.dropDownButton_hint_selectMember,
                readOnly: true,
                controller: memberController,
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'انتخاب اعضا',
                    child: AppSelectRawItemModalView(
                      items: notAddedMembers
                          .map((e) => (id: e.id, name: e.name))
                          .toList(),
                      onSelect: (selected) {
                        memberInfo = selected;
                        memberController.text = selected.name;
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

        final ratio = MemberAllocationParams(
          id: null,
          eventInfo: (
            id: widget.eventDetails.id,
            name: widget.eventDetails.title,
          ),
          usersInfo: [
            (
              id: memberInfo!.id,
              name: memberInfo!.name,
              ratio: ratioController.text.parseStringToDouble,
            ),
          ],
        );
        widget.onSubmit(ratio);
        context.pop();
      },
    );
  }
}
