import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';

class FbTextConfig extends BaseFbConfig<FbTextStyles> {
  var textInput = FbInputDataText('Text', '');
  var fontSizeInput = FbInputDataExpanded<double>('Font Size', 13);
  var colorInput = FbInputDataColor('Color', int.parse('0xFF000000'));
  var fontWeightInput = FbInputDataDropdownMap(
    'Font weight',
    defaultValue: FbTextStyles.defaultWeight,
    map: FbTextStyles.fontWeightMap,
  );

  FbTextConfig() : super(FbWidgetType.text, FbChildType.none);

  @override
  String generateCode(String child) {
    // TODO: implement generateCode
    throw UnimplementedError();
  }

  @override
  List<BaseFbInput> getInputs() {
    return [textInput, fontSizeInput, colorInput, fontWeightInput];
  }

  @override
  FbTextStyles getWidgetStyles() {
    return FbTextStyles(
      id,
      widgetType,
      text: textInput.value,
      fontSize: fontSizeInput.value,
      colorValue: colorInput.value,
      fontWeight: fontWeightInput.mapValue,
    );
  }
}

class FbTextStyles extends BaseFbStyles {
  final String text;
  final int colorValue;
  final FontWeight? fontWeight;
  final double? fontSize;

  FbTextStyles(
    int id,
    FbWidgetType widgetType, {
    required this.text,
    required this.colorValue,
    this.fontWeight,
    this.fontSize,
  }) : super(id, widgetType);

  static String defaultWeight = 'none';

  static Map<String, FontWeight?> fontWeightMap = () {
    Map<String, FontWeight?> weightMap = {'none': null};

    for (var weight in FontWeight.values) {
      String key = weight.toString().split('.')[1];
      weightMap[key] = weight;
    }

    return weightMap;
  }();
}
