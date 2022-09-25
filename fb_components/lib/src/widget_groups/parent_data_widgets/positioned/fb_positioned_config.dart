import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/inputs/groups/double_inputs.dart';
import 'package:fb_components/src/inputs/single/wrap_input.dart';

class FbPositionedConfig extends BaseFbConfig<FbPositionedStyles> {
  var topInput = FbInputDataWrap<double?>('Top', null);
  var rightInput = FbInputDataWrap<double?>('Right', null);
  var leftInput = FbInputDataWrap<double?>('Left', null);
  var bottomInput = FbInputDataWrap<double?>('Bottom', null);

  FbPositionedConfig() : super(FbWidgetType.positioned, FbChildType.single);

  @override
  String generateCode(String? childCode, int level) {
    // TODO: implement generateCode
    throw UnimplementedError();
  }

  @override
  List<BaseFbInput> getInputs() {
    return [
      FbGroupDoubleInputs('', input1: topInput, input2: leftInput),
      FbGroupDoubleInputs('', input1: rightInput, input2: bottomInput),
    ];
  }

  @override
  FbPositionedStyles getWidgetStyles() {
    return FbPositionedStyles(
      id,
      widgetType,
      top: topInput.value,
      bottom: bottomInput.value,
      right: rightInput.value,
      left: leftInput.value,
    );
  }
}

class FbPositionedStyles extends BaseFbStyles {
  final double? top;
  final double? right;
  final double? left;
  final double? bottom;

  FbPositionedStyles(
    int id,
    FbWidgetType widgetType, {
    this.top,
    this.right,
    this.left,
    this.bottom,
  }) : super(id, widgetType);
}
