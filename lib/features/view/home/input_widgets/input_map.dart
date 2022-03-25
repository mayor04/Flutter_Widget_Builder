import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_group_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/view/home/input_widgets/group_input.dart';
import 'package:flutter_widget_builder/features/view/home/input_widgets/input_widget.dart';

// typedef InputMapCallback = Widget Function(FbInputBase, VoidCallback);
// typedef GroupInputMapCallback = Widget Function(FbGroupInputBase, VoidCallback);

class InputItemBox {
  // static final Map<FbInputType, InputMapCallback> input = {
  //   FbInputType.small: (FbInputBase inputData, VoidCallback onEditComplete) =>
  //       InputSmall(
  //         smallInputData: inputData.cast<FbInputDataSmall>(),
  //         onEditComplete: onEditComplete,
  //       ),
  //   FbInputType.color: (FbInputBase inputData, VoidCallback onEditComplete) =>
  //       InputColor(
  //         colorInputData: inputData.cast<FbInputDataColor>(),
  //         onEditComplete: onEditComplete,
  //       ),
  // };

  static Widget getInput({
    required FbInputBase inputData,
    required VoidCallback onEditComplete,
  }) {
    switch (inputData.inputType) {
      case FbInputType.small:
        return InputSmall(
          smallInputData: inputData.cast<FbInputDataSmall>(),
          onEditComplete: onEditComplete,
        );
      case FbInputType.color:
        return InputColor(
          colorInputData: inputData.cast<FbInputDataColor>(),
          onEditComplete: onEditComplete,
        );
      default:
        return const SizedBox();
    }
  }

  static Widget getGroupInput({
    required FbGroupInputBase inputGroup,
    required VoidCallback onEditComplete,
  }) {
    switch (inputGroup.groupType) {
      case FbGroupType.smallHW:
        return GroupInputHW(
          fbGroupData: inputGroup.cast<FbGroupHWData>(),
          onEditComplete: onEditComplete,
        );
      default:
        return const SizedBox();
    }
  }

  // static final Map<FbGroupType, GroupInputMapCallback> group = {
  //   FbGroupType.smallHW:
  //       (FbGroupInputBase fbInputGroup, VoidCallback onEditComplete) =>
  //           GroupInputHW(
  //             fbGroupData: fbInputGroup.cast<FbGroupHWData>(),
  //             onEditComplete: onEditComplete,
  //           ),
  // };
}
