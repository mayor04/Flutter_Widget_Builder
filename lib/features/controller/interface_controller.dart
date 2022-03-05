import 'package:flutter_widget_builder/core/enum/fb_enum.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_data.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_widget.dart';

class FbInterfaceController {
  final log = AppLog('FbInterfaceController');

  List<int> idList = [];
  Map<int, FbWidget> fbWidgets = {};

  ///Each of them hold the list of child/children
  Map<int, FbData> childMap = {};
  Map<int, FbWidgetConfig> widgetConfig = {};

  FbInterfaceController() {
    //The main data is used to know the starting point of the widget
    int mainId = 111;

    idList.add(mainId);
    childMap[mainId] = FbData(
      id: mainId,
      widgetType: FbWidgetType.main,
      levelInTree: 0,
    );
  }

  void _refreshWidgetConfig(int id) {
    var config = fbWidgets[id]?.getWidgetConfig();
    if (config == null) {
      log.error(
          'refreshWidgetConfig($id)', 'Found no config data while refreshing');
      throw (Exception('Config Data not found while refreshing'));
    } else {
      widgetConfig[id] = config;
    }
  }

  bool addChildWidget(int parentId, FbWidget childWidget) {
    final id = childWidget.id;

    //Add id to the Id list
    idList.add(id);
    fbWidgets[id] = childWidget;

    var parentData = childMap[parentId];

    if (parentData == null) {
      throw Exception('Parent not found');
    }

    childMap[id] = FbData(
      id: id,
      widgetType: childWidget.widgetType,
      levelInTree: parentData.levelInTree + 1,
    );

    //add widget to parent list
    parentData.addWidget(id);
    return true;
  }
}
