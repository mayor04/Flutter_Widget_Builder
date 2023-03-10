import 'package:fb_components/src/widgets/box_spacing.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

class MultipleInputWrap extends StatelessWidget {
  const MultipleInputWrap({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 15, 6, 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
            child: Row(
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Box.vertical(15),
          Container(
            color: AppColors.groupBg,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
