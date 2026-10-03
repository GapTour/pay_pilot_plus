import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/params/close_event_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_string_to_extension.dart';
import 'package:pay_pilot_plus/core/utils/formatters/price_input_formatter.dart';
import 'package:pay_pilot_plus/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_list_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_select_raw_item_modal_view.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';
import 'package:pay_pilot_plus/core/widgets/app_wrap_builder.dart';
import 'package:pay_pilot_plus/features/events/presentation/blocs/close_event_bloc/event_modification_bloc.dart';
import 'package:pay_pilot_plus/locator.dart';

class CloseEventModalView extends StatefulWidget {
  final EventModel eventModel;
  final Function(EventModel closedEvent) onSubmit;
  const new({required this.eventModel, required this.onSubmit, super.key});

  @override
  State<CloseEventModalView> createState() => _CloseEventModalViewState();
}

class _CloseEventModalViewState extends State<CloseEventModalView> {
  late DebounceHelper debounce;

  final hostController = TextEditingController();
  final entranceFeeController = TextEditingController();
  final snacksFeeController = TextEditingController();
  final totalSnacksFeeController = TextEditingController();
  final totalGuestsController = TextEditingController();
  final totalExpenseController = TextEditingController();
  final membersController = TextEditingController();
  final dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final addedStaffs = <({int id, String name})>[];
  final notAttendedStaffs = <({int id, String name})>[];

  void _calculateTotalExpenses() {
    final entranceFee = entranceFeeController.text
        .replaceAll('-', '')
        .trim()
        .parseStringToBigInt;
    final snacksFee = snacksFeeController.text
        .replaceAll('-', '')
        .trim()
        .parseStringToBigInt;
    final totalGuests = BigInt.from(
      totalGuestsController.text.parseStringToInt,
    );
    final totalMembers = BigInt.from(addedStaffs.length);

    final totalSnacksFee = (totalGuests + totalMembers) * snacksFee;
    final totalExpenses = totalSnacksFee + entranceFee;

    if (totalExpenses == BigInt.zero) totalExpenseController.clear();

    totalSnacksFeeController.text = totalSnacksFee.addSeparator();
    totalExpenseController.text = totalExpenses.addSeparator();
  }

  @override
  void initState() {
    super.initState();

    debounce = DebounceHelper();

    hostController.text = widget.eventModel.hostInfo.name;
    dateController.text =
        widget.eventModel.date.formattedToJalali_yearMonthDayWeekDay;
  }

  @override
  void dispose() {
    hostController.dispose();
    entranceFeeController.dispose();
    snacksFeeController.dispose();
    totalSnacksFeeController.dispose();
    totalGuestsController.dispose();
    totalExpenseController.dispose();
    membersController.dispose();
    dateController.dispose();
    debounce.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              EventModificationBloc(locator())
                ..add(InitConfigurations(widget.eventModel)),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<EventModificationBloc, EventModificationState>(
                listenWhen: (p, c) {
                  if (p.closeEventStatus != c.closeEventStatus) return true;
                  if (p.configurationsStatus != c.configurationsStatus) {
                    return true;
                  }
                  return false;
                },
                listener: (context, state) {
                  if (state.configurationsStatus.isSuccess &&
                      state.closeEventStatus is CloseEventInitial) {
                    final addedUserIds = state.registeredGuests.toSet();
                    final totalGuests = addedUserIds.length;
                    final totalSnacksFee =
                        BigInt.from(totalGuests) * widget.eventModel.snacksFee;
                    final totalExpense =
                        totalSnacksFee + widget.eventModel.entranceFee;

                    totalGuestsController.text = totalGuests.toString();
                    totalSnacksFeeController.text = totalSnacksFee
                        .addSeparator();
                    totalExpenseController.text = totalExpense.addSeparator();

                    for (final user in state.allUsers) {
                      if (user.role.isStaff &&
                          !addedUserIds.contains(user.id)) {
                        notAttendedStaffs.add((id: user.id, name: user.name));
                      }
                    }
                  }
                  if (state.closeEventStatus is CloseEventSuccess) {
                    widget.onSubmit(
                      (state.closeEventStatus as CloseEventSuccess).closedEvent,
                    );
                    context.pop();
                  }
                },
              ),
            ],
            child: BlocBuilder<EventModificationBloc, EventModificationState>(
              builder: (context, state) {
                return AppModalListViewSkin(
                  isLoading:
                      state.closeEventStatus is CloseEventLoading ||
                      state.closeEventStatus is CloseEventSuccess ||
                      state.configurationsStatus.isLoading,
                  onSubmit: () {
                    if (!formKey.currentState!.validate()) return;
                    final params = CloseEventParams(
                      id: widget.eventModel.id,
                      date: widget.eventModel.date,
                      entranceFee:
                          entranceFeeController.text.parseStringToBigInt,
                      snacksFee: snacksFeeController.text.parseStringToBigInt,
                      hostInfo: widget.eventModel.hostInfo,
                      staffsInfo: addedStaffs,
                      teamInfo: widget.eventModel.teamInfo,
                      title: widget.eventModel.title,
                      totalRegisteredGuestsNumber:
                          state.registeredGuests.length,
                    );

                    context.read<EventModificationBloc>().add(
                      CloseEvent(params),
                    );
                  },
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          AppTextField(
                            label: 'میزبان ',
                            readOnly: true,
                            controller: hostController,
                          ),
                          Gap(20),
                          AppTextField(
                            label: 'تعداد کلی مهمانان این رویداد',
                            readOnly: true,
                            controller: totalGuestsController,
                          ),
                          Gap(20),
                          AppTextField(
                            label: 'تاریخ برگزاری',
                            controller: dateController,
                            readOnly: true,
                          ),
                          Gap(20),
                          AppTextField(
                            label: 'برگزار کنندگان',
                            hint: 'انتخاب برگزار کنندگان این رویداد',
                            readOnly: true,
                            controller: membersController,
                            suffixIcon: Icons.arrow_drop_down_circle_rounded,
                            onTap: (focusNode) {
                              AppBottomModalSheet.maxHeightWithAppBar(
                                header: 'انتخاب برگزار کنندگان',
                                child: AppSelectRawItemModalView(
                                  items: notAttendedStaffs,
                                  onSelect: (selected) {
                                    addedStaffs.add(selected);
                                    notAttendedStaffs.removeWhere(
                                      (e) => e.id == selected.id,
                                    );
                                    membersController.text =
                                        '${addedStaffs.length} عضو انتخاب شده';
                                    _calculateTotalExpenses();
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
                          if (addedStaffs.isNotEmpty) ...[
                            Gap(10),
                            AppWrapBuilder(
                              addedStaffs.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    addedStaffs.remove(e);
                                    notAttendedStaffs.add(e);
                                    membersController.text =
                                        '${addedStaffs.length} عضو انتخاب شده';
                                    if (addedStaffs.isEmpty)
                                      membersController.clear();
                                    _calculateTotalExpenses();
                                    setState(() {});
                                  },
                                  child: Text(
                                    e.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                          Gap(20),
                          AppTextField(
                            label: 'مبلغ ورودی',
                            hint: '10,000,000',
                            controller: entranceFeeController,
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
                                _calculateTotalExpenses();
                              });
                            },
                          ),
                          Gap(20),
                          Row(
                            children: [
                              Flexible(
                                child: AppTextField(
                                  label: 'پذیرایی',
                                  hint: '10,000,000',
                                  controller: snacksFeeController,
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
                                      _calculateTotalExpenses();
                                    });
                                  },
                                ),
                              ),
                              Gap(8),
                              Flexible(
                                flex: 2,
                                child: AppTextField(
                                  label: 'جمع پذیرایی',
                                  controller: totalSnacksFeeController,
                                  readOnly: true,
                                ),
                              ),
                            ],
                          ),
                          Gap(20),
                          AppTextField(
                            label: 'مبلغ کلی هزینه',
                            hint: '10,000,000',
                            controller: totalExpenseController,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.current.validator_required;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
