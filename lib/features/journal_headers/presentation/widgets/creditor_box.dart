import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';

class CreditorBox extends StatelessWidget {
  final BigInt creditAmount;
  const new({required this.creditAmount, super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Opacity(
        opacity: creditAmount > BigInt.zero ? 1 : .35,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
            color: kPrimaryContainerColor.withAlpha(60),
            border: Border.fromBorderSide(BorderSide(color: kOnSecondaryColor)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 3),
                child: Text(
                  'بستانکار',
                  style: Theme.of(context).textTheme.headlineSmall!
                      .copyWith(color: kOnSecondaryColor),
                ),
              ),
              Divider(color: kOnSecondaryColor),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 3),
                child: Text(
                  creditAmount.toInt().addSeparator(),
                  style: Theme.of(context).textTheme.displayMedium!
                      .copyWith(color: kOnSecondaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
