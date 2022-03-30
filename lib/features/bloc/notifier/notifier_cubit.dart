import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';

part 'notifier_state.dart';

class NotifierCubit extends Cubit<NotifierState> {
  final log = AppLog('NotifierCubit');
  NotifierCubit() : super(NotifierInitial());

  @override
  void onChange(Change<NotifierState> change) {
    super.onChange(change);
    log.out('onChange()', change);
  }

  void select(int id) {
    emit(NotifierSelected(id));
  }

  void styleChanged(int id) {
    emit(NotifierStyleChanged(id));
  }
}
