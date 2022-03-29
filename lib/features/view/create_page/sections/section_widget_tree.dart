import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_details.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/bloc/notifier/notifier_cubit.dart';
import 'package:flutter_widget_builder/features/bloc/overlay/app_overlay_cubit.dart';
import 'package:flutter_widget_builder/features/bloc/widget_tree/widget_tree_bloc.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_column_config.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_container_config.dart';
import 'package:flutter_widget_builder/features/view/create_page/widgets/icon_box.dart';
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
            decoration: AppDecoration.radius(color: AppColors.appGrey),
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
                      decoration: AppDecoration.radius(
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
              primary: false,
              padding: const EdgeInsets.fromLTRB(9, 30, 9, 100),
              child: BlocBuilder<WidgetTreeBloc, WidgetTreeState>(
                builder: (context, state) {
                  var parentFbData = state.firstWidgetDetails;
                  if (parentFbData == null) {
                    //You can return an add buttom first
                    return Container();
                  }

                  return WidgetTypeItem(
                    allWidgetDetails: state.fbDetailsMap,
                    widgetDetails: parentFbData,
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
  final Map<int, FbWidgetDetails> allWidgetDetails;
  final FbWidgetDetails widgetDetails;

  const WidgetTypeItem({
    Key? key,
    required this.allWidgetDetails,
    required this.widgetDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < widgetDetails.children.length; i++) {
      var childData = getChildDetails(i);
      if (childData == null) {
        AppLog.info(
          'WidgetTypeItem',
          'Child index $i is not present in $FbWidgetDetails',
        );
        continue;
      }

      children.add(
        WidgetTypeItem(
          allWidgetDetails: allWidgetDetails,
          widgetDetails: childData,
        ),
      );
    }

    return Stack(
      children: [
        Positioned(
          left: 3,
          right: 0,
          bottom: 1.5,
          top: 4,
          child: Container(
            // height: 1,
            decoration: AppDecoration.radius(
              color: (widgetDetails.childType != FbChildType.multiple)
                  ? AppColors.appGrey.withOpacity(0.6)
                  : AppColors.appDark,
              radius: 1,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _FbWidgetBox(details: widgetDetails),
            if (widgetDetails.children.isEmpty)
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
          bottom: 1.5,
          child: Container(
            width: 1,
            color: AppColors.lightBorder,
          ),
        ),
        if (widgetDetails.childType == FbChildType.multiple)
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

  FbWidgetDetails? getChildDetails(int index) {
    return allWidgetDetails[widgetDetails.children[index]];
  }
}

class _FbWidgetBox extends StatelessWidget {
  final FbWidgetDetails details;
  const _FbWidgetBox({
    Key? key,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotifierCubit, NotifierState>(
      buildWhen: (prev, current) {
        return current is NotifierSelected;
      },
      builder: (context, state) {
        Color? borderColor = AppColors.lightBorder;

        if (state is NotifierSelected) {
          if (state.id == details.id) {
            borderColor = AppColors.focusedBorder;
          }
        }

        return GestureDetector(
          onTap: () {
            context.read<NotifierCubit>().select(details.id);
          },
          child: Container(
            height: 35,
            margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
            padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
            decoration: AppDecoration.lightBorder(
              color: AppColors.appGrey,
              borderColor: borderColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  details.name,
                  style: context.textTheme.bodyMedium,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // const IconBox(
                    //   tooltip: 'Wrap - Ctrl W',
                    //   icon: Icon(Icons.wrap_text),
                    // ),
                    const Box.horizontal(15),
                    GestureDetector(
                      onTapUp: (tapDetails) {
                        context
                            .read<AppOverlayCubit>()
                            .showAddWidgetListOverlay(
                              position: tapDetails.globalPosition -
                                  tapDetails.localPosition,
                              parentType: details.widgetType,
                              parentId: details.id,
                            );
                      },
                      child: const IconBox(
                        tooltip: 'Add - Ctrl A',
                        icon: Icon(Icons.add),
                      ),
                    ),
                    const Box.horizontal(20),
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
