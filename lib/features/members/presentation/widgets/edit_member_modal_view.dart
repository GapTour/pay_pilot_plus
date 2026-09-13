import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_string_to_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_list_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_pick_jalali_date.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class EditMemberModalView extends StatefulWidget {
  final UserModel member;
  final Function(UserParams member) onPressedSubmit;
  const EditMemberModalView({
    super.key,
    required this.member,
    required this.onPressedSubmit,
  });

  @override
  State<EditMemberModalView> createState() => _EditMemberModalViewState();
}

class _EditMemberModalViewState extends State<EditMemberModalView> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController telegramController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController joinAtDateController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int memberID;
  late DateTime? selectedJainAtDate;
  late DateTime? selectedBirthdayDate;

  @override
  void dispose() {
    descriptionController.dispose();
    nameController.dispose();
    joinAtDateController.dispose();
    birthdayController.dispose();
    phoneController.dispose();
    telegramController.dispose();
    instagramController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    memberID = widget.member.id;
    nameController.text = widget.member.name;
    descriptionController.text = widget.member.description ?? '';
    // selectedJainAtDate = widget.member.joinAt;
    phoneController.text = widget.member.phoneNumber ?? '';
    instagramController.text = widget.member.instagramID ?? '';
    telegramController.text = widget.member.telegramID ?? '';
    // if (selectedJainAtDate != null) {
    //   joinAtDateController.text =
    //       selectedJainAtDate!.formattedToJalali_yearMonth;
    // }
    selectedBirthdayDate = widget.member.birthday;
    if (selectedBirthdayDate != null) {
      birthdayController.text =
          selectedBirthdayDate!.formattedToJalali_yearMonthDay;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppModalListViewSkin(
      children: [
        Form(
          key: formKey,
          child: AppTextField(
            label: S.current.textField_label_name,
            hint: S.current.textField_hint_mahdiyar,
            autoFocus: true,
            controller: nameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.current.validator_required;
              }
              return null;
            },
          ),
        ),
        Gap(20),
        AppTextField(
          label: S.current.textField_label_phone,
          hint: '09391543702',
          controller: phoneController,
          keyboardType: TextInputType.phone,
        ),
        Gap(20),
        AppTextField(
          label: S.current.textField_label_telegramId,
          hint: '@mahdiyarz',
          controller: telegramController,
          keyboardType: TextInputType.emailAddress,
        ),
        Gap(20),
        AppTextField(
          label: S.current.textField_label_instagramId,
          hint: '@mahdiyarz',
          controller: instagramController,
          keyboardType: TextInputType.emailAddress,
        ),
        // AppTextField(
        //   label: S.current.textField_label_joinAt,
        //   hint: DateTime.now().formattedToJalali_yearMonth,
        //   controller: joinAtDateController,
        //   keyboardType: TextInputType.datetime,
        //   readOnly: true,
        //   onTap: (focusNode) async {
        //     AppPickJalaliDateModalView.pickDate(
        //       header: S.current.textField_label_joinAt,
        //       initialedDate: DateTime.now(),
        //       onSelectedDate: (pickedDate) {
        //         selectedJainAtDate = pickedDate;
        //         joinAtDateController.text =
        //             pickedDate.formattedToJalali_yearMonthDay;
        //       },
        //     );
        //   },
        // ),
        Gap(20),
        AppTextField(
          label: S.current.textField_label_birthday,
          hint: DateTime.now().formattedToJalali_yearMonthDay,
          controller: birthdayController,
          keyboardType: TextInputType.datetime,
          readOnly: true,
          onTap: (focusNode) async {
            AppPickJalaliDateModalView.pickDate(
              header: S.current.textField_label_birthday,
              initialedDate: DateTime.now(),
              onSelectedDate: (pickedDate) {
                selectedBirthdayDate = pickedDate;
                birthdayController.text =
                    pickedDate.formattedToJalali_yearMonthDay;
              },
            );
          },
        ),
        Gap(20),
        AppTextField(
          label:
              '${S.current.textField_label_description} ${S.current.textField_label_optional}',
          controller: descriptionController,
          minLines: 3,
          maxLines: 4,
        ),
      ],
      onSubmit: () {
        if (!formKey.currentState!.validate()) return;
        final member = UserParams(
          id: memberID,
          name: nameController.text,
          birthday: selectedBirthdayDate,
          isActive: true,
          profileImage: null,
          instagramID: instagramController.text.parseNullIfIsEmpty,
          phone: phoneController.text.parseNullIfIsEmpty,
          telegramID: telegramController.text.parseNullIfIsEmpty,
          role: .staff,
          description: descriptionController.text.parseNullIfIsEmpty,
        );
        widget.onPressedSubmit(member);
        context.pop();
      },
    );
  }
}
