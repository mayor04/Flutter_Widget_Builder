import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';

class FbGroup2Small extends FbGroupInput {
  FbGroup2Small(
    String title, {
    required FbInput input1,
    required FbInput input2,
  }) : super(title, [input1, input2], FbGroupType.small2);
}
