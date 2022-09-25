import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter_widget_builder/features/widget_creator/models/fb_details.dart';

typedef FbWidgetStylesCallback = BaseFbStyles Function();

class InterfaceController {
  final log = AppLog('FbInterfaceController');

  final List<int> idList = [];
  final Map<int, BaseFbConfig> fbWidgetsMap = {};

  /// Each of them hold the list of child/children and parent id
  /// For example lets take alook at
  ///               ` Container1 > Column > Container2`
  /// The columnDetails holds reference to container1 as parentId and
  /// Hold refrence to container2 as children
  final Map<int, FbWidgetDetails> fbDetailsMap = {};

  // Todo: inspect this implemntation -> is the styles suppose to be stored in a map
  final Map<int, FbWidgetStylesCallback> widgetStylesCallbackMap = {};

  InterfaceController() {
    // The main data is used to know the starting point of the widget

    idList.add(xMainId);
    fbDetailsMap[xMainId] = FbWidgetDetails(
      id: xMainId,
      parentId: 0,
      widgetType: FbWidgetType.main,
      levelInTree: 0,
      children: [],
    );
  }

  /// This is called first when the screen is loaded
  Map<int, FbWidgetDetails> initialLoad() {
    /// Since no data is saved locally for now the initial load
    /// is always 1 for now

    if (idList.length == 1) {
      // Add Container if no widget has been created
      //
      addChildWidget(xMainId, FbContainerConfig());
    }
    return fbDetailsMap;
  }

  /// throws `Exception('Parent not found')` when the parent id is not found
  /// Add child widget to the `fbWidgetMap` and `idList`
  Map<int, FbWidgetDetails> addChildWidget(int parentId, BaseFbConfig childWidget) {
    final id = childWidget.id;

    // Add id to the Id list
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

  /// Removes only the particular widget from the widget tree
  Map<int, FbWidgetDetails> removeWidget(int removeWidgetId) {
    // The aim of this remove is to remove all the reference to the widget
    // To acheive this we remove the child reference from the parent
    // And also remove the reference to parent id from the child
    // Then we attach its children to this widget parent

    /// before `ParentWidget` > `RemoveWidget` > `ChildWidget`
    /// after `ParentWidget` > `ChildWidget`

    // Get widget details for widget to be removed
    var removeWidgetDetails = fbDetailsMap[removeWidgetId];
    if (removeWidgetDetails == null) {
      throw Failure('widget does not exist');
    }

    int? parentId = removeWidgetDetails.parentId;
    List<int> children = removeWidgetDetails.children;

    // If this widget has multiple children it mean it can be removed
    if (children.length > 1) {
      throw (RemoveMultipleWidgetFailure());
    }

    // Attach children of widget to parent of widget
    var parentDetails = fbDetailsMap[parentId];
    if (parentDetails == null) {
      throw Failure('Parent does not exist');
    }

    var childId = removeWidgetDetails.firstChildId;
    if (childId == null) {
      log.out('removeWidget()', 'This widget has no children');
    }

    // Since we are removing and not totally deleting we replace this
    // widget with its child in the parent details
    parentDetails.replaceChild(removeWidgetId, childId);

    // Change parent of the child to this widget parent
    fbDetailsMap[childId]?.changeParentId(parentDetails.id);

    // Finally remove the widget totally
    fbDetailsMap.remove(removeWidgetId);
    fbWidgetsMap.remove(removeWidgetId);
    widgetStylesCallbackMap.remove(removeWidgetId);

    return fbDetailsMap;
  }

  Map<int, FbWidgetDetails> wrapWidget(int childId, BaseFbConfig wrapWidget) {
    // The aim of wrap is to insert a widget in between two widget
    // What we would do first is attach childId to the new widget to be created
    // and detach the childId from the previous parent.

    /// before `ParentWidget` > `ChildWidget`
    /// after `ParentWidget` > `WrapWidget` > `ChildWidget`

    // Get child parent Id
    var childDetails = fbDetailsMap[childId];
    if (childDetails == null) {
      throw Failure('The selected child doesn\'t exist');
    }

    var childsParentId = childDetails.parentId;
    var childParentDetails = fbDetailsMap[childsParentId];

    // To avoid error(type single widget error) we need to remove the children
    childParentDetails?.changeChildren([]);

    // Add the child to the widget tree
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
