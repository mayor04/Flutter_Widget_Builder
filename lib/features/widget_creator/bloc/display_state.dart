part of 'display_bloc.dart';

abstract class DisplayState extends Equatable {
  const DisplayState();

  @override
  List<Object> get props => [];
}

class DisplayInitial extends DisplayState {}
