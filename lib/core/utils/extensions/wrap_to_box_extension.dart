import 'package:flutter/material.dart';

extension WrapToBoxExtension on Widget {
  DecoratedBox wrapToRectangleBox({
    required EdgeInsetsGeometry padding,
    required BorderRadiusGeometry borderRadius,
    Color? color,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: borderRadius, color: color),
      child: Padding(padding: padding, child: this),
    );
  }

  DecoratedBox wrapToCircleBox({
    required EdgeInsetsGeometry padding,
    Color? color,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(shape: .circle, color: color),
      child: Padding(padding: padding, child: this),
    );
  }

  DecoratedBox wrapToRectangleBoxWithSymmetricPadding({
    required double vertical,
    required double horizontal,
    required BorderRadiusGeometry borderRadius,
    Color? color,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: borderRadius, color: color),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      ),
    );
  }

  DecoratedBox wrapToCircleBoxWithSymmetricPadding({
    required double vertical,
    required double horizontal,
    Color? color,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(shape: .circle, color: color),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      ),
    );
  }

  DecoratedBox wrapToRectangleBoxWithOnlyPadding({
    required double right,
    required double left,
    required double top,
    required double bottom,
    required BorderRadiusGeometry borderRadius,
    Color? color,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: borderRadius, color: color),
      child: Padding(
        padding: EdgeInsetsGeometry.only(
          right: right,
          left: left,
          top: top,
          bottom: bottom,
        ),
        child: this,
      ),
    );
  }

  DecoratedBox wrapToCircleBoxWithOnlyPadding({
    required double right,
    required double left,
    required double top,
    required double bottom,
    Color? color,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(shape: .circle, color: color),
      child: Padding(
        padding: EdgeInsetsGeometry.only(
          right: right,
          left: left,
          top: top,
          bottom: bottom,
        ),
        child: this,
      ),
    );
  }
}
