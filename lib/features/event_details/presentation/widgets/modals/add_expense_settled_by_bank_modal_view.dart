import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_expense_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart'
    show SubsidiaryAccountType;
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_string_to_extension.dart';
import 'package:pay_pilot_plus/core/utils/formatters/price_input_formatter.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_list_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_pick_jalali_date.dart';
import 'package:pay_pilot_plus/core/widgets/app_select_raw_item_modal_view.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class AddExpenseSettledByBankModalView extends StatefulWidget {
  final EventModel eventModel;
  final List<BankModel> banks;
  final List<FundModel> funds;
  final Function(EventExpenseParams params) onSubmit;
  const AddExpenseSettledByBankModalView({
    required this.eventModel,
    required this.banks,
    required this.funds,
    required this.onSubmit,
    super.key,
  });

  @override
  State<AddExpenseSettledByBankModalView> createState() =>
      _AddExpenseSettledByBankModalViewState();
}

class _AddExpenseSettledByBankModalViewState
    extends State<AddExpenseSettledByBankModalView> {
  late DebounceHelper debounce;

  final expenseTitleController = TextEditingController();
  final expenseAmountController = TextEditingController();
  final transferFeeController = TextEditingController();
  final dateController = TextEditingController();
  final bankController = TextEditingController();
  final fundController = TextEditingController();
  final noticeMemoController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late DateTime paidAt;
  ({int id, String name})? bankInfo;
  ({int id, String name})? fundInfo;
  SubsidiaryAccountType? selectedType;

  final subsidiaryAccounts = <SubsidiaryAccountType>[
    .adsExpenses,
    .feeExpenses,
    .otherExpenses,
  ];

  @override
  void initState() {
    super.initState();

    debounce = DebounceHelper();

    paidAt = widget.eventModel.date;
    dateController.text = paidAt.formattedToJalali_yearMonthDayWeekDay;
  }

  @override
  void dispose() {
    expenseTitleController.dispose();
    expenseAmountController.dispose();
    transferFeeController.dispose();
    dateController.dispose();
    bankController.dispose();
    fundController.dispose();
    noticeMemoController.dispose();
    debounce.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppModalListViewSkin(
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              AppTextField(
                label: S.current.expense_categoryLabel,
                hint: S.current.dropDownButton_hint_selectOption,
                readOnly: true,
                controller: expenseTitleController,
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: S.current.modalBottom_title_selectExpenseCategory,
                    child: AppSelectRawItemModalView(
                      items: subsidiaryAccounts.map((e) {
                        return (
                          id: subsidiaryAccounts.indexOf(e),
                          name: e.title,
                        );
                      }).toList(),
                      onSelect: (selected) {
                        selectedType = subsidiaryAccounts[selected.id];
                        expenseTitleController.text = selectedType!.title;
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
                label: S.current.textField_label_paymentDate,
                hint: DateTime.now().formattedToJalali_yearMonthDay,
                controller: dateController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: (focusNode) async {
                  AppPickJalaliDateModalView.pickDate(
                    header: S.current.textField_label_date,
                    initialedDate: DateTime.now(),
                    onSelectedDate: (pickedDate) {
                      paidAt = pickedDate;
                      dateController.text =
                          pickedDate.formattedToJalali_yearMonthDay;
                    },
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
                label: S.current.textField_label_amount,
                hint: '10,000,000',
                controller: expenseAmountController,
                keyboardType: TextInputType.number,
                inputFormatters: [PriceInputFormatter()],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.validator_required;
                  }
                  return null;
                },

                onChange: (value) {
                  debounce.call(() {
                    final westernizedValue = value
                        .replaceAll('-', '')
                        .trim()
                        .parseStringToStringWithWesternDigits;

                    final isZero =
                        westernizedValue == '0' || westernizedValue == '0.0';

                    if (isZero) expenseAmountController.clear();
                  });
                },
              ),
              Gap(20),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: AppTextField(
                      label: S.current.bank_label,
                      hint: S.current.textField_hint_bankName,
                      controller: bankController,
                      suffixIcon: Icons.arrow_drop_down_circle_rounded,
                      readOnly: true,
                      onTap: (focusNode) {
                        AppBottomModalSheet.maxHeightWithAppBar(
                          header: S.current.modalBottom_title_selectBank,
                          child: AppSelectRawItemModalView(
                            items: widget.banks.map((e) {
                              return (id: e.id, name: e.name);
                            }).toList(),
                            onSelect: (selected) {
                              bankInfo = selected;
                              bankController.text = selected.name;
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
                  ),
                  Gap(8),
                  Flexible(
                    child: AppTextField(
                      label: S.current.textField_label_transferFee,
                      hint: '1,200',
                      controller: transferFeeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [PriceInputFormatter()],
                      onChange: (value) {
                        debounce.call(() {
                          final westernizedValue = value
                              .replaceAll('-', '')
                              .trim()
                              .parseStringToStringWithWesternDigits;

                          final isZero =
                              westernizedValue == '0' ||
                              westernizedValue == '0.0';

                          if (isZero) transferFeeController.clear();
                        });
                      },
                    ),
                  ),
                ],
              ),
              Gap(20),
              AppTextField(
                label:
                    '${S.current.textField_label_journalDescription} ${S.current.textField_label_optional}',
                controller: noticeMemoController,
                minLines: 3,
                maxLines: 4,
              ),
              // Gap(20),
              // AppTextField(
              //   label: 'کسر از صندوق',
              //   hint: 'تبلیغات',
              //   controller: fundController,
              //   suffixIcon: Icons.arrow_drop_down_circle_rounded,
              //   readOnly: true,
              //   onTap: (focusNode) {
              //     AppBottomModalSheet.maxHeightWithAppBar(
              //       header: 'انتخاب صندوق',
              //       child: AppSelectRawItemModalView(
              //         items: widget.funds.map((e) {
              //           return (id: e.id, name: e.title);
              //         }).toList(),
              //         onSelect: (selected) {
              //           fundInfo = selected;
              //           fundController.text = selected.name;
              //         },
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ],
      onSubmit: () {
        if (!formKey.currentState!.validate()) return;
        final params = EventExpenseParams(
          subsidiaryAccountType: selectedType!,
          eventInfo: (id: widget.eventModel.id, name: widget.eventModel.title),
          bankInfo: bankInfo!,
          fundInfo: fundInfo,
          staffInfo: null,
          amount: expenseAmountController.text.parseStringToBigInt,
          transferFee: transferFeeController.text.parseStringToNullableBigInt,
          paidAt: paidAt,
          noticeMemo: noticeMemoController.text.parseNullIfIsEmpty,
        );

        widget.onSubmit(params);
        context.pop();
      },
    );
  }
}
