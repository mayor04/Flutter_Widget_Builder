part of 'widget_list_bloc.dart';

@immutable
class WidgetListState extends Equatable {
  const WidgetListState({
    this.status = StateStatus.initial,
    required this.fileList,
    required this.projectName,
    this.errorMessage,
  });

  final String projectName;
  final StateStatus status;
  final List<WidgetDetailsModel> fileList;

  final String? errorMessage;

  @override
  List<Object> get props => [status, fileList];

  WidgetListState copyWith({
    StateStatus? status,
    List<WidgetDetailsModel>? fileList,
    String? appName,
    String? errorMessage,
  }) {
    return WidgetListState(
      status: status ?? this.status,
      fileList: fileList ?? this.fileList,
      projectName: appName ?? this.projectName,
      errorMessage: errorMessage,
    );
  }
}
