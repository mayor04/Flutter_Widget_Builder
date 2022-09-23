import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/features/view/overlay/add_widget_overlay.dart';
import 'package:flutter_widget_builder/features/view/overlay/app_overlay.dart';
import 'package:flutter_widget_builder/features/widget_creator/bloc/widget_tree_bloc.dart';
import 'package:flutter_widget_builder/utils/enum.dart';

class MenuOverlay extends StatelessWidget {
  final FbWidgetType widgetType;
  final int widgetId;

  const MenuOverlay({
    Key? key,
    required this.widgetType,
    required this.widgetId,
  }) : super(key: key);

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
        children: [
          _MenuItem(
            text: 'Wrap With',
            onTap: (tapDetails) {
              final position =
                  (tapDetails.globalPosition - tapDetails.localPosition) + const Offset(135, 5);

              AppOverlay.showAddWidgetMenu(
                context,
                position: position,
                overlay: AddWidgetOverlay(
                  widgetType: widgetType,
                  widgetId: widgetId,
                  addOrWrap: AddWidgetType.wrap,
                ),
              );
            },
          ),
          _MenuItem(
            text: 'Add',
            onTap: (tapDetails) {
              final position =
                  (tapDetails.globalPosition - tapDetails.localPosition) + const Offset(135, 5);

              AppOverlay.showAddWidgetMenu(
                context,
                position: position,
                overlay: AddWidgetOverlay(
                  widgetType: widgetType,
                  widgetId: widgetId,
                  addOrWrap: AddWidgetType.add,
                ),
              );
            },
          ),
          _MenuItem(
            text: 'Remove',
            onTap: (tapDetails) {
              AppOverlay.removeAll(context);
              context.read<WidgetTreeBloc>().add(RemoveWidgetEvent(widgetId));
            },
          ),
          const Divider(color: Colors.white10, height: 15),
          _MenuItem(
            text: 'Copy',
            onTap: (tapDetails) {},
          ),
          _MenuItem(
            text: 'Cut',
            onTap: (tapDetails) {},
          ),
          _MenuItem(
            text: 'Paste as Child',
            onTap: (tapDetails) {},
          ),
          const Divider(color: Colors.white10, height: 15),
          _MenuItem(
            text: 'Delete',
            onTap: (tapDetails) {},
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String text;
  final Function(TapDownDetails details)? onTap;

  const _MenuItem({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: () {},
        onTapDown: onTap,
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
