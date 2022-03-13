import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_group_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/view/home/input_widgets/group_input.dart';
import 'package:flutter_widget_builder/features/view/home/input_widgets/input_widget.dart';

class InputMap {
  static final Map<FbInputType, Widget Function(FbInputBase)> input = {
    FbInputType.small: (FbInputBase inputData) => InputSmall(
          smallInputData: inputData.cast<FbInputDataSmall>(),
        ),
  };

  static final Map<FbGroupType, Widget Function(FbGroupInputBase)> group = {
    FbGroupType.smallHW: (FbGroupInputBase fbInputGroup) => GroupInputHW(
          fbGroupData: fbInputGroup.cast<FbGroupHWData>(),
        ),
  };
}
