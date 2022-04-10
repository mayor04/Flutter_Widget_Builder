part of 'widget_tree_bloc.dart';

abstract class WidgetTreeEvent extends Equatable {
  const WidgetTreeEvent();

  @override
  List<Object> get props => [];
}

class InitialWidgetTreeEvent extends WidgetTreeEvent {}

class AddWidgetEvent extends WidgetTreeEvent {
  final int parentId;
  final BaseFbConfig fbWidget;

  const AddWidgetEvent(this.parentId, this.fbWidget);
}

class WrapWidgetEvent extends WidgetTreeEvent {
  final int childId;
  final BaseFbConfig fbWidget;

  const WrapWidgetEvent(this.childId, this.fbWidget);
}

class RemoveWidgetEvent extends WidgetTreeEvent {
  final int id;

  const RemoveWidgetEvent(this.id);
}

class DeleteWidgetEvent extends WidgetTreeEvent {
  final int id;

  const DeleteWidgetEvent(this.id);
}
