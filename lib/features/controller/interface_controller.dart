import 'package:fb_core/fb_core.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_details.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_container_config.dart';

typedef FbWidgetStylesCallback = BaseFbStyles Function();

class FbInterfaceController {
  final log = AppLog('FbInterfaceController');

  final List<int> idList = [];
  final Map<int, BaseFbConfig> fbWidgetsMap = {};

  /// Each of them hold the list of child/children and parent id
  /// For example lets take alook at
  ///               ` Container1 > Column > Container2`
  /// The columnDetails holds reference to container1 as id and
  /// Hold refrence to container2 as children
  final Map<int, FbWidgetDetails> fbDetailsMap = {};
  final Map<int, FbWidgetStylesCallback> widgetStylesCallbackMap = {};

  FbInterfaceController() {
    //The main data is used to know the starting point of the widget

    idList.add(xMainId);
    fbDetailsMap[xMainId] = FbWidgetDetails(
      id: xMainId,
      parentId: 0,
      widgetType: FbWidgetType.main,
      levelInTree: 0,
      children: [],
    );
  }

  //TODO: create an error class instead of using exception

  ///throws `Exception('Parent not found')` when the parent id is not found
  ///Add child widget to the `fbWidgetMap` and `idList`
  Map<int, FbWidgetDetails> addChildWidget(int parentId, BaseFbConfig childWidget) {
    final id = childWidget.id;

    //Add id to the Id list
    idList.add(id);
    fbWidgetsMap[id] = childWidget;
    widgetStylesCallbackMap[id] = childWidget.getWidgetStyles;

    var parentData = fbDetailsMap[parentId];

    if (parentData == null) {
      throw Failure('Parent not found');
    }

    fbDetailsMap[id] = FbWidgetDetails(
      id: id,
      parentId: parentId,
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

  Map<int, FbWidgetDetails> removeWidget(int widgetId) {
    //The aim of this remove is to remove all the reference to the widget
    //To acheive this we remove the child reference from the parent
    //And also remove the reference to parent id from the child

    //Get widget details for widget to be removed
    var widgetDetails = fbDetailsMap[widgetId];
    if (widgetDetails == null) {
      throw Failure('widget does not exist');
    }

    int? parentId = widgetDetails.parentId;
    List<int> children = widgetDetails.children;

    if (children.length > 1) {
      throw (RemoveMultipleWidgetFailure());
    }

    //Attach children of widget to parent of widget
    var parentDetails = fbDetailsMap[parentId];
    if (parentDetails == null) {
      throw Failure('Parent does not exist');
    }
    //Since we are removing and not totally deleting we need to
    //attach the children of the widget to the parent
    parentDetails.changeChildren(children);

    var childId = widgetDetails.firstChildId;
    if (childId == null) {
      log.out('removeWidget()', 'This widget has no children');
    }

    //Change parent of the child to this widget parent
    fbDetailsMap[childId]?.changeParentId(parentDetails.id);

    //Finally remove the widget totally
    fbDetailsMap.remove(widgetId);
    fbWidgetsMap.remove(widgetId);
    widgetStylesCallbackMap.remove(widgetId);

    return fbDetailsMap;
  }

  Map<int, FbWidgetDetails> wrapWidget(int childId, BaseFbConfig wrapWidget) {
    //The aim of wrap is to insert a widget in between two widget
    //What we would do first is attach childId to the new widget to be created
    //and detach the childId from the previous parent.

    //Get child parent Id
    var childDetails = fbDetailsMap[childId];
    if (childDetails == null) {
      throw Failure('The selected child doesn\'t exist');
    }

    var childsParentId = childDetails.parentId;
    var childParentDetails = fbDetailsMap[childsParentId];

    //To avoid error(type single widget error) we need to remove the children
    childParentDetails?.changeChildren([]);

    //Add the child to the widget tree
    addChildWidget(childsParentId, wrapWidget);

    //Change the child widget parent id to the wrap widget to detach it
    childDetails.changeParentId(wrapWidget.id);
    fbDetailsMap[wrapWidget.id]?.changeChildren([childId]);

    return fbDetailsMap;
  }

  /// Delete removes the particular widdget from the details and doesn't remove
  /// it children, but since removing the widget details disconnect the widget
  /// from the widget tree the children appears to be deleted
  ///
  /// This pattern is used incase the user wants to undo his action
  Map<int, FbWidgetDetails> deleteWidget(int widgetId) {
    fbDetailsMap.remove(widgetId);
    fbWidgetsMap.remove(widgetId);
    widgetStylesCallbackMap.remove(widgetId);

    return fbDetailsMap;
  }

  List<BaseFbInput> getWidgetInput(int id) {
    return fbWidgetsMap[id]?.getInputs() ?? [];
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

  // ignore: unused_element
  void _refreshWidgetConfig(int id) {
    var config = fbWidgetsMap[id]?.getWidgetStyles;
    if (config == null) {
      log.error('refreshWidgetConfig($id)', 'Found no config data while refreshing');
      throw (Failure('Config Data not found while refreshing'));
    } else {
      widgetStylesCallbackMap[id] = config;
    }
  }
}
