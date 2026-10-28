import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';

class AppElevatedButton extends StatefulWidget {
  final Size? size;
  final VoidCallback? onTap;
  final Widget child;
  final bool isSelected;
  const AppElevatedButton({
    super.key,
    this.size,
    required this.onTap,
    required this.child,
    this.isSelected = false,
  });

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton> {
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
          depth: widget.isSelected || isPressed ? 5 : 8,
          width: widget.size?.width,
          height: widget.size?.height,
          duration: Duration(microseconds: 25),
          child: widget.child,
        ),
      ),
    );
  }
}
