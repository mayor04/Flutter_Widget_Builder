import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';

class IconBox extends StatelessWidget {
  final Widget icon;
  final bool filled;
  final String tooltip;

  const IconBox({
    Key? key,
    required this.icon,
    this.filled = false,
    this.tooltip = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        decoration: filled ? RadiusDecoration(color: AppColors.iconBox) : null,
        child: icon,
      ),
    );
  }
}
