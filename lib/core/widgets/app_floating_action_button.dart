import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';

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
      backgroundColor: context.colorScheme.primary,
      splashColor: context.colorScheme.onPrimary,
      child: const Icon(Icons.add),
    );
  }
}
