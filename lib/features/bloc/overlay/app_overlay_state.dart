part of 'app_overlay_cubit.dart';

abstract class AppOverlayState {
  const AppOverlayState();
}

class AppOverlayInitial extends AppOverlayState {}

class AppOverlayAddState extends AppOverlayState {
  final Offset position;
  final FbWidgetType parentType;
  final int parentId;

  const AppOverlayAddState({
    required this.position,
    required this.parentType,
    required this.parentId,
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

class RemoveAppOverlay extends AppOverlayState {}
