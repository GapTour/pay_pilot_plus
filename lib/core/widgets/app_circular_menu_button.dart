import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';

class AppCircularMenuButton extends StatelessWidget {
  final List<Widget> children;
  const AppCircularMenuButton({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return FabCircularMenuPlus(
      alignment: Alignment.bottomLeft,
      ringColor: Colors.white.withAlpha(25),
      ringDiameter: 400.0,
      ringWidth: 100.0,
      fabSize: 64.0,
      fabElevation: 8.0,
      fabIconBorder: CircleBorder(),
      fabMargin: EdgeInsets.zero,
      fabColor: kSecondaryColor,
      children: children,
    );
  }
}
