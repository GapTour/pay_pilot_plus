import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/resources/app_routes.dart';
import 'package:pay_pilot_plus/core/widgets/app_elevated_button.dart';

class AppBottomModalSheet {
  AppBottomModalSheet._();

  static void maxHeightWithAppBar({
    required String header,
    required Widget child,
    bool enableDrag = true,
    bool canPop = true,
    VoidCallback? onBack,
    VoidCallback? onInitialize,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: enableDrag,
      context: navigatorKey.currentState!.context,
      builder: (context) {
        /// put any thing we need to initial before render modal bottom sheet
        if (onInitialize != null) {
          onInitialize();
        }

        return PopScope(
          canPop: canPop,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 45,
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70, bottom: 24),
                    child: child,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerLow,
                      boxShadow: [
                        BoxShadow(
                          color: context.colorScheme.primary.withAlpha(55),
                          blurRadius: 15,
                          spreadRadius: -12,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 16,
                        left: 16,
                        bottom: 10,
                      ),
                      child: Row(
                        children: [
                          AppElevatedButton(
                            onTap: () {
                              onBack?.call();
                              context.pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.close),
                            ),
                          ),

                          Gap(12),
                          Expanded(
                            child: Text(header, textAlign: TextAlign.start),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void minHeightWithAppBar({
    required String header,
    required Widget child,
    bool enableDrag = true,
    bool canPop = true,
    VoidCallback? onBack,
    VoidCallback? onInitialize,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: enableDrag,
      context: navigatorKey.currentState!.context,
      builder: (context) {
        /// put any thing we need to initial before render modal bottom sheet
        if (onInitialize != null) {
          onInitialize();
        }

        return PopScope(
          canPop: canPop,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 45,
            ),
            child: Column(
              mainAxisSize: .min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      AppElevatedButton(
                        onTap: () {
                          onBack?.call();
                          context.pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.close),
                        ),
                      ),
                      Gap(12),
                      Expanded(child: Text(header, textAlign: TextAlign.start)),
                    ],
                  ),
                ),
                Gap(25),
                child,
              ],
            ),
          ),
        );
      },
    );
  }

  static void minHeightWithButtons({
    required Widget child,
    Widget? rightButton,
    Widget? leftButton,
    VoidCallback? onInitialize,
    bool enableDrag = true,
    bool canPop = true,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: enableDrag,
      context: navigatorKey.currentState!.context,
      builder: (context) {
        /// put any thing we need to initial before render modal bottom sheet
        if (onInitialize != null) {
          onInitialize();
        }

        return PopScope(
          canPop: canPop,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 24,
              right: 16,
              left: 16,
            ),
            child: Column(
              mainAxisSize: .min,
              children: [
                child,
                Gap(24),
                if (rightButton != null && leftButton != null)
                  Row(
                    mainAxisSize: .max,
                    children: [
                      Expanded(child: rightButton),
                      Gap(8),
                      Expanded(child: leftButton),
                    ],
                  )
                else ...[
                  ?rightButton,
                  ?leftButton,
                ],
                Gap(32),
              ],
            ),
          ),
        );
      },
    );
  }
}
