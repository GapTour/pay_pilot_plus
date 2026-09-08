import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/params/bank_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_null_value_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class AddBankModalView extends StatefulWidget {
  final Function(BankParams value) onPressedSubmit;
  const AddBankModalView({super.key, required this.onPressedSubmit});

  @override
  State<AddBankModalView> createState() => _AddBankModalViewState();
}

class _AddBankModalViewState extends State<AddBankModalView> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    descriptionController.dispose();
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppModalColumnViewSkin(
      children: [
        Form(
          key: formKey,
          child: AppTextField(
            label: S.current.textField_label_name,
            hint: 'پاسارگاد',
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
          label: 'شماره کارت / حساب',
          hint: '۶۰۲۱۳۳۲۵۴۲۵۸۳۶۴۸',
          controller: numberController,
          keyboardType: TextInputType.number,
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
        final bank = BankParams(
          id: null,
          name: nameController.text,
          number: numberController.text.parseNullIfIsEmpty,
          description: descriptionController.text.parseNullIfIsEmpty,
          isActive: true,
        );
        widget.onPressedSubmit(bank);
        context.pop();
      },
    );
  }
}
