import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_builder/core/constant/constant.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_group_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_column_config.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_container_config.dart';
import 'package:mockito/mockito.dart';

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

    expect(inputList[0].value[0].value, 100);
  });
}

bool isChildPresent(id, FbInterfaceController fbControl) {
  return fbControl.fbDetailsMap.containsKey(id) &&
      fbControl.idList.contains(id) &&
      fbControl.fbWidgetsMap.containsKey(id) &&
      fbControl.widgetStylesCallbackMap.containsKey(id);
}
