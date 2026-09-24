import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/data/models/journal_line_model.dart';

class ExtraJournalInfo extends StatelessWidget {
  final JournalLineModel journal;
  const new({required this.journal, super.key});

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
