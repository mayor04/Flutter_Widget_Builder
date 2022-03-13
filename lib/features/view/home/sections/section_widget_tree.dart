import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/enum/fb_enum.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/bloc/notifier/notifier_cubit.dart';
import 'package:flutter_widget_builder/features/bloc/widget_tree/widget_tree_bloc.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_data.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_column.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_container.dart';
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
            height: 80,
            decoration: RadiusDecoration(),
            child: Column(
              children: [
                // >>>logo
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 23,
                      width: 60,
                      margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      decoration: RadiusDecoration(
                        color: AppColors.appGrey,
                      ),
                    ),
                  ),
                ),
                // >>>tabs
                Expanded(
                  flex: 5,
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(9, 30, 9, 100),
              child: BlocBuilder<WidgetTreeBloc, WidgetTreeState>(
                builder: (context, state) {
                  var parentFbData = state.firstWidgetData;
                  if (parentFbData == null) {
                    //You can return an add buttom first
                    return Container();
                  }

                  return WidgetTypeItem(
                    fbDataMap: state.fbDataMap,
                    data: parentFbData,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

///TODO: this might not be the best way to solve this
///This is more like a nested widget that keeps
///nesting children recurssively till they are none left
class WidgetTypeItem extends StatelessWidget {
  final Map<int, FbData> fbDataMap;
  final FbData data;

  const WidgetTypeItem({
    Key? key,
    required this.fbDataMap,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < data.children.length; i++) {
      var childData = getChildData(i);
      if (childData == null) {
        AppLog.info(
          'WidgetTypeItem',
          'Child index $i is not present in $FbData',
        );
        continue;
      }

      children.add(
        WidgetTypeItem(
          fbDataMap: fbDataMap,
          data: childData,
        ),
      );
    }

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _FbWidgetBox(data: data),
            if (data.children.isEmpty)
              Container()
            else
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 3, 0, 3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                ),
              )
          ],
        ),
        Positioned(
          left: 3,
          top: 37,
          bottom: 2,
          child: Container(
            width: 1,
            color: AppColors.lightBorder,
          ),
        ),
        if (data.childType == FbChildType.multiple)
          Positioned(
            left: 3,
            right: 0,
            bottom: 0,
            child: Container(
              height: 1,
              color: AppColors.lightBorder,
            ),
          )
      ],
    );
  }

  FbData? getChildData(int index) {
    return fbDataMap[data.children[index]];
  }
}

class _FbWidgetBox extends StatelessWidget {
  final FbData data;
  const _FbWidgetBox({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NotifierCubit, NotifierState, NotifierSelected>(
      selector: (state) {
        return state as NotifierSelected;
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<NotifierCubit>().select(data.id);
          },
          child: Container(
            height: 35,
            margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
            padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
            decoration: LightBorderDecoration(
              borderColor: state.id == data.id
                  ? AppColors.focusedBorder
                  : AppColors.lightBorder,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.name,
                  style: context.textTheme.bodyMedium,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const IconBox(
                      tooltip: 'Wrap - Ctrl W',
                      icon: Icon(Icons.wrap_text),
                    ),
                    const Box.horizontal(15),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<WidgetTreeBloc>()
                            .add(AddWidgetEvent(data.id, FbContainerConfig()));
                      },
                      child: const IconBox(
                        tooltip: 'Add - Ctrl A',
                        icon: Icon(Icons.add),
                      ),
                    ),
                    const Box.horizontal(15),
                    const IconBox(
                      filled: true,
                      icon: Icon(Icons.more_horiz),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
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
