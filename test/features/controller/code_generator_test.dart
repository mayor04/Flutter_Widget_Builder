import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_builder/features/widget_creator/controller/code_genarator_controller.dart';
import 'package:flutter_widget_builder/features/widget_creator/controller/interface_controller.dart';

import '../../general/wait.dart';

void main() {
  late InterfaceController interfaceController;
  late CodeGeneratorController codeGeneratorController;

  setUp(() {
    interfaceController = InterfaceController();
    codeGeneratorController = CodeGeneratorController(interfaceController);
  });

  test('Generating code does not throw error', () async {
    final container1 = FbContainerConfig();
    await wait();
    final container2 = FbContainerConfig();
    await wait();
    final container3 = FbContainerConfig();

    interfaceController.addChildWidget(xMainId, container1);
    interfaceController.addChildWidget(container1.id, container2);
    interfaceController.addChildWidget(container2.id, container3);

    print(codeGeneratorController.getCode());
  });
}
