part of 'notifier_cubit.dart';

abstract class NotifierState extends Equatable {
  const NotifierState();

  @override
  List<Object> get props => [];
}

class NotifierInitial extends NotifierState {}

class NotifierSelected extends NotifierState {
  final int id;
  const NotifierSelected(this.id);

  @override
  List<Object> get props => [id];
}

class NotifierStyleChanged extends NotifierState {
  final int id;
  const NotifierStyleChanged(this.id);
}
