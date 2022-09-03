import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:flutter/material.dart';

import 'groups/double_inputs.dart';
import 'groups/multiple_inputs.dart';
import 'single/color_input.dart';
import 'single/dropdown_input.dart';
import 'single/expanded_input.dart';
import 'single/ltrb_input.dart';
import 'single/text_input.dart';
import 'single/wrap_input.dart';

class FbInputFactory {
  static Widget getInput({
    required BaseFbInput inputData,
    required VoidCallback onEditComplete,
  }) {
    switch (inputData.inputType) {
      case FbInputType.small:
        return InputSmall(
          smallInputData: inputData.cast<FbInputDataWrap>(),
          onEditComplete: onEditComplete,
        );
      case FbInputType.expanded:
        return InputExpanded(
          expandedInputData: inputData.cast<FbInputDataExpanded>(),
          onEditComplete: onEditComplete,
        );
      case FbInputType.color:
        return InputColor(
          colorInputData: inputData.cast<FbInputDataColor>(),
          onEditComplete: onEditComplete,
        );
      case FbInputType.dropDownEnum:
        return InputDropdown(
          dropDownInputData: inputData.cast<FbInputDataDropdown<Enum>>(),
          onEditComplete: onEditComplete,
        );
      case FbInputType.dropDownMap:
        return InputDropdownMap(
          dropDownMap: inputData.cast<FbInputDataDropdownMap>(),
          onEditComplete: onEditComplete,
        );
      case FbInputType.ltrb:
        return InputLTRB(
          ltrbInputData: inputData.cast<FbInputDataLTRB>(),
          onEditComplete: onEditComplete,
        );
      case FbInputType.text:
        return InputText(
          textInputData: inputData.cast<FbInputDataText>(),
          onEditComplete: onEditComplete,
        );
      default:
        return const SizedBox();
    }
  }

  static Widget getGroupInput({
    required BaseFbGroupInput inputGroup,
    required VoidCallback onEditComplete,
  }) {
    switch (inputGroup.groupType) {
      case FbGroupType.smallHW:
        return GroupInputHW(
          fbGroupData: inputGroup.cast<FbGroupDoubleInputs>(),
          onEditComplete: onEditComplete,
        );
      case FbGroupType.multiple:
        return GroupInputMultiple(
          fbGroupData: inputGroup.cast<FbGroupMultipleInputs>(),
          onEditComplete: onEditComplete,
        );
      default:
        return const SizedBox();
    }
  }
}
