import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';

class AppLoadingState extends StatelessWidget {
  const AppLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    // رنگ اصلی از progressIndicatorTheme (نارنجی) می‌آید؛ مسیر کم‌رنگ است
    // تا چرخش دیده شود
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: context.colorScheme.primary.withAlpha(50),
      ),
    );
  }
}
