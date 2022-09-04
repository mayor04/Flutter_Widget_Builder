part of 'widget_tree_bloc.dart';

abstract class WidgetTreeEvent extends Equatable {
  const WidgetTreeEvent();

  @override
  List<Object> get props => [];
}

class InitialWidgetTreeEvent extends WidgetTreeEvent {}

class AddWidgetEvent extends WidgetTreeEvent {
  final int parentId;
  final FbWidgetType fbWidgetType;

  const AddWidgetEvent(this.parentId, this.fbWidgetType);
}

class WrapWidgetEvent extends WidgetTreeEvent {
  final int childId;
  final FbWidgetType fbWidgetType;

  const WrapWidgetEvent(this.childId, this.fbWidgetType);
}

class RemoveWidgetEvent extends WidgetTreeEvent {
  final int id;

  const RemoveWidgetEvent(this.id);
}

class DeleteWidgetEvent extends WidgetTreeEvent {
  final int id;

  const DeleteWidgetEvent(this.id);
}
