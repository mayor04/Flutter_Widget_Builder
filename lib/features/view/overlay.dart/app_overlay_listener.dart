import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/features/bloc/overlay/app_overlay_cubit.dart';

class AppOverlayListener extends StatefulWidget {
  final Widget child;
  const AppOverlayListener({Key? key, required this.child}) : super(key: key);

  @override
  State<AppOverlayListener> createState() => _AppOverlayListenerState();
}

class _AppOverlayListenerState extends State<AppOverlayListener> {
  OverlayEntry? addWidgetEntry;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppOverlayCubit, AppOverlayState>(
      listener: (context, state) {
        if (state is AppOverlayAddState) {
          showAddWidgetOverlay(state);
        }
      },
      child: widget.child,
    );
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
                top: 0,
                left: 0,
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
      );
    });

    Overlay.of(context)?.insert(addWidgetEntry!);
  }

  removePreviousEntry(OverlayEntry? entry) {
    entry?.remove();
    entry = null;
    log('');
  }
}
