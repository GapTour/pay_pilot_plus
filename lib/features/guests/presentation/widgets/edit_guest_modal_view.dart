import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/user_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_null_value_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_list_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_pick_jalali_date.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class EditGuestModalView extends StatefulWidget {
  final UserModel guest;
  final Function(UserParams guest) onPressedSubmit;
  const EditGuestModalView({
    super.key,
    required this.guest,
    required this.onPressedSubmit,
  });

  @override
  State<EditGuestModalView> createState() => _EditGuestModalViewState();
}

class _EditGuestModalViewState extends State<EditGuestModalView> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController telegramController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController joinAtDateController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int guestID;
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

    guestID = widget.guest.userID;
    nameController.text = widget.guest.name;
    descriptionController.text = widget.guest.description ?? '';
    // selectedJainAtDate = widget.guest.joinAt;
    phoneController.text = widget.guest.phoneNumber ?? '';
    instagramController.text = widget.guest.instagramID ?? '';
    telegramController.text = widget.guest.telegramID ?? '';
    // if (selectedJainAtDate != null) {
    //   joinAtDateController.text =
    //       selectedJainAtDate!.formattedToJalali_yearMonth;
    // }
    selectedBirthdayDate = widget.guest.birthday;
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
        //             pickedDate.formattedToJalali_yearMonth;
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
        final guest = UserParams(
          id: guestID,
          name: nameController.text,
          birthday: selectedBirthdayDate,
          isActive: true,
          profileImage: null,
          instagramID: instagramController.text.parseNullIfIsEmpty,
          phone: phoneController.text.parseNullIfIsEmpty,
          telegramID: telegramController.text.parseNullIfIsEmpty,
          role: .guest,
          description: descriptionController.text.parseNullIfIsEmpty,
        );
        widget.onPressedSubmit(guest);
        context.pop();
      },
    );
  }
}
