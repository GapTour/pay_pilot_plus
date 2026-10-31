import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/data/models/fund_balance_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';

class FundBalanceTile extends StatelessWidget {
  final FundBalanceModel balanceInfo;
  final String? debitTitle;
  final String? creditTitle;
  const new({
    required this.balanceInfo,
    this.creditTitle,
    this.debitTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppTileInRow(
      parent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 3.5,
        children: [
          _JournalText(
            title: S.current.textField_label_date,
            subtitle: balanceInfo.date.formattedToJalali_yearMonthDay,
          ),
          Gap(8),
          Row(
            children: [
              _DebtorBox(debitAmount: balanceInfo.debit, title: debitTitle),
              _CreditorBox(
                creditAmount: balanceInfo.credit,
                title: creditTitle,
              ),
            ],
          ),
          Gap(5),
        ],
      ),
      child: _ExtraJournalInfo(balanceInfo: balanceInfo),
    );
  }
}

class _DebtorBox extends StatelessWidget {
  final BigInt debitAmount;
  final String? title;
  const new({required this.debitAmount, this.title});

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
                  title ?? S.current.journal_debit,
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
  final String? title;
  const new({required this.creditAmount, this.title});

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
                  title ?? S.current.journal_credit,
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
  final FundBalanceModel balanceInfo;
  const new({required this.balanceInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _JournalText(
          title: S.current.journal_series,
          subtitle: '',
          suffix: balanceInfo.series,
          // suffix: journal.subsidiaryAccount.type.completeCode,
        ),
        _JournalText(
          title: S.current.textField_label_description,
          subtitle: balanceInfo.memo ?? '***',
        ),
      ],
    );
  }
}
