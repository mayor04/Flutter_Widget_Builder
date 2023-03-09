import 'package:fb_app/features/widget_creator/models/fb_details.dart';
import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';

typedef FbWidgetStylesCallback = BaseFbStyles Function();
final _log = AppLog('FbInterfaceController');

class InterfaceController {
  InterfaceController({required this.widgetId}) {
    _initFuture = loadWidgetData(widgetId);
  }

  late Future<void> _initFuture;
  final String widgetId;

  /// Each of them hold the list of child/children and parent id
  /// For example lets take a look at
  ///               ` Container1 > Column > Container2`
  /// The columnDetails holds reference to container1 as parentId and
  /// Hold refrence to container2 as children
  late final Map<String, FbWidgetDetails> fbDetailsMap;
  late final Map<String, BaseFbConfig> fbConfigMap;
  late final List<String> idList;
  late final GlobalParamsMap parameters;

  final WidgetUIRepository _widgetRepo = gi<WidgetUIRepository>();

  Future<void> ensureInitialized() async {
    await _initFuture;
  }

  Future<void> loadWidgetData(String widgetDataId) async {
    final widgetData = await _widgetRepo.get(widgetDataId);

    idList = widgetData.idList;
    fbConfigMap = widgetData.fbConfigMap.map(
      (key, value) => MapEntry(key, BaseFbConfig.fromJson(value)),
    );
    fbDetailsMap = widgetData.fbDetailsMap.map(
      (key, value) => MapEntry(key, FbWidgetDetails.fromJson(value)),
    );
    parameters = widgetData.parameters.map(
      (key, value) => MapEntry(key, InputParams.fromJson(value)),
    );

    if (idList.isEmpty) {
      // The main data is used to know the starting point of the widget
      idList.add(xMainId);
      fbDetailsMap[xMainId] = FbWidgetDetails(
        id: xMainId,
        parentId: '0',
        widgetType: FbWidgetType.main,
        levelInTree: 0,
        children: [],
      );
    }

    // For debug purpose
    initialLoad();
  }

  Future<void> saveWidgetData() {
    // TODO: make this a model that handle to json and from json
    final widgetData = WidgetUIModel(
      id: widgetId,
      idList: idList,
      fbConfigMap: fbConfigMap.map((key, value) => MapEntry(key, value.toJson())),
      fbDetailsMap: fbDetailsMap.map((key, value) => MapEntry(key, value.toJson())),
      parameters: parameters.map((key, value) => MapEntry(key, value.toJson())),
    );

    return _widgetRepo.update(widgetData);
  }

  /// This is called first when the screen is loaded
  Map<String, FbWidgetDetails> initialLoad() {
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
  Map<String, FbWidgetDetails> addChildWidget(String parentId, BaseFbConfig childWidget) {
    final id = childWidget.id;

    // Add id to the Id list
    idList.add(id);
    fbConfigMap[id] = childWidget;
    // widgetStylesCallbackMap[id] = childWidget.getWidgetStyles;

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
      children: [],
    );

    //add widget to parent list
    parentData.addWidget(id);

    saveWidgetData();
    return fbDetailsMap;
  }

  /// Removes only the particular widget from the widget tree
  Map<String, FbWidgetDetails> removeWidget(String removeWidgetId) {
    // The aim of this remove is to remove all the reference to the widget
    // To acheive this we remove the child reference from the parent
    // And also remove the reference to parent id from the child
    // Then we attach its children to this widget parent

    /// before `ParentWidget` > `RemoveWidget` > `ChildWidget`
    /// after `ParentWidget` > `ChildWidget`

    // Get widget details for widget to be removed
    final removeWidgetDetails = fbDetailsMap[removeWidgetId];
    if (removeWidgetDetails == null) {
      throw Failure('widget does not exist');
    }

    String? parentId = removeWidgetDetails.parentId;
    List<String> children = removeWidgetDetails.children;

    // If this widget has multiple children it mean it can be removed
    if (children.length > 1) {
      throw (RemoveMultipleWidgetFailure());
    }

    // Attach children of widget to parent of widget
    final parentDetails = fbDetailsMap[parentId];
    if (parentDetails == null) {
      throw Failure('Parent does not exist');
    }

    var childId = removeWidgetDetails.firstChildId;
    if (childId == null) {
      _log.out('removeWidget()', 'This widget has no children');
    }

    // Since we are removing and not totally deleting we replace this
    // widget with its child in the parent details
    parentDetails.replaceChild(removeWidgetId, childId);

    // Change parent of the child to this widget parent
    fbDetailsMap[childId]?.changeParentId(parentDetails.id);

    // Finally remove the widget totally
    fbDetailsMap.remove(removeWidgetId);
    fbConfigMap.remove(removeWidgetId);
    idList.remove(removeWidgetId);
    // widgetStylesCallbackMap.remove(removeWidgetId);

    saveWidgetData();
    return fbDetailsMap;
  }

  Map<String, FbWidgetDetails> wrapWidget(String childId, BaseFbConfig wrapWidget) {
    // The aim of wrap is to insert a widget in between two widget
    // What we would do first is attach childId to the new widget to be created
    // and detach the childId from the previous parent.

    /// before `ParentWidget` > `ChildWidget`
    /// after `ParentWidget` > `WrapWidget` > `ChildWidget`

    // Get child parent Id
    final childDetails = fbDetailsMap[childId];
    if (childDetails == null) {
      throw Failure('The selected child doesn\'t exist');
    }

    final childsParentId = childDetails.parentId;
    final childParentDetails = fbDetailsMap[childsParentId];

    final parentChildren = childParentDetails?.children;
    // To avoid error(type single widget error) we need to remove the children
    childParentDetails?.changeChildren([]);

    // Add the child to the widget tree
    addChildWidget(childsParentId, wrapWidget);

    // After adding wrap widget, change children to previous children then
    // replace the former child id with the wrap widget, this is done this way
    // to matain the position of previous children
    childParentDetails?.changeChildren(parentChildren ?? []);
    childParentDetails?.replaceChild(childId, wrapWidget.id);

    //Change the child widget parent id to the wrap widget to detach it
    childDetails.changeParentId(wrapWidget.id);
    fbDetailsMap[wrapWidget.id]?.changeChildren([childId]);

    saveWidgetData();
    return fbDetailsMap;
  }

  /// Delete removes the particular widdget from the details and doesn't remove
  /// it children, but since removing the widget details disconnect the widget
  /// from the widget tree the children appears to be deleted
  ///
  /// This pattern is used incase the user wants to undo his action
  Map<String, FbWidgetDetails> deleteWidget(String widgetId) {
    final parentId = fbDetailsMap[widgetId]?.parentId;
    fbDetailsMap[parentId]?.replaceChild(widgetId, null);

    fbDetailsMap.remove(widgetId);
    fbConfigMap.remove(widgetId);
    // widgetStylesCallbackMap.remove(widgetId);

    saveWidgetData();
    return fbDetailsMap;
  }

  BaseFbStyles? getWidgetStyles(String id) {
    return fbConfigMap[id]?.getWidgetStyles();
  }

  void changeWidgetStyles(BaseFbStyles styles) {
    fbConfigMap[styles.id]?.updateStyles(styles);

    saveWidgetData();
  }

  void setParams(GlobalParamsMap params) {
    parameters
      ..clear()
      ..addAll(params);

    saveWidgetData();
  }

  // void _refreshWidgetConfig(String id) {
  //   var config = fbWidgetsMap[id]?.getWidgetStyles;
  //   if (config == null) {
  //     log.error('refreshWidgetConfig($id)', 'Found no config data while refreshing');
  //     throw (Failure('Config Data not found while refreshing'));
  //   } else {
  //     widgetStylesCallbackMap[id] = config;
  //   }
  // }
}
