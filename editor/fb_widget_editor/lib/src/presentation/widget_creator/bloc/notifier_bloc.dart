import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_core/fb_core.dart';

part 'notifier_state.dart';

class NotifierBloc extends Cubit<NotifierState> {
  final log = AppLog('NotifierCubit');
  NotifierBloc() : super(NotifierInitial());

  @override
  void onChange(Change<NotifierState> change) {
    super.onChange(change);
    log.out('onChange()', change);
  }

  void select(String id) {
    emit(NotifierSelected(id));
  }

  void styleChanged(String id) {
    emit(NotifierStyleChanged(id));
  }
}
