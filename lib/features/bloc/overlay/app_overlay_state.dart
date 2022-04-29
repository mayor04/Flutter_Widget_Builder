part of 'app_overlay_cubit.dart';

abstract class AppOverlayState {
  const AppOverlayState();
}

class AppOverlayInitial extends AppOverlayState {}

enum AddWidgetType { add, wrap }

class AppOverlayAddState extends AppOverlayState {
  final Offset position;
  final FbWidgetType widgetType;
  final int widgetId;
  final AddWidgetType addWidgetType;

  const AppOverlayAddState({
    required this.position,
    required this.widgetType,
    required this.widgetId,
    required this.addWidgetType,
  });
}

class AppOverlayMenu extends AppOverlayState {
  final Offset position;
  final FbWidgetType widgetType;
  final int widgetId;

  const AppOverlayMenu({
    required this.position,
    required this.widgetType,
    required this.widgetId,
  });
}

class AppOverlaySelection extends AppOverlayState {
  final Offset position;
  final FbWidgetType widgetType;
  final Size size;
  final int parentId;

  const AppOverlaySelection({
    required this.position,
    required this.widgetType,
    required this.parentId,
    required this.size,
  });
}

class AppOverlayColorPicker extends AppOverlayState {
  final Offset position;
  final Function(Color color) onColorChanged;
  final Color initialColor;

  const AppOverlayColorPicker({
    required this.position,
    required this.onColorChanged,
    required this.initialColor,
  });
}

class RemoveAppOverlay extends AppOverlayState {}
