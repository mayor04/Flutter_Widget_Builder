// import 'package:fb_core/fb_core.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';

// ///This groups two inputs together
// ///For example this groups the height and width in the same row
// class FbGroupDoubleInputs extends BaseFbGroupInput {
//   final FbInputDataWrap input1;
//   final FbInputDataWrap input2;

//   FbGroupDoubleInputs(
//     String title, {
//     required this.input1,
//     required this.input2,
//   }) : super(title, [input1, input2], FbGroupType.smallHW);
// }

// ///This groups has multiple sub inputs
// class FbGroupMultipleInputs extends BaseFbGroupInput {
//   List<BaseFbInput> fbInputs;

//   FbGroupMultipleInputs(
//     String title, {
//     required this.fbInputs,
//   }) : super(title, fbInputs, FbGroupType.multiple);

//   BaseFbInput inputAt(int index) {
//     var input = fbInputs.itemAt(index);

//     if (input == null) {
//       throw (Exception('Range Error: Unable to get input at $index for fb multiple'));
//     }

//     return input;
//   }
// }
