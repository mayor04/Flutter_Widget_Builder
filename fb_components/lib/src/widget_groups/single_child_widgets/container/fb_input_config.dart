part of 'fb_container_config.dart';

class _Inputs {
  // * All inputs
  var heightInput = FbInputDataWrap<double?>('Height', 300);
  var widthInput = FbInputDataWrap<double?>('Width', 300);
  var colorInput = FbInputDataColor('Color', int.parse('0xFFE6E6D6'));

  var paddingInput = FbInputDataLTRB<List<double>>('Padding', [0, 0, 0, 0]);
  var marginInput = FbInputDataLTRB<List<double>>('Margin', [0, 0, 0, 0]);

  var borderInput = FbGroupMultipleInputs('Border', fbInputs: [
    FbGroupDoubleInputs(
      '',
      input1: FbInputDataWrap<double?>('radius', null),
      input2: FbInputDataWrap<double?>('size', null),
    ),
    FbInputDataColor('color', Colors.transparent.value),
  ]);

  var alignInput = FbInputDataDropdownMap(
    'Alignment',
    defaultValue: 'none',
    map: {
      'none': null,
      'bottomCenter': Alignment.bottomCenter,
      'bottomLeft': Alignment.bottomLeft,
      'bottomRight': Alignment.bottomRight,
      'center': Alignment.center,
      'centerLeft': Alignment.centerLeft,
      'centerRight': Alignment.centerRight,
      'topCenter': Alignment.topCenter,
      'topLeft': Alignment.topLeft,
      'topRight': Alignment.topRight,
    },
  );

  // * Value Getters
  num? get height => heightInput.value?.removeZeroDecimal;

  num? get width => widthInput.value?.removeZeroDecimal;

  List<double> get padding => paddingInput.value;

  List<double> get margin => marginInput.value;

  int get color => colorInput.value;

  Alignment? get alignment {
    final align = alignInput.value;
    return alignInput.map[align];
  }

  num? get radius =>
      ((borderInput.inputAt(0) as FbGroupDoubleInputs).input1.value as double?)?.removeZeroDecimal;

  num? get borderSize =>
      ((borderInput.inputAt(0) as FbGroupDoubleInputs).input2.value as double?)?.removeZeroDecimal;

  int get borderColor => borderInput.inputAt(1).value;
}
