part of 'styles_input_bloc.dart';

class StylesInputState {
  const StylesInputState(this.selectedWidgetStyle, this.widgetId);
  final int widgetId;
  final BaseFbStyles? selectedWidgetStyle;

  // @override
  // List<Object> get props => [selectedWidgetStyle?.id ?? ''];
}
