import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pay_pilot_plus/core/utils/constants/app_settings.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/utils/flutter_gen/assets.gen.dart';
import 'package:pay_pilot_plus/core/utils/resources/app_routes.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    context.onPostFrame(() {
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          context.goNamed(AppRoutes.mainScreen);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(child: Assets.icons.icLauncher.image()),
            ),
            Positioned(
              bottom: 45,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  LoadingAnimationWidget.threeArchedCircle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 32,
                  ),
                  Gap(12),
                  Text(
                    'Version ${AppSettings.version}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
