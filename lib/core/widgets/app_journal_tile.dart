import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
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
            title: S.current.journal_subsidiaryAccount,
            subtitle: journal.subsidiaryAccount.type.localizedTitle,
            suffix: journal.subsidiaryAccount.type.completeCode,
          ),

          if (journal.firstDetailedInfo != null)
            _JournalText(
              title: S.current.journal_firstDetailed,
              subtitle: journal.firstDetailedInfo!.name,
              suffix: journal.firstDetailedInfo!.code,
            ),
          if (journal.secondDetailedInfo != null)
            _JournalText(
              title: S.current.journal_secondDetailed,
              subtitle: journal.secondDetailedInfo!.name,
              suffix: journal.secondDetailedInfo!.code,
            ),
          _JournalText(
            title: S.current.journal_description,
            subtitle: journal.memo ?? '***',
          ),
          Gap(8),
          if (journal.noticeMemo != null) ...[
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: Text(
                  journal.noticeMemo!,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: context.colorScheme.onPrimary),
                ),
              ),
            ),
            Gap(8),
          ],
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
        opacity: debitAmount > BigInt.zero
            ? 1
            : .7, // ستون خالی کم‌رنگ‌تر، ولی خوانا (۵.۵:۱)
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
            color: context.colorScheme.surfaceContainerHighest,
            border: Border.fromBorderSide(
              BorderSide(color: context.colorScheme.outline),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 3),
                child: Text(
                  S.current.journal_debit,
                  style: Theme.of(context).textTheme.labelLarge!
                      .copyWith(color: context.colorScheme.onSurface),
                ),
              ),
              Divider(color: context.colorScheme.outline),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 3),
                child: Text(
                  debitAmount.addSeparator(),
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(color: context.colorScheme.onSurface),
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
        opacity: creditAmount > BigInt.zero
            ? 1
            : .7, // ستون خالی کم‌رنگ‌تر، ولی خوانا (۵.۵:۱)
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
            color: context.colorScheme.surfaceContainerHighest,
            border: Border.fromBorderSide(
              BorderSide(color: context.colorScheme.outline),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 3),
                child: Text(
                  S.current.journal_credit,
                  style: Theme.of(context).textTheme.labelLarge!
                      .copyWith(color: context.colorScheme.onSurface),
                ),
              ),
              Divider(color: context.colorScheme.outline),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 3),
                child: Text(
                  creditAmount.addSeparator(),
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(color: context.colorScheme.onSurface),
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
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                TextSpan(
                  text: subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),

        Text(suffix ?? '', style: Theme.of(context).textTheme.labelLarge),
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
                      text: '${S.current.journal_accountGroup}   ',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    TextSpan(
                      text: journal
                          .subsidiaryAccount
                          .accountGroup
                          .type
                          .localizedTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              journal.subsidiaryAccount.accountGroup.type.prefix,
              style: Theme.of(context).textTheme.labelLarge,
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
                      text: '${S.current.journal_generalAccount}   ',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    TextSpan(
                      text: journal
                          .subsidiaryAccount
                          .generalAccount
                          .type
                          .localizedTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              journal.subsidiaryAccount.generalAccount.type.completeCode,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                '${S.current.journal_series}   ',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Text(journal.series, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
