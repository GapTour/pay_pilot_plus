import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/header_model.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';

class HeaderBanner extends StatelessWidget {
  final HeaderModel headerDetails;
  const new({required this.headerDetails, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: kPrimaryContainerColor.withAlpha(50),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: Column(
            mainAxisSize: .max,
            crossAxisAlignment: .stretch,
            children: [
              Text(
                headerDetails.entryDate.formattedToJalali_yearMonthDay,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Gap(8),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'شماره سند   ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: headerDetails.entryNumber,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'نوع سند   ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: headerDetails.type.title,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'توضیحات   ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: headerDetails.description,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
