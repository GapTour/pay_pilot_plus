import 'package:flutter/material.dart';

class JournalText extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? suffix;
  const new({
    required this.title,
    required this.subtitle,
    this.suffix,
    super.key,
  });

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
