import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/team_model.dart';
import 'package:pay_pilot_plus/core/data/params/team_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/parse_string_to_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class EditTeamModalView extends StatefulWidget {
  final TeamModel team;
  final Function(TeamParams team) onPressedSubmit;
  const EditTeamModalView({
    super.key,
    required this.team,
    required this.onPressedSubmit,
  });

  @override
  State<EditTeamModalView> createState() => _EditTeamModalViewState();
}

class _EditTeamModalViewState extends State<EditTeamModalView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int teamID;

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    teamID = widget.team.id;
    titleController.text = widget.team.title;
    descriptionController.text = widget.team.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AppModalColumnViewSkin(
      children: [
        Form(
          key: formKey,
          child: AppTextField(
            label: S.current.textField_label_team,
            hint: S.current.textField_hint_castAwayMovie,
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
          label:
              '${S.current.textField_label_description} ${S.current.textField_label_optional}',
          controller: descriptionController,
          minLines: 3,
          maxLines: 4,
        ),
      ],
      onSubmit: () {
        if (!formKey.currentState!.validate()) return;
        final team = TeamParams(
          id: teamID,
          title: titleController.text,
          isActive: true,
          description: descriptionController.text.parseNullIfIsEmpty,
        );
        widget.onPressedSubmit(team);
        context.pop();
      },
    );
  }
}
