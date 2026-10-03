import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/params/bank_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_string_to_extension.dart';
import 'package:pay_pilot_plus/core/utils/formatters/price_input_formatter.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
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
  late DebounceHelper debounce;

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController openingAmountController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    descriptionController.dispose();
    nameController.dispose();
    numberController.dispose();
    openingAmountController.dispose();
    debounce.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    debounce = DebounceHelper();

    nameController.text = widget.bank.name;
    descriptionController.text = widget.bank.description ?? '';
    numberController.text = widget.bank.number ?? '';
    openingAmountController.text = widget.bank.openingBalance.addSeparator();
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
          label: 'موجودی اولیه',
          hint: '10,000,000',
          controller: openingAmountController,
          keyboardType: TextInputType.number,
          inputFormatters: [PriceInputFormatter()],
          onChange: (value) {
            debounce.call(() {
              final westernizedValue = value
                  .replaceAll('-', '')
                  .trim()
                  .parseStringToStringWithWesternDigits;

              final isZero =
                  westernizedValue == '0' || westernizedValue == '0.0';

              if (isZero) {
                openingAmountController.clear();
              }
            });
          },
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
          id: widget.bank.id,
          name: nameController.text,
          number: numberController.text.parseNullIfIsEmpty,
          description: descriptionController.text.parseNullIfIsEmpty,
          openingBalance:
              openingAmountController.text.parseStringToNullableBigInt,
          noticeMemo: null,
          isActive: true,
        );
        widget.onPressedSubmit(bank);
        context.pop();
      },
    );
  }
}
