import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

class IconBox extends StatefulWidget {
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
  State<IconBox> createState() => _IconBoxState();
}

class _IconBoxState extends State<IconBox> {
  Color? hoverColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (pointerEvent) {
        setState(() {
          hoverColor = AppColors.appBlue.withOpacity(0.15);
        });
      },
      onExit: (pointerEvent) {
        setState(() {
          hoverColor = null;
        });
      },
      child: Tooltip(
        message: widget.tooltip,
        child: Container(
          decoration: widget.filled ? AppDecoration.radius(color: AppColors.iconBox) : null,
          child: Container(
            padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
            decoration: AppDecoration.radius(color: hoverColor),
            child: widget.icon,
          ),
        ),
      ),
    );
  }
}
