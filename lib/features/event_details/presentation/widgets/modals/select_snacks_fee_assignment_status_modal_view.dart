import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart'
    show SnacksFeeAssignmentStatus;
import 'package:pay_pilot_plus/core/utils/theme/texts_theme/app_text_style.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';

class SelectSnacksFeeAssignmentStatusModalView extends StatelessWidget {
  final Function(SnacksFeeAssignmentStatus selected) onSelected;
  const SelectSnacksFeeAssignmentStatusModalView({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 24, left: 24, bottom: 55),
      child: Column(
        spacing: 8,
        children: SnacksFeeAssignmentStatus.values.map((e) {
          return InkWell(
            onTap: () {
              onSelected(e);
              context.pop();
            },
            child: AppTileInRow(
              parent: Text(
                e.localizedTitle,
                style: AppTextStyle.getRegularStyle(fontSize: 14),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
