import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';

class AppJournalTile extends StatelessWidget {
  final JournalLineModel journal;
  const new({required this.journal, super.key});

  @override
  Widget build(BuildContext context) {
    return AppTileInRow(
      parent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 3.5,
        children: [
          _JournalText(
            title: 'حساب معین',
            subtitle: journal.subsidiaryAccount.type.title,
            suffix: journal.subsidiaryAccount.type.completeCode,
          ),

          if (journal.firstDetailedInfo != null)
            _JournalText(
              title: 'تفضیلی ۱',
              subtitle: journal.firstDetailedInfo!.name,
              suffix: journal.firstDetailedInfo!.code,
            ),
          if (journal.secondDetailedInfo != null)
            _JournalText(
              title: 'تفضیلی ۲',
              subtitle: journal.secondDetailedInfo!.name,
              suffix: journal.secondDetailedInfo!.code,
            ),
          _JournalText(title: 'شرح سند', subtitle: journal.memo ?? '***'),
          Gap(8),
          Row(
            children: [
              _DebtorBox(debitAmount: journal.debit),
              _CreditorBox(creditAmount: journal.credit),
            ],
          ),
          Gap(5),
        ],
      ),
      child: _ExtraJournalInfo(journal: journal),
    );
  }
}

class _DebtorBox extends StatelessWidget {
  final BigInt debitAmount;
  const new({required this.debitAmount});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Opacity(
        opacity: debitAmount > BigInt.zero ? 1 : .35,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
            color: kPrimaryContainerColor.withAlpha(60),
            border: Border.fromBorderSide(BorderSide(color: kOnSecondaryColor)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 3),
                child: Text(
                  'بدهکار',
                  style: Theme.of(context).textTheme.headlineSmall!
                      .copyWith(color: kOnSecondaryColor),
                ),
              ),
              Divider(color: kOnSecondaryColor),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 3),
                child: Text(
                  debitAmount.toInt().addSeparator(),
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

class _CreditorBox extends StatelessWidget {
  final BigInt creditAmount;
  const new({required this.creditAmount});

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

class _JournalText extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? suffix;
  const new({required this.title, required this.subtitle, this.suffix});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$title   ',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextSpan(
                  text: subtitle,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ),
        ),

        Text(suffix ?? '', style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}

class _ExtraJournalInfo extends StatelessWidget {
  final JournalLineModel journal;
  const new({required this.journal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'گروه حساب   ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: journal.subsidiaryAccount.accountGroup.type.title,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              journal.subsidiaryAccount.accountGroup.type.prefix,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'حساب کل   ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: journal.subsidiaryAccount.generalAccount.type.title,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              journal.subsidiaryAccount.generalAccount.type.completeCode,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'سریال   ',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Text(
              journal.series,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ],
    );
  }
}
