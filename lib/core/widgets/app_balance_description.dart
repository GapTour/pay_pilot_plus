import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/wrap_to_box_extension.dart';

class AppBalanceDescription extends StatelessWidget {
  final String plusNote;
  final String minesNote;
  const new({required this.plusNote, required this.minesNote, super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
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
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(color: context.colorScheme.onPrimary),
                ).wrapToCircleBoxWithOnlyPadding(
                  right: 8,
                  left: 8,
                  top: 5,
                  bottom: 2.5,
                  color: context.colorScheme.primary,
                ),
                Gap(8),
                Flexible(
                  child: Text(
                    minesNote,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: context.colorScheme.onSurface),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '+',
                  style: Theme.of(context).textTheme.labelMedium
                      ?.copyWith(color: context.colorScheme.onPrimary),
                ).wrapToCircleBoxWithOnlyPadding(
                  right: 6.5,
                  left: 6.5,
                  top: 3.5,
                  bottom: 1,
                  color: context.colorScheme.primary,
                ),
                Gap(8),
                Flexible(
                  child: Text(
                    plusNote,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: context.colorScheme.onSurface),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
