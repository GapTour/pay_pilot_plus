import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/params/bank_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_null_value_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class EditBankModalView extends StatefulWidget {
  final BankModel bank;
  final Function(BankParams value) onPressedSubmit;
  const EditBankModalView({
    super.key,
    required this.bank,
    required this.onPressedSubmit,
  });

  @override
  State<EditBankModalView> createState() => _EditBankModalViewState();
}

class _EditBankModalViewState extends State<EditBankModalView> {
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
  void initState() {
    super.initState();

    nameController.text = widget.bank.name;
    descriptionController.text = widget.bank.description ?? '';
    numberController.text = widget.bank.number ?? '';
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
          id: widget.bank.bankID,
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
