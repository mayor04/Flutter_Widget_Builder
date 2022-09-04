import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/column/fb_column_config.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/row/fb_row_config.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/stack/fb_stack_config.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/text/fb_text_config.dart';
import 'package:fb_components/src/widget_groups/parent_data_widgets/expanded/fb_expanded_config.dart';
import 'package:fb_components/src/widget_groups/parent_data_widgets/positioned/fb_positioned_config.dart';
import 'package:fb_components/src/widget_groups/single_child_widgets/container/fb_container_config.dart';
import 'package:fb_components/src/widget_groups/single_child_widgets/sized_box/fb_sized_box_config.dart';

class FbConfigFactory {
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
