import 'package:fb_core/fb_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_group_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_details.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_column_config.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_container_config.dart';

void main() {
  late FbInterfaceController interfaceController;
  late Map<int, FbWidgetDetails> details;

  setUp(() {
    interfaceController = FbInterfaceController();
    details = interfaceController.fbDetailsMap;
  });

  //Test if widget is added successfully
  test('Adding Widget of widget type single success', () {
    var childWidget = FbContainerConfig();
    interfaceController.addChildWidget(xMainId, childWidget);

    expect(
      isChildPresent(childWidget.id, interfaceController),
      true,
    );

    var isChildInParent =
        interfaceController.fbDetailsMap[xMainId]?.children.contains(childWidget.id);
    expect(isChildInParent, true);
  });

  test('Adding Widget of widget type multiple success', () async {
    var parentWidget = FbColumnConfig();
    await wait();
    interfaceController.addChildWidget(xMainId, parentWidget);

    expect(
      isChildPresent(parentWidget.id, interfaceController),
      true,
    );

    bool containsChild(parentId, childId) {
      return interfaceController.fbDetailsMap[parentId]?.children.contains(childId) ?? false;
    }

    var isChildInParent = containsChild(xMainId, parentWidget.id);
    expect(isChildInParent, true);

    await wait();
    var firstChild = FbContainerConfig();
    interfaceController.addChildWidget(parentWidget.id, firstChild);

    await wait();
    var secondChild = FbContainerConfig();
    interfaceController.addChildWidget(parentWidget.id, secondChild);

    var canAcceptMultipleChild = containsChild(parentWidget.id, firstChild.id) &&
        containsChild(parentWidget.id, secondChild.id);

    expect(canAcceptMultipleChild, true);
  });

  group('Remove widget test', () {
    late FbContainerConfig container1;
    late FbColumnConfig column1;
    late FbContainerConfig container2;
    late FbContainerConfig container3;

    setUp(() {
      return Future(() async {
        container1 = FbContainerConfig();
        await wait();
        column1 = FbColumnConfig();
        await wait();
        container2 = FbContainerConfig();
        await wait();
        container3 = FbContainerConfig();

        //add container1
        interfaceController.addChildWidget(xMainId, container1);

        //add column
        interfaceController.addChildWidget(container1.id, column1);

        //add container2
        interfaceController.addChildWidget(column1.id, container2);

        //add container3
        interfaceController.addChildWidget(column1.id, container3);

        return Future.value(0);
      });
    });

    test('Remove Widget success', () {
      var container1children = details[container1.id]?.children;
      //Confirm if the parent of column1 is container1
      expect(
        details[column1.id]?.parentId,
        container1.id,
      );

      var result = interfaceController.removeWidget(container1.id);

      expect(
        result[container1.id],
        null,
      );

      //Since container is removed the new parent should be the main Id
      expect(
        details[column1.id]?.parentId,
        xMainId,
      );

      //Since we are removing the widget from the tree so the children
      //Should be transferred to the top of the tree with xMainId
      //Thus we want to confirm if the children was succesfully transferred
      expect(
        details[xMainId]?.children,
        container1children,
      );
    });

    test('Unable to remove widget with multiple children', () {
      expect(
        () => interfaceController.removeWidget(column1.id),
        throwsA(isA<RemoveMultipleWidgetFailure>()),
      );
    });

    test('Can Remove widget without multiple children and no children', () {
      expect(
        interfaceController.removeWidget(container2.id),
        interfaceController.fbDetailsMap,
      );

      expect(
        interfaceController.removeWidget(column1.id),
        interfaceController.fbDetailsMap,
      );
    });
  });

  test('Wrap widget test', () async {
    var container1 = FbContainerConfig();
    await wait();
    var wrappedWidget = FbColumnConfig();

    //add container1
    interfaceController.addChildWidget(xMainId, container1);
    var fbDetails = interfaceController.wrapWidget(container1.id, wrappedWidget);

    // check if  wrap widget was added
    expect(fbDetails[wrappedWidget.id], isA<FbWidgetDetails>());
    // check if wrap widget first child is container1
    expect(fbDetails[wrappedWidget.id]?.firstChildId, container1.id);
    // check if container1 parent is wrapped widget
    expect(fbDetails[container1.id]?.parentId, wrappedWidget.id);
    // check if xmainId first child is wrapped widget
    expect(fbDetails[xMainId]?.firstChildId, wrappedWidget.id);
  });

  test('Delete widget test', () {
    var container1 = FbContainerConfig();
    interfaceController.addChildWidget(xMainId, container1);

    var fbDetails = interfaceController.deleteWidget(container1.id);
    expect(fbDetails[container1.id], null);
  });

  test('If the input style is changed for container', () {
    var childWidget = FbContainerConfig();
    interfaceController.addChildWidget(xMainId, childWidget);

    var inputList = interfaceController.getWidgetInput(childWidget.id);
    var inputGroupData = inputList[0] as FbGroupDoubleInputs;

    var input1 = inputGroupData.input1;
    input1.value = 100.0;

    expect(childWidget.getWidgetStyles().height, 100);
  });

  test('Verify if Color is changed', () {
    var childWidget = FbContainerConfig();
    var childWidget2 = FbContainerConfig();

    int parentColor = childWidget.getWidgetStyles().colorValue;

    interfaceController.addChildWidget(xMainId, childWidget);
    interfaceController.addChildWidget(childWidget.id, childWidget2);

    var inputList = interfaceController.getWidgetInput(childWidget2.id);
    var inputGroupData = inputList[1] as FbInputDataColor;

    inputGroupData.value = int.parse('0xFFFFFFFF');

    expect(childWidget2.getWidgetStyles().colorValue, int.parse('0xFFFFFFFF'));
    //Parent color doesn't change
    expect(childWidget.getWidgetStyles().colorValue, parentColor);
  });
}

/// Wait so the id will be different,
/// Test is so fast that the id for different
/// widget which is milliseconds can be the same
/// In real app user can not create two widget at the same time
Future wait() {
  return Future.delayed(const Duration(milliseconds: 4));
}

FbWidgetDetails? getDetails(FbInterfaceController interfaceController, int widgetId) {
  return interfaceController.fbDetailsMap[widgetId];
}

bool isChildPresent(id, FbInterfaceController fbControl) {
  return fbControl.fbDetailsMap.containsKey(id) &&
      fbControl.idList.contains(id) &&
      fbControl.fbWidgetsMap.containsKey(id) &&
      fbControl.widgetStylesCallbackMap.containsKey(id);
}
