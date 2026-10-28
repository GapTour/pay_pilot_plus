import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/utils/extensions/manage_separator_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';

class ReportSummaryBanner extends StatelessWidget {
  final BigInt totalDebit;
  final BigInt totalCredit;
  final BigInt balance;
  final int linesCount;
  const new({
    required this.totalDebit,
    required this.totalCredit,
    required this.balance,
    required this.linesCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
            spacing: 3.5,
            children: [
              _SummaryText(title: 'تعداد ردیف‌ها', value: '$linesCount'),
              _SummaryText(
                title: 'جمع بدهکار',
                value: totalDebit.addSeparator(),
              ),
              _SummaryText(
                title: 'جمع بستانکار',
                value: totalCredit.addSeparator(),
              ),
              _SummaryText(
                title: 'مانده',
                value: balance.addSeparatorWithSymbol(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryText extends StatelessWidget {
  final String title;
  final String value;
  const new({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$title   ',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
