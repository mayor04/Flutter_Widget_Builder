import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_builder/core/constant/constant.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_group_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_column_config.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_container_config.dart';

void main() {
  late FbInterfaceController interfaceController;

  setUp(() {
    interfaceController = FbInterfaceController();
  });

  //Test if widget is added successfully
  test('Adding Widget of widget type single success', () {
    var childWidget = FbContainerConfig();
    interfaceController.addChildWidget(xMainId, childWidget);

    expect(
      isChildPresent(childWidget.id, interfaceController),
      true,
    );

    var isChildInParent = interfaceController.fbDetailsMap[xMainId]?.children
        .contains(childWidget.id);
    expect(isChildInParent, true);
  });

  test('Adding Widget of widget type multiple success', () {
    var parentWidget = FbColumnConfig();
    interfaceController.addChildWidget(xMainId, parentWidget);

    expect(
      isChildPresent(parentWidget.id, interfaceController),
      true,
    );

    bool containsChild(parentId, childId) {
      return interfaceController.fbDetailsMap[parentId]?.children
              .contains(childId) ??
          false;
    }

    var isChildInParent = containsChild(xMainId, parentWidget.id);
    expect(isChildInParent, true);

    var firstChild = FbContainerConfig();
    interfaceController.addChildWidget(parentWidget.id, firstChild);
    var secondChild = FbContainerConfig();
    interfaceController.addChildWidget(parentWidget.id, secondChild);

    var canAcceptMultipleChild =
        containsChild(parentWidget.id, firstChild.id) &&
            containsChild(parentWidget.id, secondChild.id);

    expect(canAcceptMultipleChild, true);
  });

  test('If the input style is changed for container', () {
    var childWidget = FbContainerConfig();
    interfaceController.addChildWidget(xMainId, childWidget);

    var inputList = interfaceController.getWidgetInput(childWidget.id);
    var inputGroupData = inputList[0] as FbGroupHWData;

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

bool isChildPresent(id, FbInterfaceController fbControl) {
  return fbControl.fbDetailsMap.containsKey(id) &&
      fbControl.idList.contains(id) &&
      fbControl.fbWidgetsMap.containsKey(id) &&
      fbControl.widgetStylesCallbackMap.containsKey(id);
}
