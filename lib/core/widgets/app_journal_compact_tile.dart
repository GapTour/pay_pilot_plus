import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/data/models/detailed_account_model.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/format_date_to_persian_calendar_extension.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_colors.dart';
import 'package:pay_pilot_plus/core/widgets/app_tile_in_row.dart';

/// نسخه ساده [AppJournalHiddenTile]: شرح، تاریخ و مبلغ علامت‌دار؛
/// با لمس، حساب تفصیلی دوم (اگر باشد) و سری سند نمایش داده می‌شود.
class AppJournalCompactTile extends StatelessWidget {
  final String? memo;
  final DateTime? date;
  final BigInt debit;
  final BigInt credit;
  final String series;
  final DetailedAccountModel? secondDetailed;

  /// آیا بدهکار برای این حساب افزایش است؟ پیش‌فرض مثل مانده صفحات گردش
  /// (بدهکار − بستانکار)؛ مثلا در بانک، بدهکار یعنی واریز (+)
  final bool debitIsPositive;
  const AppJournalCompactTile({
    required this.memo,
    required this.date,
    required this.debit,
    required this.credit,
    required this.series,
    this.secondDetailed,
    this.debitIsPositive = true,
    super.key,
  });

  AppJournalCompactTile.fromJournal(
    JournalLineModel journal, {
    bool debitIsPositive = true,
    Key? key,
  }) : this(
         memo: journal.memo,
         date: journal.date,
         debit: journal.debit,
         credit: journal.credit,
         series: journal.series,
         secondDetailed: journal.secondDetailedInfo,
         debitIsPositive: debitIsPositive,
         key: key,
       );

  @override
  Widget build(BuildContext context) {
    final textTheme = context.themeOf.textTheme;
    final isDebit = debit > BigInt.zero;
    final isPositive = isDebit == debitIsPositive;
    final amount = isDebit ? debit : credit;
    final second = secondDetailed;

    return AppTileInRow(
      parent: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 2,
              children: [
                Text(memo ?? '***', style: textTheme.bodyMedium),
                if (date != null)
                  Text(
                    date!.formattedToJalali_yearMonthDay,
                    // کم‌رنگ‌تر از شرح تا شرح جلوتر دیده شود
                    style: textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant.withAlpha(
                        170,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // علامت باید سمت چپ عدد بماند، پس متن چپ‌به‌راست است
          Text(
            '${isPositive ? '+' : '−'} ${amount.addSeparator()}',
            textDirection: TextDirection.ltr,
            style: textTheme.bodyLarge?.copyWith(
              color: isPositive
                  ? AppStatusColors.of(context).success
                  : context.colorScheme.error,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: 4,
        children: [
          if (second != null)
            _InfoLine(
              title: S.current.journal_secondDetailed,
              value: second.name,
              suffix: second.code,
            ),
          _InfoLine(title: S.current.journal_series, value: series),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final String title;
  final String value;
  final String? suffix;
  const new({required this.title, required this.value, this.suffix});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.themeOf.textTheme;

    return Row(
      crossAxisAlignment: .start,
      children: [
        Text('$title   ', style: textTheme.labelLarge),
        Expanded(child: Text(value, style: textTheme.bodyMedium)),
        if (suffix != null) Text(suffix!, style: textTheme.labelLarge),
      ],
    );
  }
}
