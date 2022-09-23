import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/app.dart';
import 'package:flutter_widget_builder/features/widget_creator/controller/interface_controller.dart';

void main() {
  runApp(MyApp(
    fbController: FbInterfaceController(),
  ));
}
