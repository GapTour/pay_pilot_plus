import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';

class AppFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? splashColor;
  final Widget? child;
  final bool isLoading;
  const new(
    this.onPressed, {
    this.backgroundColor,
    this.splashColor,
    this.child,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: isLoading ? null : onPressed,
      backgroundColor: kSecondaryColor,
      splashColor: kPrimaryColor,
      child: const Icon(Icons.add),
    );
  }
}
