import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';

class FbRowConfig extends BaseFbConfig<FbRowStyles> {
  FbRowConfig() : super(FbWidgetType.row, FbChildType.multiple);

  @override
  String generateCode(String child) {
    // TODO: implement generateCode
    throw UnimplementedError();
  }

  @override
  List<FbInputBase> getInputs() {
    // TODO: implement getInputs
    throw UnimplementedError();
  }

  @override
  FbRowStyles getWidgetStyles() {
    return FbRowStyles(id, widgetType);
  }
}

class FbRowStyles extends BaseFbStyles {
  FbRowStyles(
    int id,
    FbWidgetType widgetType,
  ) : super(id, widgetType);
}
