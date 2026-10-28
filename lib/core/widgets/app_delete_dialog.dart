import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_elevated_button.dart';

class AppDeleteDialog {
  AppDeleteDialog._();

  static void showDefault(
    BuildContext context, {
    required VoidCallback onDelete,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.colorScheme.surfaceContainerHigh,
          title: Text(
            S.current.alertDialog_areYouSure,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          // content: Text(
          //   S.current.alertDialog_noticeThisAboutAction,
          //   style: Theme.of(context).textTheme.bodyMedium,
          // ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(
                S.current.button_title_cancel,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            AppElevatedButton(
              onTap: () {
                onDelete.call();
                context.pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 5,
                ),
                child: Text(
                  S.current.button_title_delete,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(color: context.colorScheme.error),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showCustom(
    BuildContext context, {
    required VoidCallback onPressed,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.colorScheme.surfaceContainerHigh,
          title: Text(
            S.current.alertDialog_areYouSure,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Text(content, style: Theme.of(context).textTheme.bodyMedium),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(
                S.current.button_title_cancel,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            AppElevatedButton(
              onTap: () {
                onPressed.call();
                context.pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 5,
                ),
                child: Text(
                  S.current.button_title_submit,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(color: context.colorScheme.error),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
