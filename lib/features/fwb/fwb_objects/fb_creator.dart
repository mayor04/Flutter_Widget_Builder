import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/all.dart';

class FbConfigCreator {
  static BaseFbConfig createConfig(FbWidgetType widgetType) {
    switch (widgetType) {
      case FbWidgetType.container:
        return FbContainerConfig();
      case FbWidgetType.column:
        return FbColumnConfig();
      case FbWidgetType.row:
        return FbRowConfig();
      case FbWidgetType.text:
        return FbTextConfig();
      case FbWidgetType.expanded:
        return FbExpandedConfig();
      case FbWidgetType.positioned:
        return FbPositionedConfig();
      case FbWidgetType.sizedBox:
        return FbSizedBoxConfig();
      case FbWidgetType.stack:
        return FbStackConfig();
      default:
        throw (Exception('Widget config is not available'));
    }
  }
}
