import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/bloc/widget_list_bloc.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/bloc/widget_tree_bloc.dart';
import 'package:fb_widget_editor/src/utils/enum/add_widget_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddWidgetOverlay extends StatefulWidget {
  final FbWidgetType widgetType;
  final String widgetId;
  final AddWidgetType addOrWrap;
  final WidgetTreeBloc widgetTreeBloc;

  const AddWidgetOverlay({
    Key? key,
    required this.widgetType,
    required this.widgetId,
    required this.addOrWrap,
    required this.widgetTreeBloc,
  }) : super(key: key);

  @override
  State<AddWidgetOverlay> createState() => _AddWidgetOverlayState();
}

class _AddWidgetOverlayState extends State<AddWidgetOverlay> with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    var allWidgets = [...FbWidgetType.values];
    // remove the first one which is main
    allWidgets.removeAt(0);

    return BlocProvider.value(
      value: widget.widgetTreeBloc,
      child: Material(
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
                const SizedBox(height: 22),
                TabBar(
                  controller: tabController,
                  onTap: (value) => setState(() {}),
                  tabs: [
                    Tab(
                      child: Text(
                        'All Widgets',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Your Widgets',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: tabController.index == 0
                      ? SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 22),
                          child: Wrap(
                            spacing: 17,
                            runSpacing: 22,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: List.generate(allWidgets.length, (index) {
                              return _WidgetItem(
                                type: allWidgets[index],
                                parentId: widget.widgetId,
                                addOrWrap: widget.addOrWrap,
                              );
                            }),
                          ))
                      : const _YourWidgetTab(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _YourWidgetTab extends StatelessWidget {
  const _YourWidgetTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetListBloc, WidgetListState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 22),
          child: GridView.builder(
            itemCount: state.fileList.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              mainAxisExtent: 100,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              final file = state.fileList[index];

              return InkWell(
                onTap: () {},
                child: Container(
                  decoration: AppDecoration.lightBorder(
                    color: AppColors.appGreyDark,
                    borderWidth: 0.7,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 50,
                        child: Placeholder(),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        file.name,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _WidgetItem extends StatelessWidget {
  final FbWidgetType type;
  final String parentId;
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
        AppOverlay.removeAll(context);

        //TODO: use transformers to prevent double click before close
        var treeBloc = context.read<WidgetTreeBloc>();

        if (addOrWrap == AddWidgetType.add) {
          treeBloc.add(AddWidgetEvent(parentId, type));
        } else if (addOrWrap == AddWidgetType.wrap) {
          treeBloc.add(WrapWidgetEvent(parentId, type));
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
            const SizedBox(width: 10),
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
