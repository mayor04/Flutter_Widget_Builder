import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/features/bloc/overlay/app_overlay_cubit.dart';
import 'package:flutter_widget_builder/features/view/overlay/add_widget_overlay.dart';

class AppOverlayView extends StatefulWidget {
  final Widget child;
  const AppOverlayView({Key? key, required this.child}) : super(key: key);

  @override
  State<AppOverlayView> createState() => _AppOverlayViewState();
}

class _AppOverlayViewState extends State<AppOverlayView> {
  OverlayEntry? addWidgetEntry;
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

        if (state is RemoveAppOverlay) {
          removeAddEntry();
        }
      },
      child: widget.child,
    );
  }

  showSelectionOverlay(AppOverlaySelection state) {
    selectionWidgetEntry?.remove();
    selectionWidgetEntry = null;

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

  showAddWidgetOverlay(AppOverlayAddState state) {
    addWidgetEntry?.remove();
    addWidgetEntry = null;

    addWidgetEntry = OverlayEntry(builder: (context) {
      return GestureDetector(
        onTap: () {
          addWidgetEntry?.remove();
          addWidgetEntry = null;
        },
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                top: state.position.dy - 3,
                left: state.position.dx + 20,
                child: Container(
                  height: 30,
                  width: 30,
                  color: AppColors.appDark,
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: state.position.dx + 35,
                child: Align(
                  alignment: Alignment(
                    0,
                    state.position.dy / context.screenHeight,
                  ),
                  child: AddWidgetOverlay(
                    parentType: state.parentType,
                    parentId: state.parentId,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });

    Overlay.of(context)?.insert(addWidgetEntry!);
  }

  removeAddEntry() {
    addWidgetEntry?.remove();
    addWidgetEntry = null;
  }
}
