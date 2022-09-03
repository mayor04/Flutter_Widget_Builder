import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';

/// This abstract class is the base class for every widget
/// Extends this class to add more functionality
///`FBcontainerConfig extends FBwidgetConfig`
abstract class BaseFbConfig<T extends BaseFbStyles> {
  final int id = DateTime.now().millisecondsSinceEpoch;
  final FbWidgetType widgetType;
  final FbChildType childType;

  BaseFbConfig(this.widgetType, this.childType);

  // This method should be used somewhereelse due to testing
  // Widget builder(dynamic widget);

  String generateCode(String child);

  List<BaseFbInput> getInputs();

  T getWidgetStyles();
}

/// Each WidgetConfig contains a data, this data is used
/// for displaying the Widget on the screen
abstract class BaseFbStyles {
  final int id;
  final FbWidgetType widgetType;

  BaseFbStyles(this.id, this.widgetType);

  A cast<A extends BaseFbStyles>() {
    if (this is A) {
      return this as A;
    }

    throw Exception('Unable to cast $A to type FbInputData');
  }
}
