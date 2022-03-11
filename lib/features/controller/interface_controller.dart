import 'package:flutter_widget_builder/core/constant/constant.dart';
import 'package:flutter_widget_builder/core/enum/fb_enum.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_data.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_widget.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_container.dart';

class FbInterfaceController {
  final log = AppLog('FbInterfaceController');

  final List<int> idList = [];
  final Map<int, FbWidget> fbWidgetsMap = {};

  ///Each of them hold the list of child/children
  final Map<int, FbData> fbDataMap = {};
  final Map<int, FbWidgetConfig> widgetConfigMap = {};

  FbInterfaceController() {
    //The main data is used to know the starting point of the widget

    idList.add(xMainId);
    fbDataMap[xMainId] = FbData(
      id: xMainId,
      widgetType: FbWidgetType.main,
      levelInTree: 0,
      children: [],
    );
  }

  ///This is called first when the screen is loaded
  Map<int, FbData> initialLoad() {
    ///Since no data is saved locally for now the initial load
    ///is always 1 for now

    if (idList.length == 1) {
      //Add Container if no widget has been created
      addChildWidget(xMainId, FbContainer());
    }
    return fbDataMap;
  }

  ///throws `Exception('Parent not found')` when the parent id is not found
  Map<int, FbData> addChildWidget(int parentId, FbWidget childWidget) {
    final id = childWidget.id;

    //Add id to the Id list
    idList.add(id);
    fbWidgetsMap[id] = childWidget;
    widgetConfigMap[id] = childWidget.getWidgetConfig();

    var parentData = fbDataMap[parentId];

    if (parentData == null) {
      throw Exception('Parent not found');
    }

    fbDataMap[id] = FbData(
      id: id,
      childType: childWidget.childType,
      widgetType: childWidget.widgetType,
      levelInTree: parentData.levelInTree + 1,
      children: [],
    );

    //add widget to parent list
    parentData.addWidget(id);
    return fbDataMap;
  }

  List<FbInput> getWidgetInput(int id) {
    return fbWidgetsMap[id]?.getInputs() ?? [];
  }

  void _refreshWidgetConfig(int id) {
    var config = fbWidgetsMap[id]?.getWidgetConfig();
    if (config == null) {
      log.error(
          'refreshWidgetConfig($id)', 'Found no config data while refreshing');
      throw (Exception('Config Data not found while refreshing'));
    } else {
      widgetConfigMap[id] = config;
    }
  }
}
