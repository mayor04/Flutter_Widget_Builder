import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';

///Color is specified to default `AppColors.appGrey`
class LightBorderDecoration extends BoxDecoration {
  LightBorderDecoration({Color? color = AppColors.appGrey})
      : super(
          color: color,
          border: Border.all(color: AppColors.lightBorder),
          borderRadius: BorderRadius.circular(2),
        );
}

///Color is specified to default `AppColors.appGrey`
class DarkBorderDecoration extends BoxDecoration {
  DarkBorderDecoration({
    Color? color = AppColors.appGrey,
    Color borderColor = AppColors.darkBorder,
  }) : super(
          color: color,
          border: Border.all(color: AppColors.darkBorder),
          borderRadius: BorderRadius.circular(2),
        );

  DarkBorderDecoration.soft({Color? color = AppColors.appGrey})
      : super(
          color: color,
          border: Border.all(color: AppColors.darkBorder, width: 0.4),
          borderRadius: BorderRadius.circular(2),
        );
}

///Color is specified to default `AppColors.appGrey`
class RadiusDecoration extends BoxDecoration {
  RadiusDecoration({Color? color = AppColors.appGrey, double radius = 2})
      : super(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        );
}
