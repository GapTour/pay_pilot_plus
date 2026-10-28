import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/params/fund_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_string_to_extension.dart';
import 'package:pay_pilot_plus/core/utils/formatters/price_input_formatter.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class EditFundModalView extends StatefulWidget {
  final FundModel fund;
  final Function(FundParams fund) onPressedSubmit;
  const EditFundModalView({
    super.key,
    required this.fund,
    required this.onPressedSubmit,
  });

  @override
  State<EditFundModalView> createState() => _EditFundModalViewState();
}

class _EditFundModalViewState extends State<EditFundModalView> {
  late DebounceHelper debounce;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController openingAmountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int fundID;

  @override
  void dispose() {
    titleController.dispose();
    openingAmountController.dispose();
    debounce.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    debounce = DebounceHelper();

    fundID = widget.fund.id;
    titleController.text = widget.fund.title;
    openingAmountController.text = widget.fund.openingBalance.addSeparator();
  }

  @override
  Widget build(BuildContext context) {
    return AppModalColumnViewSkin(
      children: [
        Form(
          key: formKey,
          child: AppTextField(
            label: S.current.textField_label_fundWalletName,
            hint: S.current.textField_hint_advertising,
            autoFocus: true,
            controller: titleController,
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
      ],
      onSubmit: () {
        if (!formKey.currentState!.validate()) return;
        final fund = FundParams(
          id: fundID,
          title: titleController.text,
          openingBalance:
              openingAmountController.text.parseStringToNullableBigInt,
          isActive: true,
        );
        widget.onPressedSubmit(fund);
        context.pop();
      },
    );
  }
}
