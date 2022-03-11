part of 'widget_tree_bloc.dart';

abstract class WidgetTreeEvent extends Equatable {
  const WidgetTreeEvent();

  @override
  List<Object> get props => [];
}

class InitialWidgetTreeEvent extends WidgetTreeEvent {}

class AddWidgetEvent extends WidgetTreeEvent {
  final int parentId;
  final FbWidget fbWidget;

  const AddWidgetEvent(this.parentId, this.fbWidget);
}

class RemoveWidgetEvent extends WidgetTreeEvent {
  final int id;

  const RemoveWidgetEvent(this.id);
}

class WrapWidgetEvent extends WidgetTreeEvent {
  final int id;

  const WrapWidgetEvent(this.id);
}
