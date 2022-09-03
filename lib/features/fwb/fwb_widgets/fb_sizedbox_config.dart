import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';

class FbSizedBoxConfig extends BaseFbConfig<FbSizedBoxStyles> {
  var heightInput = FbInputDataExpanded<double?>('Height', null);
  var widthInput = FbInputDataExpanded<double?>('Width', null);

  FbSizedBoxConfig() : super(FbWidgetType.sizedBox, FbChildType.single);

  @override
  String generateCode(String child) {
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
