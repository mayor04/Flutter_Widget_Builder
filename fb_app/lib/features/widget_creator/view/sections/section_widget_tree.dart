import 'package:fb_app/features/widget_creator/bloc/notifier_bloc.dart';
import 'package:fb_app/features/widget_creator/bloc/widget_tree_bloc.dart';
import 'package:fb_app/features/widget_creator/models/fb_details.dart';
import 'package:fb_app/features/widget_creator/view/overlays/add_widget_overlay.dart';
import 'package:fb_app/features/widget_creator/view/overlays/menu_overlay.dart';
import 'package:fb_app/features/widget_creator/view/widgets/icon_box.dart';
import 'package:fb_app/utils/enum.dart';
import 'package:fb_app/widget/box_spacing.dart';
import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:fb_core/src/widgets/app_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                // * @logo
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
                // * @tabs
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
              child: BlocConsumer<WidgetTreeBloc, WidgetTreeState>(
                listener: (context, state) async {
                  await Future.delayed(Duration.zero);

                  if (state.action == WidgetTreeAction.add) {
                    context.read<NotifierBloc>().select(state.widgetId ?? '0');
                  }
                },
                builder: (context, state) {
                  var parentFbData = state.firstWidgetDetails;
                  if (parentFbData == null) {
                    // You can return an add buttom first
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
/// This is more like a nested widget that keeps
/// nesting children recurssively till they are none left
class WidgetTypeItem extends StatelessWidget {
  final Map<String, FbWidgetDetails> allWidgetDetails;
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
        // * @line
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
    return BlocBuilder<NotifierBloc, NotifierState>(
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
            context.read<NotifierBloc>().select(details.id);
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 15,
                      width: 15,
                      child: Placeholder(),
                    ),
                    const Box.horizontal(10),
                    Text(
                      details.name,
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
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
                        AppOverlay.showAddWidgetMenu(
                          context,
                          position: tapDetails.globalPosition - tapDetails.localPosition,
                          overlay: AddWidgetOverlay(
                            widgetType: details.widgetType,
                            widgetId: details.id,
                            addOrWrap: AddWidgetType.add,
                            widgetTreeBloc: context.read<WidgetTreeBloc>(),
                          ),
                        );
                      },
                      child: const IconBox(
                        tooltip: 'Add - Ctrl A',
                        icon: Icon(Icons.add),
                      ),
                    ),
                    const Box.horizontal(20),
                    GestureDetector(
                      onTapUp: (tapDetails) {
                        AppOverlay.showMenu(
                          context,
                          position: tapDetails.globalPosition - tapDetails.localPosition,
                          overlay: MenuOverlay(
                            widgetType: details.widgetType,
                            widgetId: details.id,
                            widgetTreeBloc: context.read<WidgetTreeBloc>(),
                          ),
                        );
                      },
                      child: const IconBox(
                        filled: true,
                        icon: Icon(Icons.more_horiz),
                      ),
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
