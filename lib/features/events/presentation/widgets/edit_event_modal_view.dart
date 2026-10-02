import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_list_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_pick_jalali_date.dart';
import 'package:pay_pilot_plus/core/widgets/app_select_raw_item_modal_view.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class EditEventModalView extends StatefulWidget {
  final EventModel eventDetails;
  final List<TeamModel> teams;
  final List<UserModel> hosts;
  final Function(EventParams event) onPressedSubmit;
  const EditEventModalView({
    super.key,
    required this.eventDetails,
    required this.teams,
    required this.hosts,
    required this.onPressedSubmit,
  });

  @override
  State<EditEventModalView> createState() => _EditEventModalViewState();
}

class _EditEventModalViewState extends State<EditEventModalView> {
  final TextEditingController teamController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hostController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late ({int id, String name}) teamInfo;
  late ({int id, String name}) hostInfo;
  late DateTime selectedDate;

  @override
  void dispose() {
    teamController.dispose();
    titleController.dispose();
    dateController.dispose();
    hostController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    titleController.text = widget.eventDetails.title;
    selectedDate = widget.eventDetails.date;
    dateController.text = selectedDate.formattedToJalali_yearMonthDay;

    teamInfo = widget.eventDetails.teamInfo;
    teamController.text = teamInfo.name;

    hostInfo = widget.eventDetails.hostInfo;
    hostController.text = hostInfo.name;
  }

  @override
  Widget build(BuildContext context) {
    return AppModalListViewSkin(
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
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                readOnly: true,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'انتخاب تیم',
                    child: AppSelectRawItemModalView(
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
                suffixIcon: Icons.arrow_drop_down_circle_rounded,
                readOnly: true,
                onTap: (focusNode) {
                  AppBottomModalSheet.maxHeightWithAppBar(
                    header: 'انتخاب میزبان',
                    child: AppSelectRawItemModalView(
                      items: widget.hosts.where((w) => w.role.isHost).map((e) {
                        return (id: e.id, name: e.name);
                      }).toList(),
                      onSelect: (selected) {
                        hostInfo = selected;
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
          id: widget.eventDetails.id,
          title: titleController.text,
          date: selectedDate,
          teamInfo: teamInfo,
          hostInfo: hostInfo,
        );
        widget.onPressedSubmit(event);
        context.pop();
      },
    );
  }
}
