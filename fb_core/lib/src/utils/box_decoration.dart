import 'package:fb_core/src/constant/colors.dart';
import 'package:flutter/material.dart';

class AppDecoration {
  static BoxDecoration radius({
    Color? color,
    double? radius = 2.0,
  }) {
    return CustomDecoration(
      color: color,
      radius: radius,
    );
  }

  static BoxDecoration lightBorder({
    Color? color,
    Color? borderColor = AppColors.lightBorder,
    double? radius = 2.0,
    double? borderWidth = 1.0,
  }) {
    return CustomDecoration(
      color: color,
      radius: radius,
      borderWidth: borderWidth,
      borderColor: borderColor,
    );
  }

  static BoxDecoration darkBorder({
    Color? color,
    Color borderColor = AppColors.darkBorder,
    double? radius = 2.0,
    double? borderWidth = 1.0,
  }) {
    return CustomDecoration(
      color: color,
      radius: radius,
      borderWidth: borderWidth,
      borderColor: borderColor,
    );
  }
}

///Custom decoration is created to ease creating decoration
class CustomDecoration extends BoxDecoration {
  CustomDecoration({
    Color? color,
    double? radius,
    List<double>? unevenRadius,
    double? borderWidth,
    Color? borderColor,
    bool? circular,
    DecorationImage? image,
    BoxConstraints? constraints,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
  }) : super(
          color: color,
          image: image,
          boxShadow: boxShadow,
          gradient: gradient,
          border: borderWidth == null && borderColor == null
              ? null
              : Border.all(
                  width: borderWidth ?? 0,
                  color: borderColor ?? Colors.transparent,
                ),
          borderRadius: () {
            BorderRadius? borderRadius;
            final uneven = unevenRadius ?? [];

            if (unevenRadius == null) {
              borderRadius = circular == null
                  ? BorderRadius.circular(radius ?? 0)
                  : BorderRadius.all(Radius.elliptical(radius ?? 0, radius ?? 0));
            } else {
              if (uneven.length == 4) {
                borderRadius = BorderRadius.only(
                  topLeft: Radius.circular(uneven[0]),
                  topRight: Radius.circular(uneven[1]),
                  bottomRight: Radius.circular(uneven[2]),
                  bottomLeft: Radius.circular(uneven[3]),
                );
              }
            }
            return borderRadius;
          }(),
        );
}



///Color is specified to default `AppColors.appGrey`
// class LightBorderDecoration extends BoxDecoration {
//   final Color? borderColor;
//   LightBorderDecoration({Color? color = AppColors.appGrey, this.borderColor})
//       : super(
//           color: color,
//           border: Border.all(color: borderColor ?? AppColors.lightBorder),
//           borderRadius: BorderRadius.circular(2),
//         );
// }

///Color is specified to default `AppColors.appGrey`
// class DarkBorderDecoration extends BoxDecoration {
//   DarkBorderDecoration({
//     Color? color = AppColors.appGrey,
//     Color borderColor = AppColors.darkBorder,
//   }) : super(
//           color: color,
//           border: Border.all(color: AppColors.darkBorder),
//           borderRadius: BorderRadius.circular(2),
//         );

//   DarkBorderDecoration.soft({Color? color = AppColors.appGrey})
//       : super(
//           color: color,
//           border: Border.all(color: AppColors.darkBorder, width: 0.4),
//           borderRadius: BorderRadius.circular(2),
//         );
// }

///Color is specified to default `AppColors.appGrey`
// class RadiusDecoration extends BoxDecoration {
//   RadiusDecoration({Color? color = AppColors.appGrey, double radius = 2})
//       : super(
//           color: color,
//           borderRadius: BorderRadius.circular(radius),
//         );
// }