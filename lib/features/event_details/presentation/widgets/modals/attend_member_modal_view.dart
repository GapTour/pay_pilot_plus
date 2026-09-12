import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_registration_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart'
    show RegistrationStatus;
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_null_value_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/persian_numbers_converter_extension.dart';
import 'package:pay_pilot_plus/core/utils/formatters/price_input_formatter.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_list_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_pick_jalali_date.dart';
import 'package:pay_pilot_plus/core/widgets/app_select_modal_view.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_wrap_builder.dart';

class AttendMemberModalView extends StatefulWidget {
  final EventModel eventModel;
  final List<int> addedUsersID;
  final List<UserModel> users;
  final Function(EventRegistrationParams registrationParams) onSubmit;
  const AttendMemberModalView({
    required this.eventModel,
    required this.addedUsersID,
    required this.users,
    required this.onSubmit,
    super.key,
  });

  @override
  State<AttendMemberModalView> createState() => _AttendMemberModalViewState();
}

class _AttendMemberModalViewState extends State<AttendMemberModalView> {
  late DebounceHelper debounce;

  final grossAmountController = TextEditingController();
  final discountAmountController = TextEditingController();
  final discountRatioController = TextEditingController();
  final netAmountController = TextEditingController();
  final dateController = TextEditingController();
  final guestController = TextEditingController();
  final desController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegistrationStatus registrationStatus = .confirmed;
  late DateTime registeredAt;
  bool isAddingDiscountAmount = false;
  bool isAddingDiscountRatio = false;
  bool isAddingNetAmount = false;
  final addedUsers = <({int id, String name})>[];
  final notAttendedUsers = <({int id, String name})>[];

  @override
  void initState() {
    super.initState();

    debounce = DebounceHelper();

    final addedUserIds = widget.addedUsersID.toSet();

    for (final user in widget.users) {
      if (user.role.isStaff && !addedUserIds.contains(user.id)) {
        notAttendedUsers.add((id: user.id, name: user.name));
      }
    }
  }

  @override
  void dispose() {
    grossAmountController.dispose();
    discountAmountController.dispose();
    discountRatioController.dispose();
    netAmountController.dispose();
    dateController.dispose();
    guestController.dispose();
    desController.dispose();

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
                hint: 'انتخاب مهمانان این رویداد',
                readOnly: true,
                controller: guestController,
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'انتخاب مهمانان',
                    child: AppSelectModalView(
                      items: notAttendedUsers,
                      onSelect: (selected) {
                        addedUsers.add(selected);
                        notAttendedUsers.removeWhere(
                          (e) => e.id == selected.id,
                        );
                        guestController.text =
                            '${addedUsers.length} مهمان انتخاب شده';
                        setState(() {});
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
              if (addedUsers.isNotEmpty) ...[
                Gap(10),
                AppWrapBuilder(
                  addedUsers.map((e) {
                    return GestureDetector(
                      onTap: () {
                        addedUsers.remove(e);
                        notAttendedUsers.add(e);
                        guestController.text =
                            '${addedUsers.length} مهمان انتخاب شده';
                        if (addedUsers.isEmpty) guestController.clear();
                        setState(() {});
                      },
                      child: Text(
                        e.name,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    );
                  }).toList(),
                ),
              ],
              Gap(20),
              AppTextField(
                label: S.current.textField_label_date,
                hint: DateTime.now().formattedToJalali_yearMonthDay,
                controller: dateController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: (focusNode) async {
                  AppPickJalaliDateModalView.pickDate(
                    header: S.current.textField_label_date,
                    initialedDate: DateTime.now(),
                    onSelectedDate: (pickedDate) {
                      registeredAt = pickedDate;
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
                label: 'مبلغ کل بدون تخفیف',
                hint: '10,000,000',
                controller: grossAmountController,
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
                        .parseToStringWithWesternDigits;

                    final isZero =
                        westernizedValue == '0' || westernizedValue == '0.0';

                    if (isZero) {
                      grossAmountController.clear();
                      discountAmountController.clear();
                      discountRatioController.clear();
                      netAmountController.clear();
                      setState(() {});
                      return;
                    }

                    netAmountController.text = value;
                    setState(() {});
                  });
                },
              ),
              Gap(20),
              Row(
                crossAxisAlignment: .end,
                mainAxisAlignment: .end,
                children: [
                  Flexible(
                    flex: 1,
                    child: AppTextField(
                      label: 'تخفیف',
                      hint: '25',
                      readOnly: grossAmountController.text.isEmpty,
                      suffixIcon: Icons.percent,
                      controller: discountRatioController,
                      keyboardType: TextInputType.number,
                      onChange: (value) {
                        if (isAddingDiscountRatio) {
                          debounce.call(() {
                            final westernizedValue = value
                                .replaceAll('-', '')
                                .trim()
                                .parseToStringWithWesternDigits;

                            final isZero =
                                westernizedValue == '0' ||
                                westernizedValue == '0.0';

                            if (isZero) {
                              discountRatioController.clear();
                              discountAmountController.clear();
                              netAmountController.clear();

                              netAmountController.text =
                                  grossAmountController.text;

                              return;
                            }

                            final disRatio =
                                double.tryParse(westernizedValue) ?? 0;
                            final grossAmount =
                                int.tryParse(
                                  grossAmountController
                                      .text
                                      .parseToStringWithWesternDigits,
                                ) ??
                                0;

                            final disAmount = (grossAmount * (disRatio / 100))
                                .ceil();
                            discountAmountController.text = disAmount
                                .addSeparator();

                            final netAmount = grossAmount - disAmount;
                            netAmountController.text = netAmount.addSeparator();
                          });
                        }
                      },
                      onTap: (focusNode) {
                        isAddingDiscountAmount = false;
                        isAddingDiscountRatio = true;
                        isAddingNetAmount = false;
                      },
                      validator: (value) {
                        if ((double.tryParse(value ?? '0') ?? 0) > 100) {
                          return S.current.validator_ratioCanNotMoreThan(
                            100.round(),
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                  Gap(8),
                  Flexible(
                    flex: 2,
                    child: AppTextField(
                      label: '',
                      hint: '250,000',
                      controller: discountAmountController,
                      readOnly: grossAmountController.text.isEmpty,
                      keyboardType: TextInputType.number,
                      inputFormatters: [PriceInputFormatter()],
                      onChange: (value) {
                        if (isAddingDiscountAmount) {
                          debounce.call(() {
                            final westernizedValue = value
                                .replaceAll('-', '')
                                .trim()
                                .parseToStringWithWesternDigits;

                            final isZero =
                                westernizedValue == '0' ||
                                westernizedValue == '0.0';

                            if (isZero) {
                              discountRatioController.clear();
                              discountAmountController.clear();
                              netAmountController.clear();

                              netAmountController.text =
                                  grossAmountController.text;

                              return;
                            }

                            final disAmount =
                                int.tryParse(westernizedValue) ?? 0;
                            final grossAmount =
                                int.tryParse(
                                  grossAmountController
                                      .text
                                      .parseToStringWithWesternDigits,
                                ) ??
                                0;

                            final disRatio = ((disAmount / grossAmount) * 100)
                                .ceilToDouble();
                            discountRatioController.text = disRatio
                                .toStringAsFixed(0);

                            final netAmount = grossAmount - disAmount;
                            netAmountController.text = netAmount.addSeparator();
                          });
                        }
                      },
                      onTap: (focusNode) {
                        isAddingDiscountAmount = true;
                        isAddingDiscountRatio = false;
                        isAddingNetAmount = false;
                      },
                      validator: (value) {
                        final grossAmount =
                            int.tryParse(
                              grossAmountController
                                  .text
                                  .parseToStringWithWesternDigits,
                            ) ??
                            0;

                        if ((double.tryParse(value ?? '0') ?? 0) >
                            grossAmount) {
                          return S.current.validator_ratioCanNotMoreThan(
                            grossAmount.round(),
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Gap(20),
              AppTextField(
                label: 'مبلغ نهایی',
                hint: '10,000,000',
                controller: netAmountController,
                readOnly: grossAmountController.text.isEmpty,
                keyboardType: TextInputType.number,
                inputFormatters: [PriceInputFormatter()],
                onChange: (value) {
                  if (isAddingNetAmount) {
                    debounce.call(() {
                      final westernizedValue = value
                          .replaceAll('-', '')
                          .trim()
                          .parseToStringWithWesternDigits;

                      final isZero =
                          westernizedValue == '0' || westernizedValue == '0.0';

                      if (isZero) {
                        discountRatioController.text = '100';
                        discountAmountController.text =
                            grossAmountController.text;
                        netAmountController.clear();

                        return;
                      }

                      final netAmount = int.tryParse(westernizedValue) ?? 0;
                      final grossAmount =
                          int.tryParse(
                            grossAmountController
                                .text
                                .parseToStringWithWesternDigits,
                          ) ??
                          0;

                      if (netAmount > grossAmount) return;

                      final disAmount = grossAmount - netAmount;
                      discountAmountController.text = disAmount.addSeparator();

                      final disRatio = ((disAmount / grossAmount) * 100)
                          .ceilToDouble();
                      discountRatioController.text = disRatio.toStringAsFixed(
                        0,
                      );
                    });
                  }
                },
                onTap: (focusNode) {
                  isAddingDiscountAmount = false;
                  isAddingDiscountRatio = false;
                  isAddingNetAmount = true;
                },
                validator: (value) {
                  final grossAmount =
                      int.tryParse(
                        grossAmountController
                            .text
                            .parseToStringWithWesternDigits,
                      ) ??
                      0;

                  if (value == null || value.isEmpty) {
                    return S.current.validator_required;
                  }

                  if ((int.tryParse(value.parseToStringWithWesternDigits) ??
                          0) >
                      grossAmount) {
                    return S.current.validator_ratioCanNotMoreThan(
                      grossAmount.round(),
                    );
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        Gap(20),
        AppTextField(
          label:
              '${S.current.textField_label_description} ${S.current.textField_label_optional}',
          controller: desController,
          minLines: 3,
          maxLines: 4,
        ),
      ],
      onSubmit: () {
        if (!formKey.currentState!.validate()) return;
        final registration = EventRegistrationParams(
          id: null,
          eventInfo: (id: widget.eventModel.id, name: widget.eventModel.title),
          bankInfo: null,
          usersInfo: addedUsers,
          status: registrationStatus,
          grossAmount:
              grossAmountController.text.parseToBigIntWithWesternDigits,
          discountAmount:
              discountAmountController.text.parseToBigIntWithWesternDigits,
          netAmount: netAmountController.text.parseToBigIntWithWesternDigits,
          registeredAt: registeredAt,
          description: desController.text.parseNullIfIsEmpty,
        );

        widget.onSubmit(registration);
        context.pop();
      },
    );
  }
}
