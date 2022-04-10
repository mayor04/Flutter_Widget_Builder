import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/app_input_border.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/features/bloc/overlay/app_overlay_cubit.dart';
import 'package:flutter_widget_builder/features/bloc/widget_tree/widget_tree_bloc.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_creator.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/widget/box_spacing.dart';

class AddWidgetOverlay extends StatelessWidget {
  final FbWidgetType widgetType;
  final int widgetId;
  final AddWidgetType addOrWrap;

  const AddWidgetOverlay({
    Key? key,
    required this.widgetType,
    required this.widgetId,
    required this.addOrWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allWidgets = [...FbWidgetType.values];
    //remove the first one which is main
    allWidgets.removeAt(0);

    return Material(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 328,
          height: 566,
          decoration: AppDecoration.lightBorder(
            color: AppColors.appDark,
            borderColor: AppColors.appGrey,
            borderWidth: 3,
          ),
          padding: const EdgeInsets.all(21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    border: AppInputBorder.radius(5),
                    enabledBorder: AppInputBorder.radius(5),
                    fillColor: AppColors.appGrey,
                  ),
                ),
              ),
              const Box.vertical(22),
              Text(
                'Add Child Widget',
                style: context.textTheme.bodyMedium,
              ),
              const Box.vertical(12),
              const Divider(
                color: AppColors.lightBorder,
                thickness: 0.3,
              ),
              const Box.vertical(32),
              Wrap(
                spacing: 17,
                runSpacing: 22,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: List.generate(allWidgets.length, (index) {
                  return _WidgetItem(
                    type: allWidgets[index],
                    parentId: widgetId,
                    addOrWrap: addOrWrap,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WidgetItem extends StatelessWidget {
  final FbWidgetType type;
  final int parentId;
  final AddWidgetType addOrWrap;

  const _WidgetItem({
    Key? key,
    required this.type,
    required this.parentId,
    required this.addOrWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var config = FbConfigCreator.createConfig(type);
        context.read<AppOverlayCubit>().removeOverlay();

        //TODO: use transformers to prevent double click before close
        var treeBloc = context.read<WidgetTreeBloc>();

        if (addOrWrap == AddWidgetType.add) {
          treeBloc.add(AddWidgetEvent(parentId, config));
        } else if (addOrWrap == AddWidgetType.wrap) {
          treeBloc.add(WrapWidgetEvent(parentId, config));
        }
      },
      child: Container(
        height: 90,
        width: 80,
        decoration: AppDecoration.lightBorder(
          color: AppColors.appGreyDark,
          borderWidth: 0.7,
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
              width: 50,
              child: Placeholder(),
            ),
            const Box.vertical(10),
            Text(
              type.name.capitalizeFirst,
              style: context.textTheme.labelMedium?.copyWith(
                color: AppColors.focusedBorder,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
