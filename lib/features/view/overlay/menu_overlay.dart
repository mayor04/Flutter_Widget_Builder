import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/features/bloc/overlay/app_overlay_cubit.dart';
import 'package:flutter_widget_builder/features/bloc/widget_tree/widget_tree_bloc.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';

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
        borderWidth: 2,
        radius: 3,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MenuItem(
            text: 'Wrap With',
            onTap: (tapDetails) {
              context.read<AppOverlayCubit>().showAddWidgetListOverlay(
                  position:
                      (tapDetails.globalPosition - tapDetails.localPosition) +
                          const Offset(135, 5),
                  widgetType: widgetType,
                  widgetId: widgetId,
                  addWidgetType: AddWidgetType.wrap);
            },
          ),
          _MenuItem(
            text: 'Add',
            onTap: (tapDetails) {
              context.read<AppOverlayCubit>().showAddWidgetListOverlay(
                    position:
                        (tapDetails.globalPosition - tapDetails.localPosition) +
                            const Offset(135, 5),
                    widgetType: widgetType,
                    widgetId: widgetId,
                  );
            },
          ),
          _MenuItem(
            text: 'Remove',
            onTap: (tapDetails) {
              context.read<AppOverlayCubit>().removeOverlay();
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
