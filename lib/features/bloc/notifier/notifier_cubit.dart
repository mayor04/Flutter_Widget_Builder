import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notifier_state.dart';

class NotifierCubit extends Cubit<NotifierState> {
  NotifierCubit() : super(NotifierInitial());

  void select(int id) {
    emit(NotifierSelected(id));
  }

  void styleChanged(int id) {
    emit(NotifierStyleChanged(id));
  }
}
