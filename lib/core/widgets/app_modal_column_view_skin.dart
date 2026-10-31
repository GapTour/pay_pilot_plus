import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_elevated_button.dart';

class AppModalColumnViewSkin extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onSubmit;
  final bool isLoading;
  const AppModalColumnViewSkin({
    required this.children,
    required this.onSubmit,
    this.isLoading = false,
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
              minWidth: context.deviceSize.width,
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
              color: context.colorScheme.surfaceContainerLow,
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.outline,
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
                onTap: isLoading ? null : onSubmit,
                size: Size(context.deviceSize.width, 42),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator.adaptive()
                        : Text(
                            S.current.button_title_submit,
                            style: Theme.of(context).textTheme.titleMedium,
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
