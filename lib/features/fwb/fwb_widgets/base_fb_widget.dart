import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/enum/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';

///This abstract class is the base class for every widget
///Extends this class to add more functionality
///`FBcontainer extends FBwidget`
abstract class FbWidgetConfig<T extends FbWidgetData> {
  final int id = DateTime.now().millisecondsSinceEpoch;
  final FbWidgetType widgetType;
  final FbChildType childType;

  FbWidgetConfig(this.widgetType, this.childType);

  //This method should be used somewhereelse due to testing
  // Widget builder(dynamic widget);

  String generateCode(String child);

  T getWidgetData();

  List<FbInputBase> getInputs();
}

///Each WidgetConfig contains a data, this data is used
///for displaying the Widget on the screen
abstract class FbWidgetData {
  final int id;
  final FbWidgetType widgetType;

  FbWidgetData(this.id, this.widgetType);
}
