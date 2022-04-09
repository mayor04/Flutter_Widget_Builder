import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/features/bloc/overlay/app_overlay_cubit.dart';
import 'package:flutter_widget_builder/features/view/overlay/add_widget_overlay.dart';
import 'package:flutter_widget_builder/features/view/overlay/menu_overlay.dart';

class AppOverlayView extends StatefulWidget {
  final Widget child;
  const AppOverlayView({Key? key, required this.child}) : super(key: key);

  @override
  State<AppOverlayView> createState() => _AppOverlayViewState();
}

class _AppOverlayViewState extends State<AppOverlayView> {
  OverlayEntry? addWidgetEntry;
  OverlayEntry? menuWidgetEntry;
  OverlayEntry? selectionWidgetEntry;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppOverlayCubit, AppOverlayState>(
      listener: (context, state) {
        if (state is AppOverlayAddState) {
          showAddWidgetOverlay(state);
        }

        if (state is AppOverlaySelection) {
          showSelectionOverlay(state);
        }

        if (state is AppOverlayMenu) {
          showMenuOverlay(state);
        }

        if (state is RemoveAppOverlay) {
          removeAddEntry();
          removeSelectionEntry();
          removeMenuEntry();
        }
      },
      child: widget.child,
    );
  }

  removeAddEntry() {
    addWidgetEntry?.remove();
    addWidgetEntry = null;
  }

  removeSelectionEntry() {
    selectionWidgetEntry?.remove();
    selectionWidgetEntry = null;
  }

  removeMenuEntry() {
    menuWidgetEntry?.remove();
    menuWidgetEntry = null;
  }

  showAddWidgetOverlay(AppOverlayAddState state) {
    removeAddEntry();

    addWidgetEntry = OverlayEntry(builder: (context) {
      return _DialogOverlay(
        position: state.position,
        onTap: removeAddEntry,
        dialog: AddWidgetOverlay(
          parentType: state.parentType,
          parentId: state.parentId,
        ),
      );
    });

    Overlay.of(context)?.insert(addWidgetEntry!);
  }

  showMenuOverlay(AppOverlayMenu state) {
    removeMenuEntry();

    menuWidgetEntry = OverlayEntry(builder: (context) {
      return _DialogOverlay(
        position: state.position,
        onTap: removeMenuEntry,
        dialog: const MenuOverlay(),
      );
    });

    Overlay.of(context)?.insert(menuWidgetEntry!);
  }

  showSelectionOverlay(AppOverlaySelection state) {
    removeSelectionEntry();

    selectionWidgetEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: state.position.dy,
          left: state.position.dx,
          child: IgnorePointer(
            child: Container(
              height: state.size.height,
              width: state.size.width,
              decoration: AppDecoration.lightBorder(
                borderColor: AppColors.focusedBorder,
                borderWidth: 2,
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context)?.insert(selectionWidgetEntry!);
  }
}

class _DialogOverlay extends StatelessWidget {
  final VoidCallback onTap;
  final Widget dialog;
  final Offset position;

  const _DialogOverlay({
    Key? key,
    required this.onTap,
    required this.dialog,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              top: position.dy - 3,
              left: position.dx + 20,
              child: Container(
                height: 30,
                width: 30,
                color: AppColors.appDark,
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: position.dx + 35,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                alignment: Alignment(
                  0,
                  getYAxisAlign(context),
                ),
                child: dialog,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getYAxisAlign(BuildContext context) {
    double align = (position.dy) / context.screenHeight;

    //The align is from 0 - 1 so we need to convert to -1 to 1
    double convertedAlign = (align - 0.5) * 2;
    return convertedAlign;
  }
}
