import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_string_to_extension.dart';
import 'package:pay_pilot_plus/core/utils/formatters/price_input_formatter.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_pick_jalali_date.dart';
import 'package:pay_pilot_plus/core/widgets/app_select_modal_view.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class AddEventModalView extends StatefulWidget {
  final List<TeamModel> teams;
  final List<UserModel> hosts;
  final Function(EventParams event) onPressedSubmit;
  const AddEventModalView({
    super.key,
    required this.teams,
    required this.hosts,
    required this.onPressedSubmit,
  });

  @override
  State<AddEventModalView> createState() => _AddEventModalViewState();
}

class _AddEventModalViewState extends State<AddEventModalView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController teamController = TextEditingController();
  final TextEditingController hostController = TextEditingController();
  final TextEditingController entranceFeeController = TextEditingController();
  final TextEditingController snacksFeeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ({int id, String name})? teamInfo;
  ({int id, String name})? userInfo;
  DateTime? selectedDate;

  @override
  void dispose() {
    teamController.dispose();
    titleController.dispose();
    dateController.dispose();
    entranceFeeController.dispose();
    snacksFeeController.dispose();
    hostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppModalColumnViewSkin(
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              AppTextField(
                label: S.current.textField_label_title,
                hint: S.current.textField_hint_castAwayMovie,
                controller: titleController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.validator_required;
                  }
                  return null;
                },
              ),
              Gap(20),
              AppTextField(
                label: S.current.dropDownButton_label_teams,
                hint: S.current.dropDownButton_hint_selectTeam,
                controller: teamController,
                readOnly: true,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'انتخاب تیم',
                    child: AppSelectModalView(
                      items: widget.teams.map((e) {
                        return (id: e.id, name: e.title);
                      }).toList(),
                      onSelect: (selected) {
                        teamInfo = selected;
                        teamController.text = selected.name;
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
                label: 'میزبان',
                hint: 'میزبان این رویداد رو انتخاب کنید',
                controller: hostController,
                readOnly: true,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'انتخاب میزبان',
                    child: AppSelectModalView(
                      items: widget.hosts.where((w) => w.role.isHost).map((e) {
                        return (id: e.id, name: e.name);
                      }).toList(),
                      onSelect: (selected) {
                        userInfo = selected;
                        hostController.text = selected.name;
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
                label: 'مبلغ ورودی',
                hint: '1,500,000',
                controller: entranceFeeController,
                keyboardType: TextInputType.number,
                inputFormatters: [PriceInputFormatter()],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.validator_required;
                  }
                  return null;
                },
              ),
              Gap(20),
              AppTextField(
                label: 'هزینه پذیرایی',
                hint: '350,000',
                controller: snacksFeeController,
                keyboardType: TextInputType.number,
                inputFormatters: [PriceInputFormatter()],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.validator_required;
                  }
                  return null;
                },
              ),
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
                      selectedDate = pickedDate;
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
            ],
          ),
        ),
      ],
      onSubmit: () {
        if (!formKey.currentState!.validate()) return;

        final event = EventParams(
          id: null,
          title: titleController.text,
          date: selectedDate!,
          teamInfo: teamInfo!,
          userInfo: userInfo!,
          isClosed: false,
          entranceFee: entranceFeeController.text.parseStringToBigInt,
          snacksFee: snacksFeeController.text.parseStringToBigInt,
        );
        widget.onPressedSubmit(event);
        context.pop();
      },
    );
  }
}
