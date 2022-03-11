part of 'notifier_bloc.dart';

abstract class NotifierState extends Equatable {
  const NotifierState();
  
  @override
  List<Object> get props => [];
}

class NotifierInitial extends NotifierState {}
