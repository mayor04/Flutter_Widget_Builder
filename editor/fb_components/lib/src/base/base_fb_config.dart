import 'package:fb_components/fb_components.dart';
import 'package:fb_components/src/params/style_params/style_params.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/row/fb_row_config.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/stack/fb_stack_config.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/divider/fb_divider_config.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/icon/fb_icon_config.dart';
import 'package:fb_components/src/widget_groups/no_child_widgets/text/fb_text_config.dart';
import 'package:fb_components/src/widget_groups/parent_data_widgets/expanded/fb_expanded_config.dart';
import 'package:fb_components/src/widget_groups/parent_data_widgets/positioned/fb_positioned_config.dart';
import 'package:fb_components/src/widget_groups/single_child_widgets/center/fb_center_config.dart';
import 'package:fb_components/src/widget_groups/single_child_widgets/sized_box/fb_sized_box_config.dart';
import 'package:fb_core/fb_core.dart';

/// This abstract class is the base class for every widget
/// Extends this class to add more functionality
///`FBcontainerConfig extends FBwidgetConfig`
abstract class BaseFbConfig<T extends BaseFbStyles> {
  // TODO(sam): change id to string
  final String id;
  final FbWidgetType widgetType;
  final FbChildType childType;

  BaseFbConfig(this.widgetType, this.childType, {String? id}) : id = id ?? IdGen.generateIdString();

  // TO-CREATE - edit this
  static BaseFbConfig<BaseFbStyles> fromJson(Map<String, dynamic> json) {
    switch (FbWidgetType.values.firstWhere((e) => e.name == json['type'])) {
      case FbWidgetType.container:
        return FbContainerConfig.fromJson(json);
      case FbWidgetType.column:
        return FbColumnConfig.fromJson(json);
      case FbWidgetType.row:
        return FbRowConfig.fromJson(json);
      case FbWidgetType.sizedBox:
        return FbSizedBoxConfig.fromJson(json);
      case FbWidgetType.stack:
        return FbStackConfig.fromJson(json);
      case FbWidgetType.expanded:
        return FbExpandedConfig.fromJson(json);
      case FbWidgetType.text:
        return FbTextConfig.fromJson(json);
      case FbWidgetType.positioned:
        return FbPositionedConfig.fromJson(json);
      case FbWidgetType.divider:
        return FbDividerConfig.fromJson(json);
      case FbWidgetType.icon:
        return FbIconConfig.fromJson(json);
      case FbWidgetType.center:
        return FbCenterConfig.fromJson(json);

      default:
    }

    throw Exception('Unable to find widget type ${json['type']}');
  }

  // This method should be used somewhereelse due to testing
  // Widget builder(dynamic widget);

  String generateCode(String? childCode);

  void updateStyles(T styles);

  T getWidgetStyles();

  Map<String, dynamic> toJson();
}

/// Each WidgetConfig contains a data, this data is used
/// for displaying the Widget on the screen
abstract class BaseFbStyles {
  final String id;
  final FbWidgetType widgetType;
  final ParamsPlaceholder params;

  const BaseFbStyles(
    this.id,
    this.widgetType, {
    this.params = const {},
  });

  addParams({required String paramId, required String styleName}) {
    params[styleName] = StyleParams(paramId: paramId, styleName: styleName);
  }

  removeParams(String styleName) {
    params.remove(styleName);
  }

  A cast<A extends BaseFbStyles>() {
    if (this is A) {
      return this as A;
    }

    throw Exception('Unable to cast $A to type FbInputData');
  }
}

typedef ParamsPlaceholder = Map<String, StyleParams>;
