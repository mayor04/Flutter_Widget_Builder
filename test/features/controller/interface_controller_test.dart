import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/fb_container.dart';
import 'package:mockito/mockito.dart';

void main() {
  FbInterfaceController interfaceController = FbInterfaceController();
  //Test if widget is added successfully
  test('Adding Widget Success', () {
    var childWidget = FbContainer();
    interfaceController.addChildWidget(111, childWidget);

    expect(
      isChildPresent(childWidget.id, interfaceController),
      true,
    );

    var isChildInParent =
        interfaceController.fbData[111]?.children.contains(childWidget.id);
    expect(isChildInParent, true);
  });
}

bool isChildPresent(id, FbInterfaceController fbControl) {
  return fbControl.fbData.containsKey(id) &&
      fbControl.idList.contains(id) &&
      fbControl.fbWidgets.containsKey(id) &&
      fbControl.widgetConfig.containsKey(id);
}
