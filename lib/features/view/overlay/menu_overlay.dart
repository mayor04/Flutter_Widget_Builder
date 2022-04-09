import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';

class MenuOverlay extends StatelessWidget {
  const MenuOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      padding: const EdgeInsets.fromLTRB(13, 10, 13, 10),
      decoration: AppDecoration.darkBorder(
        color: AppColors.appGrey,
        borderWidth: 3,
        radius: 3,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _MenuItem(text: 'Wrap With'),
          _MenuItem(text: 'Add'),
          _MenuItem(text: 'Remove'),
          Divider(color: Colors.white10, height: 15),
          _MenuItem(text: 'Copy'),
          _MenuItem(text: 'Cut'),
          _MenuItem(text: 'Paste as Child'),
          Divider(color: Colors.white10, height: 15),
          _MenuItem(text: 'Delete'),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String text;
  const _MenuItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: () {},
        hoverColor: Colors.white10,
        borderRadius: BorderRadius.circular(3),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(10, 14, 0, 14),
          child: Text(
            text,
            style: context.textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
