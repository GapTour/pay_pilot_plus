import 'package:flutter/material.dart'
    show TextStyle, FontWeight, Color, FontStyle, Shadow, TextDecoration;
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/utils/theme/texts_theme/font_manager.dart';

enum TextStyleStatus { underline, simple }

class AppTextStyle {
  AppTextStyle._();

  //* Regular Style
  static TextStyle getRegularStyle({
    Color? color,
    required double fontSize,
    TextStyleStatus textStyleStatus = TextStyleStatus.simple,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return _getTextStyle(
      fontSize,
      FontManager.w400Regular,
      color,
      fontStyle: fontStyle,
      textStyleStatus: textStyleStatus,
    );
  }

  //* Medium Style
  static TextStyle getMediumStyle({
    Color? color,
    required double fontSize,
    TextStyleStatus textStyleStatus = TextStyleStatus.simple,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return _getTextStyle(
      fontSize,
      FontManager.w500Medium,
      color,
      fontStyle: fontStyle,
      textStyleStatus: textStyleStatus,
    );
  }
}

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color? color, {
  required FontStyle fontStyle,
  String fontFamily = FontManager.primaryFontFamily,
  List<Shadow>? shadows,
  TextStyleStatus textStyleStatus = TextStyleStatus.simple,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    color: color ?? kOnPrimaryColor,
    shadows: shadows,
    decoration: textStyleStatus == TextStyleStatus.underline
        ? TextDecoration.underline
        : TextDecoration.none,
  );
}
