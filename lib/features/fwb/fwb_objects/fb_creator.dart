import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_column_config.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_container_config.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_row_config.dart';

class FbConfigCreator {
  static BaseFbConfig createConfig(FbWidgetType widgetType) {
    switch (widgetType) {
      case FbWidgetType.container:
        return FbContainerConfig();
      case FbWidgetType.column:
        return FbColumnConfig();
      case FbWidgetType.row:
        return FbRowConfig();
      default:
        throw (Exception('Widget config is not available'));
    }
  }
}
