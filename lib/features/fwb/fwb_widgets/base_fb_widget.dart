import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/enum/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';

///This abstract class is the base class for every widget
///Extends this class to add more functionality
///`FBcontainer extends FBwidget`
abstract class FbWidget<T extends FbWidgetConfig> {
  final int id = DateTime.now().millisecondsSinceEpoch;
  final FbWidgetType widgetType;
  final FbChildType childType;

  FbWidget(this.widgetType, this.childType);

  //This method should be used somewhereelse due to testing
  // Widget builder(dynamic widget);

  String generateCode(String child);

  T getWidgetConfig();

  List<FbInput> getInputs();
}

abstract class FbWidgetConfig {
  final int id;
  final FbWidgetType widgetType;

  FbWidgetConfig(this.id, this.widgetType);
}
