import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/all.dart';
import 'package:flutter_widget_builder/features/view/create_page/widgets/widget_mapper.dart';

void main() {
  testWidgets('Test if container is rendered correctly',
      (WidgetTester tester) async {
    var containerStyles = FbContainerStyles(
      101,
      FbWidgetType.container,
      height: 100,
      width: 100,
      colorValue: Colors.red.value,
      alignment: Alignment.center,
      pad: [2, 0, 0, 0],
      marg: [0, 0, 5, 0],
      radius: 10,
      borderSize: 2,
      borderColor: Colors.blue.value,
    );

    // Build our app and trigger a frame.
    // Any error in build makes the test stop working
    await tester.pumpWidget(createDisplayApp(
      child: SingleChildWidgetMapper(
        child: const SizedBox(),
        widgetStyles: containerStyles,
      ),
    ));

    // Verify that our counter starts at 0.
    var firstCont = find.byKey(ValueKey('display_${containerStyles.id}'));
    expect(firstCont, findsOneWidget);

    var wid = tester.firstWidget<Container>(firstCont);
    expect((wid.decoration as BoxDecoration).color?.value, Colors.red.value);

    //Edge inset geometry
    expect((wid.padding as EdgeInsets).left, 2);
    expect((wid.margin as EdgeInsets).right, 5);
  });
}

createDisplayApp({required Widget child}) {
  return MaterialApp(
    title: 'Testing flutter',
    home: Scaffold(
      body: Center(
        child: child,
      ),
    ),
  );
}
