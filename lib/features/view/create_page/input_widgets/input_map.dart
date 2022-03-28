import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_group_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/view/create_page/input_widgets/group_input.dart';
import 'package:flutter_widget_builder/features/view/create_page/input_widgets/input_widget.dart';

class InputItemBox {
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
      case FbInputType.expnaded:
        return InputExpanded(
          expandedInputData: inputData.cast<FbInputDataExpanded>(),
          onEditComplete: onEditComplete,
        );
      case FbInputType.color:
        return InputColor(
          colorInputData: inputData.cast<FbInputDataColor>(),
          onEditComplete: onEditComplete,
        );
      case FbInputType.dropdown:
        return InputDropdown(
          dropDownInputData: inputData.cast<FbInputDataDropdown>(),
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
}
