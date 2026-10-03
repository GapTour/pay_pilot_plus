import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/bank_model.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_registration_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart'
    show RegistrationStatus, SnacksFeeAssignmentStatus;
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_string_to_extension.dart';
import 'package:pay_pilot_plus/core/utils/formatters/price_input_formatter.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_list_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_pick_jalali_date.dart';
import 'package:pay_pilot_plus/core/widgets/app_select_raw_item_modal_view.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_wrap_builder.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/modals/select_settlement_status_modal_view.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/widgets/modals/select_snacks_fee_assignment_status_modal_view.dart';

class AttendGuestModalView extends StatefulWidget {
  final EventModel eventModel;
  final List<int> addedUsersID;
  final List<UserModel> users;
  final List<FundModel> funds;
  final List<BankModel> banks;
  final Function(EventRegistrationParams registrationParams) onSubmit;
  const AttendGuestModalView({
    required this.eventModel,
    required this.addedUsersID,
    required this.users,
    required this.funds,
    required this.banks,
    required this.onSubmit,
    super.key,
  });

  @override
  State<AttendGuestModalView> createState() => _AttendGuestModalViewState();
}

class _AttendGuestModalViewState extends State<AttendGuestModalView> {
  late DebounceHelper debounce;

  final grossAmountController = TextEditingController();
  final discountAmountController = TextEditingController();
  final discountRatioController = TextEditingController();
  final netAmountController = TextEditingController();
  final dateController = TextEditingController();
  final guestController = TextEditingController();
  final settlementController = TextEditingController();
  final settlementDetailsController = TextEditingController();
  final snacksFeeAssignmentController = TextEditingController();
  final snacksFeeAssignmentDetailsController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegistrationStatus registrationStatus = .confirmed;
  SettlementStatus settlementStatus = .bankDeposit;
  SnacksFeeAssignmentStatus? snacksAssignmentStatus;
  late DateTime registeredAt;
  bool isAddingDiscountAmount = false;
  bool isAddingDiscountRatio = false;
  bool isAddingNetAmount = false;
  bool isFree = false;
  ({int id, String name})? bankInfo;
  ({int id, String name})? assignmentInfo;
  ({int id, String name})? snacksFeeAssignmentInfo;
  final addedUsers = <({int id, String name})>[];
  final notAttendedUsers = <({int id, String name})>[];

  void _calculateAmountDetails() {
    final grossAmount = grossAmountController.text.trim().parseStringToBigInt;
    final discountAmount = discountAmountController.text
        .trim()
        .parseStringToBigInt;
    final discountRatio = discountRatioController.text
        .trim()
        .parseStringToDouble;
    final netAmount = netAmountController.text.trim().parseStringToBigInt;

    if (isAddingDiscountAmount) {
      final calDiscountRatio = ((discountAmount / grossAmount) * 100)
          .ceilToDouble();
      discountRatioController.text = calDiscountRatio.toStringAsFixed(0);

      final calNetAmount = grossAmount - discountAmount;
      netAmountController.text = calNetAmount.addSeparator();

      return;
    }

    if (isAddingDiscountRatio) {
      final calDiscountAmount = (grossAmount.toInt() * (discountRatio / 100))
          .ceil();
      discountAmountController.text = BigInt.from(calDiscountAmount)
          .addSeparator();

      final calNetAmount = grossAmount - BigInt.from(calDiscountAmount);
      netAmountController.text = calNetAmount.addSeparator();

      return;
    }

    if (isAddingNetAmount) {
      if (netAmount > grossAmount) {
        discountAmountController.text = '0';
        discountRatioController.text = '0';
        grossAmountController.text = netAmount.addSeparator();

        return;
      }
      final calDiscountAmount = grossAmount - netAmount;
      discountAmountController.text = calDiscountAmount.addSeparator();

      final calDiscountRatio = ((calDiscountAmount / grossAmount) * 100)
          .ceilToDouble();
      discountRatioController.text = calDiscountRatio.toString();

      return;
    }
  }

  @override
  void initState() {
    super.initState();

    debounce = DebounceHelper();
    settlementController.text = settlementStatus.title;

    final addedUserIds = widget.addedUsersID.toSet();

    for (final user in widget.users) {
      if (user.role.isGuest && !addedUserIds.contains(user.id)) {
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
    settlementController.dispose();
    settlementDetailsController.dispose();
    snacksFeeAssignmentController.dispose();
    snacksFeeAssignmentDetailsController.dispose();
    descriptionController.dispose();
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
                hint: 'انتخاب مهمانان این رویداد',
                readOnly: true,
                controller: guestController,
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'انتخاب مهمانان',
                    child: AppSelectRawItemModalView(
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
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
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
                        .parseStringToStringWithWesternDigits;

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
                        debounce.call(() {
                          _calculateAmountDetails();

                          final westernizedValue = value
                              .replaceAll('-', '')
                              .trim()
                              .parseStringToStringWithWesternDigits;

                          isFree =
                              westernizedValue == '100' ||
                              westernizedValue == '100.0';
                          if (isFree) {
                            bankInfo = null;
                            assignmentInfo = null;
                            registrationStatus = .confirmed;
                            snacksAssignmentStatus = .assignmentToStaff;
                            snacksFeeAssignmentController.text =
                                SnacksFeeAssignmentStatus
                                    .assignmentToStaff
                                    .title;
                          }
                          if (!isFree) {
                            snacksFeeAssignmentInfo = null;
                            snacksAssignmentStatus = null;
                            snacksFeeAssignmentController.clear();
                          }
                          setState(() {});
                        });
                      },
                      onTap: (focusNode) {
                        isAddingDiscountAmount = false;
                        isAddingDiscountRatio = true;
                        isAddingNetAmount = false;
                      },
                      validator: (value) {
                        if (value.parseStringToDouble > 100) {
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
                        debounce.call(() {
                          _calculateAmountDetails();

                          final westernizedValue = value
                              .replaceAll('-', '')
                              .trim()
                              .parseStringToStringWithWesternDigits;

                          isFree =
                              westernizedValue ==
                              grossAmountController
                                  .text
                                  .parseStringToStringWithWesternDigits;
                          if (isFree) {
                            bankInfo = null;
                            assignmentInfo = null;
                            registrationStatus = .confirmed;
                            snacksAssignmentStatus = .assignmentToStaff;
                            snacksFeeAssignmentController.text =
                                SnacksFeeAssignmentStatus
                                    .assignmentToStaff
                                    .title;
                          }
                          if (!isFree) {
                            snacksFeeAssignmentInfo = null;
                            snacksAssignmentStatus = null;
                            snacksFeeAssignmentController.clear();
                          }
                          setState(() {});
                        });
                      },
                      onTap: (focusNode) {
                        isAddingDiscountAmount = true;
                        isAddingDiscountRatio = false;
                        isAddingNetAmount = false;
                      },
                      validator: (value) {
                        final grossAmount = grossAmountController.text
                            .trim()
                            .parseStringToInt;

                        if (value.parseStringToInt > grossAmount) {
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
                  debounce.call(() => _calculateAmountDetails());
                },
                onTap: (focusNode) {
                  isAddingDiscountAmount = false;
                  isAddingDiscountRatio = false;
                  isAddingNetAmount = true;
                },
                validator: (value) {
                  final grossAmount = grossAmountController.text
                      .trim()
                      .parseStringToInt;

                  if (value == null || value.isEmpty) {
                    return S.current.validator_required;
                  }

                  if (value.parseStringToInt > grossAmount) {
                    return S.current.validator_ratioCanNotMoreThan(
                      grossAmount.round(),
                    );
                  }
                  return null;
                },
              ),
              if (!isFree) ...[
                Gap(20),
                AppTextField(
                  label: 'وضعیت پرداختی',
                  controller: settlementController,
                  suffixIcon: Icons.arrow_drop_down_circle_rounded,
                  readOnly: true,
                  onTap: (focusNode) {
                    context.hideKeyboard();
                    AppBottomModalSheet.minHeightWithAppBar(
                      header: 'وضعیت تسویه مهمانان',
                      child: SelectSettlementStatusModalView(
                        onSelected: (selected) {
                          settlementStatus = selected;
                          settlementController.text = selected.title;
                          registrationStatus =
                              // selected.isUnsettled
                              //     ? .pending
                              //     :
                              .confirmed;

                          bankInfo = null;
                          assignmentInfo = null;
                          settlementDetailsController.clear();

                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
                Gap(20),
                if (settlementStatus.isBankDeposit)
                  AppTextField(
                    label: 'بانک',
                    hint: 'پاسارگاد',
                    controller: settlementDetailsController,
                    suffixIcon: Icons.arrow_drop_down_circle_rounded,
                    readOnly: true,
                    onTap: (focusNode) {
                      if (!settlementStatus.isBankDeposit) return null;
                      AppBottomModalSheet.maxHeightWithAppBar(
                        header: 'انتخاب بانک',
                        child: AppSelectRawItemModalView(
                          items: widget.banks.map((e) {
                            return (id: e.id, name: e.name);
                          }).toList(),
                          onSelect: (selected) {
                            bankInfo = selected;
                            settlementDetailsController.text = selected.name;
                          },
                        ),
                      );
                    },
                    validator: (value) {
                      if (!settlementStatus.isBankDeposit) return null;
                      if (value == null || value.isEmpty) {
                        return S.current.validator_required;
                      }
                      return null;
                    },
                  ),
                if (settlementStatus.isAssignmentTo)
                  AppTextField(
                    label: 'اشخاص',
                    hint: 'زینب جدیدی',
                    controller: settlementDetailsController,
                    suffixIcon: Icons.arrow_drop_down_circle_rounded,
                    readOnly: true,
                    onTap: (focusNode) {
                      if (!settlementStatus.isAssignmentTo) return null;
                      AppBottomModalSheet.maxHeightWithAppBar(
                        header: 'انتخاب طرف حساب',
                        child: AppSelectRawItemModalView(
                          items: widget.users
                              .where((w) {
                                return w.role.isStaff || w.role.isHost;
                              })
                              .map((e) {
                                return (id: e.id, name: e.name);
                              })
                              .toList(),
                          onSelect: (selected) {
                            assignmentInfo = selected;
                            settlementDetailsController.text = selected.name;
                          },
                        ),
                      );
                    },
                    validator: (value) {
                      if (!settlementStatus.isAssignmentTo) return null;
                      if (value == null || value.isEmpty) {
                        return S.current.validator_required;
                      }
                      return null;
                    },
                  ),
              ],
              if (isFree) ...[
                Gap(20),
                AppTextField(
                  label: 'کسر هزینه پذیرایی',
                  controller: snacksFeeAssignmentController,
                  suffixIcon: Icons.arrow_drop_down_circle_rounded,
                  readOnly: true,
                  onTap: (focusNode) {
                    context.hideKeyboard();
                    AppBottomModalSheet.minHeightWithAppBar(
                      header: 'وضعیت تسویه حساب پذیرایی',
                      child: SelectSnacksFeeAssignmentStatusModalView(
                        onSelected: (selected) {
                          snacksAssignmentStatus = selected;
                          snacksFeeAssignmentController.text = selected.title;
                          snacksFeeAssignmentInfo = null;
                          snacksFeeAssignmentDetailsController.clear();
                        },
                      ),
                    );
                  },
                ),
                Gap(20),
                if (snacksAssignmentStatus?.isAssignmentToStaff == true)
                  AppTextField(
                    label: 'اشخاص',
                    hint: 'زینب جدیدی',
                    controller: snacksFeeAssignmentDetailsController,
                    suffixIcon: Icons.arrow_drop_down_circle_rounded,
                    readOnly: true,
                    onTap: (focusNode) {
                      AppBottomModalSheet.maxHeightWithAppBar(
                        header: 'انتخاب طرف حساب',
                        child: AppSelectRawItemModalView(
                          items: widget.users
                              .where((w) {
                                return w.role.isStaff || w.role.isHost;
                              })
                              .map((e) {
                                return (id: e.id, name: e.name);
                              })
                              .toList(),
                          onSelect: (selected) {
                            snacksFeeAssignmentInfo = selected;
                            snacksFeeAssignmentDetailsController.text =
                                selected.name;
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
                if (snacksAssignmentStatus?.isAssignmentToFund == true)
                  AppTextField(
                    label: 'کیف ذخیره',
                    hint: 'تبلیغات',
                    controller: snacksFeeAssignmentDetailsController,
                    suffixIcon: Icons.arrow_drop_down_circle_rounded,
                    readOnly: true,
                    onTap: (focusNode) {
                      AppBottomModalSheet.maxHeightWithAppBar(
                        header: 'انتخاب طرف حساب',
                        child: AppSelectRawItemModalView(
                          items: widget.funds.map((e) {
                            return (id: e.id, name: e.title);
                          }).toList(),
                          onSelect: (selected) {
                            snacksFeeAssignmentInfo = selected;
                            snacksFeeAssignmentDetailsController.text =
                                selected.name;
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
              ],
            ],
          ),
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
        final registration = EventRegistrationParams(
          id: null,
          eventInfo: (id: widget.eventModel.id, name: widget.eventModel.title),
          bankInfo: bankInfo,
          assignmentInfo: assignmentInfo,
          guestsInfo: addedUsers,
          status: registrationStatus,
          snacksAssignmentInfo: snacksFeeAssignmentInfo,
          snacksAssignmentStatus: snacksAssignmentStatus,
          grossAmount: grossAmountController.text.parseStringToBigInt,
          discountAmount: discountAmountController.text.parseStringToBigInt,
          netAmount: netAmountController.text.parseStringToBigInt,
          registeredAt: registeredAt,
          description: descriptionController.text.parseNullIfIsEmpty,
        );

        widget.onSubmit(registration);
        context.pop();
      },
    );
  }
}
