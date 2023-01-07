part of 'styles_input_bloc.dart';

class StylesInputState {
  const StylesInputState(this.selectedWidgetStyle, this.widgetId);
  final String widgetId;
  final BaseFbStyles? selectedWidgetStyle;

  // @override
  // List<Object> get props => [selectedWidgetStyle?.id ?? ''];
}
