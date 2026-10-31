import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';

class AppSecondaryElevatedButton extends StatefulWidget {
  final Size? size;
  final VoidCallback? onTap;
  final Widget child;
  final bool isSelected;
  const AppSecondaryElevatedButton({
    super.key,
    this.size,
    required this.onTap,
    required this.child,
    this.isSelected = false,
  });

  @override
  State<AppSecondaryElevatedButton> createState() =>
      _AppSecondaryElevatedButtonState();
}

class _AppSecondaryElevatedButtonState
    extends State<AppSecondaryElevatedButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isSelected ? null : widget.onTap,
      onTapDown: (details) {
        isPressed = true;
        setState(() {});
      },
      onTapUp: (details) {
        isPressed = false;
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: ClayAnimatedContainer(
          borderRadius: 15,
          color: context.colorScheme.surface,
          surfaceColor: context.colorScheme.primary,
          depth: widget.isSelected || isPressed ? 8 : 18,
          width: widget.size?.width,
          height: widget.size?.height,
          duration: Duration(microseconds: 25),
          // متن روی نارنجی باید تیره باشد (کنتراست ۷.۸:۱)
          child: DefaultTextStyle.merge(
            style: TextStyle(color: context.colorScheme.onPrimary),
            child: IconTheme.merge(
              data: IconThemeData(color: context.colorScheme.onPrimary),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
