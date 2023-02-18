part of 'app_details_bloc.dart';

@immutable
class AppDetailsState extends Equatable {
  const AppDetailsState({
    this.status = StateStatus.initial,
  });

  final StateStatus status;

  @override
  List<Object> get props => [status];

  // copy with
  AppDetailsState copyWith({
    StateStatus? status,
    List<AppDetailsModel>? projectList,
  }) {
    return AppDetailsState(
      status: status ?? this.status,
    );
  }
}
