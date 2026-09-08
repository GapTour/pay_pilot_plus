import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/params/menu_item_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class AddMenuItemModalView extends StatefulWidget {
  final Function(MenuItemParams item) onPressedSubmit;
  const AddMenuItemModalView({super.key, required this.onPressedSubmit});

  @override
  State<AddMenuItemModalView> createState() => _AddMenuItemModalViewState();
}

class _AddMenuItemModalViewState extends State<AddMenuItemModalView> {
  final TextEditingController titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppModalColumnViewSkin(
      children: [
        Form(
          key: formKey,
          child: AppTextField(
            label: S.current.textField_label_title,
            hint: S.current.textField_hint_chocolateCake,
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
      ],
      onSubmit: () {
        if (!formKey.currentState!.validate()) return;
        final item = MenuItemParams(
          id: null,
          title: titleController.text,
          isActive: true,
        );
        widget.onPressedSubmit(item);
        context.pop();
      },
    );
  }
}
