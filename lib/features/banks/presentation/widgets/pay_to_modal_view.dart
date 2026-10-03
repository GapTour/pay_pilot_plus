import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/bank_balance_params.dart';
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

class PayToModalView extends StatefulWidget {
  final BankModel bankDetails;
  final List<UserModel> users;
  final List<FundModel> funds;
  final List<EventModel> events;
  final Function(BankBalanceParams bankBalanceParams) onSubmit;
  const new({
    required this.bankDetails,
    required this.users,
    required this.funds,
    required this.events,
    required this.onSubmit,
    super.key,
  });

  @override
  State<PayToModalView> createState() => _PayToModalViewState();
}

class _PayToModalViewState extends State<PayToModalView> {
  late DebounceHelper debounce;
  final formKey = GlobalKey<FormState>();
  final eventController = TextEditingController();
  final fundController = TextEditingController();
  final userController = TextEditingController();
  final amountController = TextEditingController();
  final transferFeeController = TextEditingController();
  final paidDateController = TextEditingController();
  final noticeMemoController = TextEditingController();

  ({int id, String name})? userInfo;
  ({int id, String name})? fundInfo;
  ({int id, String name})? eventInfo;
  late DateTime paidAt;

  @override
  void initState() {
    super.initState();

    debounce = DebounceHelper();
  }

  @override
  void dispose() {
    debounce.dispose();
    eventController.dispose();
    fundController.dispose();
    userController.dispose();
    amountController.dispose();
    transferFeeController.dispose();
    paidDateController.dispose();
    noticeMemoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppModalListViewSkin(
      onSubmit: () {
        if (!formKey.currentState!.validate()) return;
        final params = BankBalanceParams(
          bankInfo: (id: widget.bankDetails.id, name: widget.bankDetails.name),
          eventInfo: eventInfo,
          fundInfo: fundInfo,
          userInfo: userInfo!,
          amount: amountController.text.parseStringToBigInt,
          transferFee: transferFeeController.text.parseStringToBigInt,
          paidAt: paidAt,
          noticeMemo: noticeMemoController.text.parseNullIfIsEmpty,
        );
        widget.onSubmit(params);
        context.pop();
      },
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              AppTextField(
                label: 'پرداخت به',
                hint: 'مهدیار ارباب زی',
                readOnly: true,
                controller: userController,
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'انتخاب طرف حساب',
                    child: AppSelectRawItemModalView(
                      items: widget.users
                          .where((w) => w.role.isStaff || w.role.isHost)
                          .map((e) => (id: e.id, name: e.name))
                          .toList(),
                      onSelect: (selected) {
                        userInfo = selected;
                        userController.text = selected.name;
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
                label: 'مربوط به رویداد (اختیاری)',
                hint: 'فیلم Cast Away',
                readOnly: true,
                controller: eventController,
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'انتخاب رویداد',
                    child: AppSelectRawItemModalView(
                      items: widget.events
                          .map((e) => (id: e.id, name: e.title))
                          .toList(),
                      onSelect: (selected) {
                        eventInfo = selected;
                        eventController.text = selected.name;
                      },
                    ),
                  );
                },
              ),
              Gap(20),
              AppTextField(
                label: 'پرداخت از ذخیره (اختیاری)',
                hint: 'تبلیغات',
                readOnly: true,
                controller: fundController,
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'انتخاب طرف حساب',
                    child: AppSelectRawItemModalView(
                      items: widget.funds
                          .map((e) => (id: e.id, name: e.title))
                          .toList(),
                      onSelect: (selected) {
                        fundInfo = selected;
                        fundController.text = selected.name;
                      },
                    ),
                  );
                },
              ),
              Gap(20),
              AppTextField(
                label: S.current.textField_label_date,
                hint: DateTime.now().formattedToJalali_yearMonthDay,
                controller: paidDateController,
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: (focusNode) async {
                  AppPickJalaliDateModalView.pickDate(
                    header: S.current.textField_label_date,
                    initialedDate: DateTime.now(),
                    onSelectedDate: (pickedDate) {
                      paidAt = pickedDate;
                      paidDateController.text =
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
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: AppTextField(
                      label: 'مبلغ',
                      hint: '1,200,000',
                      controller: amountController,
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

                          if (isZero) amountController.clear();
                        });
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
                      label: 'کارمزد انتقال',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.current.validator_required;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Gap(20),
              AppTextField(
                label: 'توضیحات سند ${S.current.textField_label_optional}',
                controller: noticeMemoController,
                minLines: 3,
                maxLines: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
