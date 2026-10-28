import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
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

class AddExpenseSettledByStaffModalView extends StatefulWidget {
  final EventModel eventModel;
  final List<UserModel> users;
  final Function(EventExpenseParams params) onSubmit;
  const AddExpenseSettledByStaffModalView({
    required this.eventModel,
    required this.users,
    required this.onSubmit,
    super.key,
  });

  @override
  State<AddExpenseSettledByStaffModalView> createState() =>
      _AddExpenseSettledByStaffModalViewState();
}

class _AddExpenseSettledByStaffModalViewState
    extends State<AddExpenseSettledByStaffModalView> {
  late DebounceHelper debounce;

  final expenseTitleController = TextEditingController();
  final expenseAmountController = TextEditingController();
  final dateController = TextEditingController();
  final staffController = TextEditingController();
  final noticeMemoController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late DateTime paidAt;
  ({int id, String name})? staffInfo;
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
    dateController.dispose();
    staffController.dispose();
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
                          name: e.localizedTitle,
                        );
                      }).toList(),
                      onSelect: (selected) {
                        selectedType = subsidiaryAccounts[selected.id];
                        expenseTitleController.text =
                            selectedType!.localizedTitle;
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
              AppTextField(
                label: S.current.expense_payer,
                hint: S.current.textField_hint_zeinabJadidi,
                controller: staffController,
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                readOnly: true,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: S.current.modalBottom_title_selectPerson,
                    child: AppSelectRawItemModalView(
                      items: widget.users
                          .where((w) {
                            return w.role.isStaff;
                          })
                          .map((e) {
                            return (id: e.id, name: e.name);
                          })
                          .toList(),
                      onSelect: (selected) {
                        staffInfo = selected;
                        staffController.text = selected.name;
                      },
                    ),
                  );
                },
              ),
              Gap(20),
              AppTextField(
                label:
                    '${S.current.textField_label_journalDescription} ${S.current.textField_label_optional}',
                controller: noticeMemoController,
                minLines: 3,
                maxLines: 4,
              ),
            ],
          ),
        ),
      ],
      onSubmit: () {
        if (!formKey.currentState!.validate()) return;
        final params = EventExpenseParams(
          subsidiaryAccountType: selectedType!,
          eventInfo: (id: widget.eventModel.id, name: widget.eventModel.title),
          bankInfo: null,
          fundInfo: null,
          staffInfo: staffInfo,
          amount: expenseAmountController.text.parseStringToBigInt,
          transferFee: null,
          paidAt: paidAt,
          noticeMemo: noticeMemoController.text.parseNullIfIsEmpty,
        );

        widget.onSubmit(params);
        context.pop();
      },
    );
  }
}
