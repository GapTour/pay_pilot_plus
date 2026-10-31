import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/params/bank_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_string_to_extension.dart';
import 'package:pay_pilot_plus/core/utils/formatters/price_input_formatter.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class AddBankModalView extends StatefulWidget {
  final Function(BankParams value) onPressedSubmit;
  const AddBankModalView({super.key, required this.onPressedSubmit});

  @override
  State<AddBankModalView> createState() => _AddBankModalViewState();
}

class _AddBankModalViewState extends State<AddBankModalView> {
  late DebounceHelper debounce;

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController openingAmountController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    debounce = DebounceHelper();
  }

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
  Widget build(BuildContext context) {
    return AppModalColumnViewSkin(
      children: [
        Form(
          key: formKey,
          child: AppTextField(
            label: S.current.textField_label_name,
            hint: S.current.textField_hint_bankName,
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
          label: S.current.textField_label_openingBalance,
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
          label: S.current.textField_label_cardOrAccountNumber,
          hint: S.current.textField_hint_cardNumber,
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
          openingBalance:
              openingAmountController.text.parseStringToNullableBigInt,
          isActive: true,
          noticeMemo: null,
        );
        widget.onPressedSubmit(bank);
        context.pop();
      },
    );
  }
}
