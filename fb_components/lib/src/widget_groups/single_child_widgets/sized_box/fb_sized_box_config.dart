import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/inputs/single/expanded_input.dart';

class FbSizedBoxConfig extends BaseFbConfig<FbSizedBoxStyles> {
  var heightInput = FbInputDataExpanded<double?>('Height', null);
  var widthInput = FbInputDataExpanded<double?>('Width', null);

  FbSizedBoxConfig() : super(FbWidgetType.sizedBox, FbChildType.single);

  @override
  String generateCode(String? childCode, int level) {
    // TODO: implement generateCode
    throw UnimplementedError();
  }

  @override
  List<BaseFbInput> getInputs() {
    return [
      heightInput,
      widthInput,
    ];
  }

  @override
  getWidgetStyles() {
    return FbSizedBoxStyles(
      id,
      widgetType,
      heightInput.value,
      widthInput.value,
    );
  }
}

class FbSizedBoxStyles extends BaseFbStyles {
  final double? height;
  final double? width;

  FbSizedBoxStyles(
    int id,
    FbWidgetType widgetType,
    this.height,
    this.width,
  ) : super(id, widgetType);
}
