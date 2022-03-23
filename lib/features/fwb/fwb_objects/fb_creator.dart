import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_widget.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_column.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_container.dart';

class FbConfigCreator {
  static FbWidgetConfig createConfig(FbWidgetType widgetType) {
    switch (widgetType) {
      case FbWidgetType.container:
        return FbContainerConfig();
      case FbWidgetType.column:
        return FbColumnConfig();
      default:
        throw (Exception('Widget config is not available'));
    }
  }
}
