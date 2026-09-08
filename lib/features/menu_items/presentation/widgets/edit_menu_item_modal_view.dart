import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/menu_item_model.dart';
import 'package:pay_pilot_plus/core/data/params/menu_item_params.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot_plus/core/widgets/app_text_field.dart';

class EditMenuItemModalView extends StatefulWidget {
  final MenuItemModel item;
  final Function(MenuItemParams item) onPressedSubmit;
  const EditMenuItemModalView({
    super.key,
    required this.item,
    required this.onPressedSubmit,
  });

  @override
  State<EditMenuItemModalView> createState() => _EditMenuItemModalViewState();
}

class _EditMenuItemModalViewState extends State<EditMenuItemModalView> {
  final TextEditingController titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int itemID;

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    itemID = widget.item.id;
    titleController.text = widget.item.title;
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
          id: itemID,
          title: titleController.text,
          isActive: true,
        );
        widget.onPressedSubmit(item);
        context.pop();
      },
    );
  }
}
