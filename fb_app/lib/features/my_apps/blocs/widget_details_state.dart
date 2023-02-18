part of 'widget_details_bloc.dart';

@immutable
class WidgetDetailsState extends Equatable {
  const WidgetDetailsState({
    this.status = StateStatus.initial,
  });

  final StateStatus status;

  @override
  List<Object> get props => [status];

  // copy with
  WidgetDetailsState copyWith({
    StateStatus? status,
    List<WidgetDetailsModel>? fileList,
  }) {
    return WidgetDetailsState(
      status: status ?? this.status,
    );
  }
}
