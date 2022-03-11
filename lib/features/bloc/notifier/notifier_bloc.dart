import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notifier_event.dart';
part 'notifier_state.dart';

class NotifierBloc extends Bloc<NotifierEvent, NotifierState> {
  NotifierBloc() : super(NotifierInitial()) {
    on<NotifierEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
