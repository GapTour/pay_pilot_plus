import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_member_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_partner_share_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/persian_numbers_converter_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_select_modal_view.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class EditSharePartnerModalView extends StatefulWidget {
  final TeamMemberModel sharePartnerInfo;
  final List<TeamMemberModel> ratios;
  final List<UserModel> users;
  final EventModel eventDetails;
  final Function(EventPartnerShareParams newRatio) onSubmit;
  const EditSharePartnerModalView({
    super.key,
    required this.sharePartnerInfo,
    required this.ratios,
    required this.users,
    required this.eventDetails,
    required this.onSubmit,
  });

  @override
  State<EditSharePartnerModalView> createState() =>
      _EditSharePartnerModalViewState();
}

class _EditSharePartnerModalViewState extends State<EditSharePartnerModalView> {
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

    memberInfo = widget.sharePartnerInfo.userInfo;
    ratioController.text = widget.sharePartnerInfo.sharePercentage
        .round()
        .toString();
    memberController.text = memberInfo.name;

    remindedRatio =
        widget.ratios.fold<double>(
          100.0,
          (sum, ratio) => sum - ratio.sharePercentage,
        ) +
        widget.sharePartnerInfo.sharePercentage;

    final addedUserIds = widget.ratios
        .map((e) => e.userInfo.id)
        .where((id) => id != memberInfo.id)
        .toSet();

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

        final ratio = EventPartnerShareParams(
          id: widget.sharePartnerInfo.id,
          eventInfo: (
            id: widget.eventDetails.id,
            name: widget.eventDetails.title,
          ),
          usersInfo: [
            (
              id: memberInfo.id,
              name: memberInfo.name,
              ratio: ratioController.text.parseToDoubleWithWesternDigits,
            ),
          ],
        );
        widget.onSubmit(ratio);
        context.pop();
      },
    );
  }
}
