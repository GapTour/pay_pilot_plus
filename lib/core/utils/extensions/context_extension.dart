import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  ThemeData get themeOf => Theme.of(this);
  Size get deviceSize => MediaQuery.sizeOf(this);
  Object? get goRouterState => GoRouterState.of(this).extra;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isLargeScreen => MediaQuery.sizeOf(this).width >= 1400;
  bool get isSmallScreen => MediaQuery.sizeOf(this).width < 600;
  bool get isMediumScreen =>
      MediaQuery.sizeOf(this).width >= 600 &&
      MediaQuery.sizeOf(this).width < 1200;
  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;
  bool get isPortrait => MediaQuery.orientationOf(this) == Orientation.portrait;
  bool get isWeb => kIsWeb;
  bool get isIOS {
    if (kIsWeb) return false;
    return Theme.of(this).platform == TargetPlatform.iOS;
  }

  bool get isAndroid {
    if (kIsWeb) return false;
    return Theme.of(this).platform == TargetPlatform.android;
  }

  bool get isLinux {
    if (kIsWeb) return false;
    return Theme.of(this).platform == TargetPlatform.linux;
  }

  bool get isMacos {
    if (kIsWeb) return false;
    return Theme.of(this).platform == TargetPlatform.macOS;
  }

  bool get isWindows {
    if (kIsWeb) return false;
    return Theme.of(this).platform == TargetPlatform.windows;
  }

  void hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

  void onPostFrame(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) => callback());
  }

  double get responsiveMaxGridAxisExtent {
    final deviceWidth = MediaQuery.sizeOf(this).width;

    if (deviceWidth <= 400) return 400;
    return deviceWidth;
  }
}
