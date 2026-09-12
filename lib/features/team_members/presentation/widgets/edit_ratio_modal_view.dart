import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/team_member_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/persian_numbers_converter_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_select_modal_view.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class EditRatioModalView extends StatefulWidget {
  final TeamMemberModel teamMember;
  final List<UserModel> members;
  final TeamModel team;
  final Map<int, double> addedMembers;
  final Function(TeamMemberParams newRatio) onPressedSubmit;
  const EditRatioModalView({
    super.key,
    required this.teamMember,
    required this.members,
    required this.team,
    required this.addedMembers,
    required this.onPressedSubmit,
  });

  @override
  State<EditRatioModalView> createState() => _EditRatioModalViewState();
}

class _EditRatioModalViewState extends State<EditRatioModalView> {
  final TextEditingController ratioController = TextEditingController();
  final TextEditingController memberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<UserModel> notAddedMembers = [];
  late double remindedRatio;
  late ({int id, String name}) memberInfo;

  @override
  void dispose() {
    ratioController.dispose();
    memberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    memberInfo = widget.teamMember.userInfo;
    ratioController.text = widget.teamMember.sharePercentage.round().toString();
    memberController.text = memberInfo.name;

    final editedAddedMembers = Map<int, double>.from(widget.addedMembers)
      ..remove(memberInfo.id);

    for (final user in widget.members) {
      if (!editedAddedMembers.containsKey(user.id)) {
        notAddedMembers.add(user);
      }
    }

    final totalAssignedShares = editedAddedMembers.values.fold<double>(
      widget.teamMember.sharePercentage,
      (sum, share) => sum + share,
    );

    remindedRatio =
        (100.0 - totalAssignedShares + widget.teamMember.sharePercentage).clamp(
          0.0,
          100.0,
        );
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
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'انتخاب اعضا',
                    child: AppSelectModalView(
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
                  if ((value == null || value.isEmpty) && remindedRatio > 0) {
                    return S.current.validator_required;
                  }
                  if (remindedRatio == 0) {
                    return S.current.validator_thereIsNoRatio;
                  }
                  if ((double.tryParse(value ?? '0') ?? 0) > remindedRatio) {
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

        final ratio = TeamMemberParams(
          id: widget.teamMember.id,
          userInfo: memberInfo,
          teamInfo: (id: widget.team.id, name: widget.team.title),
          ratio: ratioController.text.parseToDoubleWithWesternDigits,
        );
        widget.onPressedSubmit(ratio);
        context.pop();
      },
    );
  }
}
