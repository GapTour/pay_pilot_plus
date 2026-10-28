import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/features/simple_reports/presentation/widgets/simple_report_info_text.dart';

class SimpleReportBanner extends StatelessWidget {
  final String? title;
  final List<({String title, String value})> rows;
  const new({required this.rows, this.title, super.key});

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
              if (title != null)
                Text(title!, style: Theme.of(context).textTheme.displayLarge),
              for (final row in rows)
                SimpleReportInfoText(title: row.title, value: row.value),
            ],
          ),
        ),
      ),
    );
  }
}
