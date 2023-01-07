part of 'notifier_bloc.dart';

abstract class NotifierState extends Equatable {
  const NotifierState();

  @override
  List<Object> get props => [];
}

class NotifierInitial extends NotifierState {}

class NotifierSelected extends NotifierState {
  final String id;
  const NotifierSelected(this.id);

  @override
  List<Object> get props => [id];
}

class NotifierStyleChanged extends NotifierState {
  final String id;
  const NotifierStyleChanged(this.id);

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => runtimeType.hashCode;
}
