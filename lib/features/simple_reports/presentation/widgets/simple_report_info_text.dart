import 'package:flutter/material.dart';

class SimpleReportInfoText extends StatelessWidget {
  final String title;
  final String value;
  const new({required this.title, required this.value, super.key});

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
