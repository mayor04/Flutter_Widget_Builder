part of 'fb_container_config.dart';

class FbContainerInputList {
  // * All inputs
  final heightInput = FbInputDataWrap<double?>('Height', 300);
  final widthInput = FbInputDataWrap<double?>('Width', 300);
  final colorInput = FbInputDataColor('Color', int.parse('0xFFE6E6D6'));

  final paddingInput = FbInputDataLTRB<List<double>>('Padding', [0, 0, 0, 0]);
  final marginInput = FbInputDataLTRB<List<double>>('Margin', [0, 0, 0, 0]);

  final alignInput = FbInputDataDropdownMap('Alignment',
      defaultValue: 'none', map: FbContainerStyles.alignmentMap);

  @visibleForTesting
  final radiusInput = FbInputDataWrap<double?>('radius', null);
  @visibleForTesting
  final borderSizeInput = FbInputDataWrap<double?>('size', null);
  @visibleForTesting
  final borderColorInput = FbInputDataColor('color', Colors.transparent.value);

  late final borderInput = FbGroupMultipleInputs('Border', fbInputs: [
    FbGroupDoubleInputs(
      '',
      input1: radiusInput,
      input2: borderSizeInput,
    ),
    FbInputDataColor('color', Colors.transparent.value),
  ]);

  FbContainerInputList({
    double? height,
    double? width,
    int? color,
    List<double>? padding,
    List<double>? margin,
    double? radius,
    double? borderSize,
    int? borderColor,
    String? alignment,
  }) {
    heightInput.value = height;
    widthInput.value = width;
    colorInput.value = color ?? int.parse('0xFFE6E6D6');
    paddingInput.value = padding ?? [0, 0, 0, 0];
    marginInput.value = margin ?? [0, 0, 0, 0];
    borderInput.inputAt(0).value = radius;
    borderInput.inputAt(1).value = borderSize;
    borderInput.inputAt(2).value = borderColor ?? Colors.transparent.value;
    alignInput.value = alignment ?? 'none';
  }

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
