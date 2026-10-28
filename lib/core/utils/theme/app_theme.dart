import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_colors.dart';
import 'package:pay_pilot_plus/core/utils/theme/texts_theme/font_manager.dart';

const _colorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.accent,
  onPrimary: AppColors.onAccent,
  primaryContainer: AppColors.accent,
  onPrimaryContainer: AppColors.onAccent,
  secondary: AppColors.onSurfaceVariant,
  onSecondary: AppColors.surface,
  error: AppColors.error,
  onError: AppColors.surface,
  surface: AppColors.surface,
  onSurface: AppColors.onSurface,
  onSurfaceVariant: AppColors.onSurfaceVariant,
  surfaceContainerLowest: AppColors.surface,
  surfaceContainerLow: AppColors.surfaceContainerLow,
  surfaceContainer: AppColors.surfaceContainer,
  surfaceContainerHigh: AppColors.surfaceContainerHigh,
  surfaceContainerHighest: AppColors.surfaceContainerHighest,
  outline: AppColors.outline,
  outlineVariant: AppColors.outlineVariant,
);

/// مقیاس متن برای فارسی: متن اصلی ۱۴، برچسب‌ها ۱۳، عنوان‌ها ۱۶ تا ۱۸.
/// متن فارسی جزئیات ریزی دارد و زیر ۱۲ خوانا نیست.
const _font = FontManager.primaryFontFamily;

/// همه سبک‌ها fontFamily دارند، چون برخی (دکمه، دیالوگ، اسنک‌بار)
/// مستقیم به تم اجزا داده می‌شوند و فونت ThemeData به آن‌ها نمی‌رسد.
const _textTheme = TextTheme(
  titleLarge: TextStyle(
    fontFamily: _font,

    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
  ),
  titleMedium: TextStyle(
    fontFamily: _font,

    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurfaceVariant,
  ),
  bodyLarge: TextStyle(
    fontFamily: _font,
    fontSize: 16,
    color: AppColors.onSurface,
  ),
  bodyMedium: TextStyle(
    fontFamily: _font,
    fontSize: 14,
    color: AppColors.onSurfaceVariant,
  ),
  bodySmall: TextStyle(
    fontFamily: _font,
    fontSize: 12,
    color: AppColors.onSurfaceVariant,
  ),
  labelLarge: TextStyle(
    fontFamily: _font,

    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
  ),
  labelMedium: TextStyle(
    fontFamily: _font,
    fontSize: 12,
    color: AppColors.onSurfaceVariant,
  ),
  labelSmall: TextStyle(
    fontFamily: _font,
    fontSize: 11,
    color: AppColors.onAccent,
  ),
);

const _fieldRadius = BorderRadius.all(Radius.circular(12));

final ThemeData appTheme = ThemeData(
  fontFamily: _font,
  colorScheme: _colorScheme,
  scaffoldBackgroundColor: AppColors.surface,
  textTheme: _textTheme,
  extensions: const [
    AppStatusColors(success: AppColors.success, warning: AppColors.warning),
  ],
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.onSurface,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: _font,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurface,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceContainerLow,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    hintStyle: TextStyle(
      fontFamily: _font,
      color: AppColors.onSurface.withAlpha(140),
      fontSize: 15,
    ),
    labelStyle: _textTheme.labelLarge,
    floatingLabelStyle: _textTheme.labelLarge,
    errorStyle: const TextStyle(
      fontFamily: _font,
      color: AppColors.error,
      fontSize: 12,
    ),
    prefixIconColor: AppColors.onSurfaceVariant,
    suffixIconColor: AppColors.onSurfaceVariant,
    border: const OutlineInputBorder(
      borderRadius: _fieldRadius,
      borderSide: BorderSide(color: AppColors.outline),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: _fieldRadius,
      borderSide: BorderSide(color: AppColors.outline),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: _fieldRadius,
      borderSide: BorderSide(color: AppColors.accent, width: 1.5),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: _fieldRadius,
      borderSide: BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: _fieldRadius,
      borderSide: BorderSide(color: AppColors.error, width: 1.5),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.accent,
    selectionColor: AppColors.accent.withAlpha(90),
    selectionHandleColor: AppColors.accent,
  ),
  cardTheme: const CardThemeData(
    color: AppColors.surfaceContainer,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.surfaceContainerHigh,
    surfaceTintColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    titleTextStyle: _textTheme.titleLarge,
    contentTextStyle: _textTheme.bodyLarge,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.surfaceContainerLow,
    modalBackgroundColor: AppColors.surfaceContainerLow,
    surfaceTintColor: Colors.transparent,
    showDragHandle: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.surfaceContainerHighest,
    contentTextStyle: _textTheme.bodyLarge,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: AppColors.outlineVariant,
    thickness: 1,
    space: 1,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.accent,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.accent,
    foregroundColor: AppColors.onAccent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.onAccent,
      minimumSize: const Size(64, 48),
      textStyle: _textTheme.labelLarge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.onSurface,
      minimumSize: const Size(48, 48),
      textStyle: _textTheme.labelLarge,
    ),
  ),
);
