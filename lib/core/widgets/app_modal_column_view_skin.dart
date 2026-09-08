import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_elevated_button.dart';

class AppModalColumnViewSkin extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onSubmit;
  const AppModalColumnViewSkin({
    required this.children,
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 24, left: 24, bottom: 120),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: context.deviceSize.height * .4,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: children,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              boxShadow: [
                BoxShadow(
                  color: kPrimaryContainerColor.withAlpha(100),
                  blurRadius: 15,
                  spreadRadius: -12,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                right: 24,
                left: 24,
                bottom: 20,
              ),
              child: AppElevatedButton(
                onTap: onSubmit,
                size: Size(context.deviceSize.width, 42),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      S.current.button_title_submit,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
