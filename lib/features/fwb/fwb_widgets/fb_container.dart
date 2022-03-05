import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_builder/core/enum/fb_enum.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_widget.dart';

class FbContainer extends FbWidget {
  FbContainer() : super(FbWidgetType.container, FbChildType.single);

  @override
  String generateCode(String child) {
    // TODO: implement generateCode
    throw UnimplementedError();
  }

  @override
  FbWidgetConfig getWidgetConfig() {
    // TODO: implement widgetConfig
    throw UnimplementedError();
  }
}

class FbContainerConfig extends FbWidgetConfig {
  FbContainerConfig(int id, FbWidgetType widgetType) : super(id, widgetType);
}
