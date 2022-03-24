import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_builder/core/constant/constant.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_details.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_container_config.dart';

typedef FbWidgetStylesCallback = BaseFbStyles Function();

class FbInterfaceController {
  final log = AppLog('FbInterfaceController');

  final List<int> idList = [];
  final Map<int, BaseFbConfig> fbWidgetsMap = {};

  ///Each of them hold the list of child/children
  final Map<int, FbWidgetDetails> fbDetailsMap = {};
  final Map<int, FbWidgetStylesCallback> widgetStylesCallbackMap = {};

  FbInterfaceController() {
    //The main data is used to know the starting point of the widget

    idList.add(xMainId);
    fbDetailsMap[xMainId] = FbWidgetDetails(
      id: xMainId,
      widgetType: FbWidgetType.main,
      levelInTree: 0,
      children: [],
    );
  }

  ///This is called first when the screen is loaded
  Map<int, FbWidgetDetails> initialLoad() {
    ///Since no data is saved locally for now the initial load
    ///is always 1 for now

    if (idList.length == 1) {
      //Add Container if no widget has been created
      addChildWidget(xMainId, FbContainerConfig());
    }
    return fbDetailsMap;
  }

  ///throws `Exception('Parent not found')` when the parent id is not found
  Map<int, FbWidgetDetails> addChildWidget(
      int parentId, BaseFbConfig childWidget) {
    final id = childWidget.id;

    //Add id to the Id list
    idList.add(id);
    fbWidgetsMap[id] = childWidget;
    widgetStylesCallbackMap[id] = childWidget.getWidgetStyles;

    var parentData = fbDetailsMap[parentId];

    if (parentData == null) {
      throw Exception('Parent not found');
    }

    fbDetailsMap[id] = FbWidgetDetails(
      id: id,
      childType: childWidget.childType,
      widgetType: childWidget.widgetType,
      levelInTree: parentData.levelInTree + 1,
      widgetStylesCallback: childWidget.getWidgetStyles,
      children: [],
    );

    //add widget to parent list
    parentData.addWidget(id);
    return fbDetailsMap;
  }

  List<FbInputBase> getWidgetInput(int id) {
    return fbWidgetsMap[id]?.getInputs() ?? [];
  }

  void _refreshWidgetConfig(int id) {
    var config = fbWidgetsMap[id]?.getWidgetStyles;
    if (config == null) {
      log.error(
          'refreshWidgetConfig($id)', 'Found no config data while refreshing');
      throw (Exception('Config Data not found while refreshing'));
    } else {
      widgetStylesCallbackMap[id] = config;
    }
  }
}
