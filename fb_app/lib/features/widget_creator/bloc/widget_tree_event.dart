part of 'widget_tree_bloc.dart';

abstract class WidgetTreeEvent extends Equatable {
  const WidgetTreeEvent();

  @override
  List<Object> get props => [];
}

class InitialWidgetTreeEvent extends WidgetTreeEvent {}

class AddWidgetEvent extends WidgetTreeEvent {
  final String parentId;
  final FbWidgetType fbWidgetType;

  const AddWidgetEvent(this.parentId, this.fbWidgetType);
}

class WrapWidgetEvent extends WidgetTreeEvent {
  final String childId;
  final FbWidgetType fbWidgetType;

  const WrapWidgetEvent(this.childId, this.fbWidgetType);
}

class RemoveWidgetEvent extends WidgetTreeEvent {
  final String id;

  const RemoveWidgetEvent(this.id);
}

class DeleteWidgetEvent extends WidgetTreeEvent {
  final String id;

  const DeleteWidgetEvent(this.id);
}
