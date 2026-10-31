import 'package:flutter/material.dart';

/// توکن‌های رنگی برنامه (تم تیره).
///
/// ویجت‌ها باید رنگ را از `Theme.of(context).colorScheme` بخوانند؛ این کلاس
/// فقط منبع مقدارهاست و برای جاهایی است که `context` در دسترس نیست.
/// همه جفت‌های متن/پس‌زمینه زیر حداقل کنتراست ۴.۵:۱ را دارند.
abstract final class AppColors {
  // پس‌زمینه و سطوح (از پایین به بالا)
  static const Color surface = Color(0xFF00192A);
  static const Color surfaceContainerLow = Color(0xFF062538);
  static const Color surfaceContainer = Color(0xFF0B2E44);
  static const Color surfaceContainerHigh = Color(0xFF12384F);
  static const Color surfaceContainerHighest = Color(0xFF1A4259);

  // متن روی سطوح
  static const Color onSurface = Color(0xFFF1EDBE); // کرم، ۱۵:۱ روی پس‌زمینه
  static const Color onSurfaceVariant = Color(0xFFDEEAF2); // آبی روشن، ۱۴.۶:۱

  // رنگ تاکیدی (نارنجی) و متن روی آن
  static const Color accent = Color(0xFFF7941D); // ۷.۸:۱ روی پس‌زمینه
  static const Color onAccent = Color(0xFF00192A); // ۷.۸:۱ روی نارنجی

  // خطوط
  static const Color outline = Color(0xFF5F7A8C); // ۴:۱، برای مرز فیلدها
  static const Color outlineVariant = Color(0xFF23465C); // تزئینی

  // وضعیت‌ها
  static const Color error = Color(0xFFFF8A80); // ۷.۸:۱
  static const Color success = Color(0xFF6FCF97); // ۹.۴:۱
  static const Color warning = Color(0xFFFFC857); // ۱۱.۶:۱
}

/// رنگ‌های وضعیت که در ColorScheme جایی ندارند.
@immutable
class AppStatusColors extends ThemeExtension<AppStatusColors> {
  final Color success;
  final Color warning;

  const AppStatusColors({required this.success, required this.warning});

  static AppStatusColors of(BuildContext context) =>
      Theme.of(context).extension<AppStatusColors>()!;

  @override
  AppStatusColors copyWith({Color? success, Color? warning}) {
    return AppStatusColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  @override
  AppStatusColors lerp(AppStatusColors? other, double t) {
    if (other == null) return this;
    return AppStatusColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}
