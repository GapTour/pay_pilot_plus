import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/utils/theme/texts_theme/app_text_style.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';

enum SettlementStatus {
  unsettled('پرداخت نشده'),
  bankDeposit('واریز به بانک'),
  cash('پرداخت نقدی');

  final String title;
  const SettlementStatus(this.title);

  bool get isUnsettled => this == .unsettled;
  bool get isBankDeposit => this == .bankDeposit;
}

class SelectSettlementStatusModalView extends StatelessWidget {
  final Function(SettlementStatus selected) onSelected;
  const SelectSettlementStatusModalView({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 24, left: 24, bottom: 55),
      child: Column(
        spacing: 8,
        children: SettlementStatus.values.map((e) {
          return InkWell(
            onTap: () {
              onSelected(e);
              context.pop();
            },
            child: AppTileInRow(
              parent: Text(
                e.title,
                style: AppTextStyle.getRegularStyle(fontSize: 14),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
