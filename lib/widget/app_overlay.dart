import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

typedef OverlayCallback = Function(BuildContext context,
    {required Offset position, required Widget overlay});

class AppOverlayWidget extends StatefulWidget {
  const AppOverlayWidget({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  State<AppOverlayWidget> createState() => _AppOverlayWidgetState();
}

class _AppOverlayWidgetState extends State<AppOverlayWidget> {
  OverlayEntry? addWidgetEntry;
  OverlayEntry? menuWidgetEntry;
  OverlayEntry? selectionWidgetEntry;

  void removeAddEntry() {
    addWidgetEntry?.remove();
    addWidgetEntry = null;
  }

  void removeSelectionEntry() {
    selectionWidgetEntry?.remove();
    selectionWidgetEntry = null;
  }

  void removeMenuEntry() {
    menuWidgetEntry?.remove();
    menuWidgetEntry = null;
  }

  void removeAll() {
    removeAddEntry();
    removeMenuEntry();
    removeSelectionEntry();
  }

  void showMenuOverlay(BuildContext context, {required Offset position, required Widget overlay}) {
    removeMenuEntry();

    menuWidgetEntry = OverlayEntry(builder: (context) {
      return _DialogOverlay(
        position: position,
        onTap: removeMenuEntry,
        dialog: overlay,
      );
    });

    Overlay.of(context)?.insert(menuWidgetEntry!);
  }

  void showAddWidgetOverlay(BuildContext context,
      {required Offset position, required Widget overlay}) {
    removeAddEntry();

    addWidgetEntry = OverlayEntry(builder: (context) {
      return _DialogOverlay(
        position: position,
        onTap: removeAddEntry,
        dialog: overlay,
      );
    });

    Overlay.of(context)?.insert(addWidgetEntry!);
  }

  void showSelectionOverlay(
    BuildContext context, {
    required Offset position,
    required Size size,
  }) {
    removeSelectionEntry();

    selectionWidgetEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: position.dy,
          left: position.dx,
          child: IgnorePointer(
            child: Container(
              height: size.height,
              width: size.width,
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

  @override
  Widget build(BuildContext context) {
    return AppOverlay(
      showMenuOverlay: showMenuOverlay,
      showAddWidgetMenuOverlay: showAddWidgetOverlay,
      showWidgetSelectionOverlay: showSelectionOverlay,
      removeAllOverlay: removeAll,
      child: widget.child,
    );
  }
}

class AppOverlay extends InheritedWidget {
  const AppOverlay({
    required this.removeAllOverlay,
    required this.showMenuOverlay,
    required Widget child,
    required this.showAddWidgetMenuOverlay,
    required this.showWidgetSelectionOverlay,
    Key? key,
  }) : super(child: child, key: key);

  final VoidCallback removeAllOverlay;

  final OverlayCallback showMenuOverlay;
  final OverlayCallback showAddWidgetMenuOverlay;

  final Function(
    BuildContext context, {
    required Offset position,
    required Size size,
  }) showWidgetSelectionOverlay;

  static AppOverlay _of(BuildContext context) {
    final overlay = context.dependOnInheritedWidgetOfExactType<AppOverlay>();
    if (overlay == null) {
      throw (Exception('Could not find type of app overlay'));
    }

    return overlay;
  }

  static void showMenu(
    BuildContext context, {
    required Offset position,
    required Widget overlay,
  }) {
    AppOverlay._of(context).showMenuOverlay(
      context,
      position: position,
      overlay: overlay,
    );
  }

  static void showAddWidgetMenu(
    BuildContext context, {
    required Offset position,
    required Widget overlay,
  }) {
    AppOverlay._of(context).showAddWidgetMenuOverlay(
      context,
      position: position,
      overlay: overlay,
    );
  }

  static void showWidgetSelection(
    BuildContext context, {
    required Offset position,
    required Size size,
  }) {
    AppOverlay._of(context).showWidgetSelectionOverlay(
      context,
      position: position,
      size: size,
    );
  }

  static void removeAll(BuildContext context) {
    AppOverlay._of(context).removeAllOverlay();
  }

  @override
  bool updateShouldNotify(covariant AppOverlay oldWidget) {
    return oldWidget.showMenuOverlay != showMenuOverlay;
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
