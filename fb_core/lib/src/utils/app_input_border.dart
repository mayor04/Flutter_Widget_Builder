import 'package:fb_core/src/constant/colors.dart';
import 'package:flutter/material.dart';

class AppInputBorder {
  static InputBorder defaultBorder() {
    return _base(
      width: 2,
      radius: 1,
      color: AppColors.inputBorder,
    );
  }

  static InputBorder border({
    Color? borderColor = AppColors.inputBorder,
    double? radius = 2,
    double? borderWidth = 1,
  }) {
    return _base(
      color: borderColor,
      width: borderWidth,
      radius: radius,
    );
  }

  ///Radius doesn't include border if you want to apply
  ///border use `AppInputBorder.border` instead
  static InputBorder radius(double radius) {
    return _base(
      width: 0,
      radius: radius,
    );
  }

  static InputBorder _base({Color? color, double? radius, double? width}) {
    width ??= 0;
    color ??= Colors.transparent;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 0),
      borderSide: BorderSide(
        color: color,
        width: width,
        style: width == 0 ? BorderStyle.none : BorderStyle.solid,
      ),
    );
  }
}
