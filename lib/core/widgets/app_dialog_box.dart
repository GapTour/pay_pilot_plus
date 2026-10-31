import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_elevated_button.dart';

class AppDialogBox extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback onPressed;
  const AppDialogBox({
    super.key,
    required this.title,
    required this.children,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 780,
        height: 507,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              ListView(children: [Gap(35), ...children]),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerHigh,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
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
                    color: context.colorScheme.surfaceContainerHigh,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppElevatedButton(
                            onTap: onPressed,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                S.current.button_title_submit,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ),
                        Gap(8),
                        TextButton(
                          onPressed: () => context.pop(),

                          child: Text(
                            S.current.button_title_cancel,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
