import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_column.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_container.dart';
import 'package:mockito/mockito.dart';

void main() {
  late FbInterfaceController interfaceController;

  setUp(() {
    interfaceController = FbInterfaceController();
  });

  //Test if widget is added successfully
  test('Adding Widget of widget type single success', () {
    var childWidget = FbContainerConfig();
    interfaceController.addChildWidget(111, childWidget);

    expect(
      isChildPresent(childWidget.id, interfaceController),
      true,
    );

    var isChildInParent = interfaceController.fbDetailsMap[111]?.children
        .contains(childWidget.id);
    expect(isChildInParent, true);
  });

  test('Adding Widget of widget type multiple success', () {
    var parentWidget = FbColumnConfig();
    interfaceController.addChildWidget(111, parentWidget);

    expect(
      isChildPresent(parentWidget.id, interfaceController),
      true,
    );

    bool containsChild(parentId, childId) {
      return interfaceController.fbDetailsMap[parentId]?.children
              .contains(childId) ??
          false;
    }

    var isChildInParent = containsChild(111, parentWidget.id);
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
}

bool isChildPresent(id, FbInterfaceController fbControl) {
  return fbControl.fbDetailsMap.containsKey(id) &&
      fbControl.idList.contains(id) &&
      fbControl.fbWidgetsMap.containsKey(id) &&
      fbControl.widgetStylesCallbackMap.containsKey(id);
}
