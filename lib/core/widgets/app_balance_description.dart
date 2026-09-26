import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/utils/extensions/wrap_to_box_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';

class AppBalanceDescription extends StatelessWidget {
  final String plusNote;
  final String minesNote;
  const new({required this.plusNote, required this.minesNote, super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .start,
          children: [
            Row(
              children: [
                Text(
                  '-',
                  style: Theme.of(context).textTheme.displayLarge
                      ?.copyWith(color: kPrimaryColor),
                ).wrapToCircleBoxWithOnlyPadding(
                  right: 8,
                  left: 8,
                  top: 5,
                  bottom: 2.5,
                  color: kSecondaryColor,
                ),
                Gap(8),
                Text(
                  minesNote,
                  style: Theme.of(context).textTheme.displayMedium
                      ?.copyWith(color: kOnPrimaryColor),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '+',
                  style: Theme.of(context).textTheme.labelMedium
                      ?.copyWith(color: kPrimaryColor),
                ).wrapToCircleBoxWithOnlyPadding(
                  right: 6.5,
                  left: 6.5,
                  top: 3.5,
                  bottom: 1,
                  color: kSecondaryColor,
                ),
                Gap(8),
                Text(
                  plusNote,
                  style: Theme.of(context).textTheme.displayMedium
                      ?.copyWith(color: kOnPrimaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
