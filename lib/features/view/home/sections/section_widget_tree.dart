import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/features/view/home/widgets/icon_box.dart';
import 'package:flutter_widget_builder/widget/box_spacing.dart';

class SectionWidgetTree extends StatelessWidget {
  const SectionWidgetTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: AppColors.appDark,
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: DarkBorderDecoration(),
            child: Column(
              children: [
                // >>>logo
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 23,
                      width: 60,
                      margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      decoration: RadiusDecoration(
                        color: AppColors.appBlue,
                      ),
                    ),
                  ),
                ),
                // >>>tabs
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _Tabs('Widget tree', index: 0),
                        _Tabs('Code', index: 1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              itemExtent: 40,
              padding: const EdgeInsets.fromLTRB(9, 30, 9, 0),
              children: const [
                WidgetTypeItem(),
                WidgetTypeItem(),
                WidgetTypeItem(),
                WidgetTypeItem(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class WidgetTypeItem extends StatelessWidget {
  const WidgetTypeItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 35,
        padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
        decoration: LightBorderDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Container',
              style: context.textTheme.bodyMedium,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                IconBox(
                  tooltip: 'Wrap - Ctrl W',
                  icon: Icon(Icons.wrap_text),
                ),
                Box.horizontal(15),
                IconBox(
                  tooltip: 'Add - Ctrl A',
                  icon: Icon(Icons.add),
                ),
                Box.horizontal(15),
                IconBox(
                  filled: true,
                  icon: Icon(Icons.more_horiz),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  final String tabTitle;
  final int selected;
  final int index;

  const _Tabs(
    this.tabTitle, {
    Key? key,
    this.selected = 0,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 120,
      color: selected == index ? AppColors.appDark : Colors.transparent,
      alignment: Alignment.center,
      child: Text(
        tabTitle,
        style: context.textTheme.bodyMedium,
      ),
    );
  }
}

// class IconBox extends StatelessWidget {
//   final Widget icon;
//   const IconBox({Key? key, required this.icon}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
//       decoration: RadiusDecoration(color: AppColors.iconBox),
//       child: icon,
//     );
//   }
// }
