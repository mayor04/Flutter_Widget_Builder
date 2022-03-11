import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'display_event.dart';
part 'display_state.dart';

class DisplayBloc extends Bloc<DisplayEvent, DisplayState> {
  DisplayBloc() : super(DisplayInitial()) {
    on<DisplayEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
