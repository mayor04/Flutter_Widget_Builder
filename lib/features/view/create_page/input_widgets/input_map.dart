// import 'package:flutter/material.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_group_inputs.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
// import 'package:flutter_widget_builder/features/view/create_page/input_widgets/group_input.dart';
// import 'package:flutter_widget_builder/features/view/create_page/input_widgets/input_widget.dart';

// class InputItemBox {
//   static Widget getInput({
//     required BaseFbInput inputData,
//     required VoidCallback onEditComplete,
//   }) {
//     switch (inputData.inputType) {
//       case FbInputType.small:
//         return InputSmall(
//           smallInputData: inputData.cast<FbInputDataWrap>(),
//           onEditComplete: onEditComplete,
//         );
//       case FbInputType.expanded:
//         return InputExpanded(
//           expandedInputData: inputData.cast<FbInputDataExpanded>(),
//           onEditComplete: onEditComplete,
//         );
//       case FbInputType.color:
//         return InputColor(
//           colorInputData: inputData.cast<FbInputDataColor>(),
//           onEditComplete: onEditComplete,
//         );
//       case FbInputType.dropDownEnum:
//         return InputDropdown(
//           dropDownInputData: inputData.cast<FbInputDataDropdown<Enum>>(),
//           onEditComplete: onEditComplete,
//         );
//       case FbInputType.dropDownMap:
//         return InputDropdownMap(
//           dropDownMap: inputData.cast<FbInputDataDropdownMap>(),
//           onEditComplete: onEditComplete,
//         );
//       case FbInputType.ltrb:
//         return InputLTRB(
//           ltrbInputData: inputData.cast<FbInputDataLTRB>(),
//           onEditComplete: onEditComplete,
//         );
//       case FbInputType.text:
//         return InputText(
//           textInputData: inputData.cast<FbInputDataText>(),
//           onEditComplete: onEditComplete,
//         );
//       default:
//         return const SizedBox();
//     }
//   }

//   static Widget getGroupInput({
//     required BaseFbGroupInput inputGroup,
//     required VoidCallback onEditComplete,
//   }) {
//     switch (inputGroup.groupType) {
//       case FbGroupType.smallHW:
//         return GroupInputHW(
//           fbGroupData: inputGroup.cast<FbGroupDoubleInputs>(),
//           onEditComplete: onEditComplete,
//         );
//       case FbGroupType.multiple:
//         return GroupInputMultiple(
//           fbGroupData: inputGroup.cast<FbGroupMultipleInputs>(),
//           onEditComplete: onEditComplete,
//         );
//       default:
//         return const SizedBox();
//     }
//   }
// }
