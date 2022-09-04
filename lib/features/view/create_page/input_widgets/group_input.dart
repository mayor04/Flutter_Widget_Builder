// import 'package:fb_components/fb_components.dart';
// import 'package:fb_core/fb_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_group_inputs.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
// import 'package:flutter_widget_builder/features/view/create_page/input_widgets/input_map.dart';
// import 'package:flutter_widget_builder/features/view/create_page/input_widgets/input_widget.dart';
// import 'package:flutter_widget_builder/widget/box_spacing.dart';

// class GroupInputHW extends StatelessWidget {
//   final FbGroupDoubleInputs fbGroupData;
//   final VoidCallback onEditComplete;
//   const GroupInputHW({
//     Key? key,
//     required this.fbGroupData,
//     required this.onEditComplete,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         InputSmall(
//           smallInputData: fbGroupData.input1,
//           onEditComplete: onEditComplete,
//         ),
//         InputSmall(
//           smallInputData: fbGroupData.input2,
//           onEditComplete: onEditComplete,
//         ),
//       ],
//     );
//   }
// }

// class GroupInputMultiple extends StatelessWidget {
//   final FbGroupMultipleInputs fbGroupData;
//   final VoidCallback onEditComplete;
//   const GroupInputMultiple({
//     Key? key,
//     required this.fbGroupData,
//     required this.onEditComplete,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
//           child: Row(
//             children: [
//               Text(
//                 fbGroupData.title,
//                 style: context.textTheme.bodyMedium,
//               ),
//             ],
//           ),
//         ),
//         const Box.vertical(15),
//         Container(
//           color: AppColors.groupBg,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ...allInputs(fbGroupData),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   List<Widget> allInputs(FbGroupMultipleInputs fbGroupData) {
//     return List.generate(fbGroupData.fbInputs.length, (index) {
//       BaseFbInput fbInputBase = fbGroupData.fbInputs[index];

//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(13, 10, 13, 10),
//             child: Builder(
//               builder: (context) {
//                 if (fbInputBase.inputType == FbInputType.group) {
//                   BaseFbGroupInput groupData = fbInputBase as BaseFbGroupInput;

//                   return InputItemBox.getGroupInput(
//                     inputGroup: groupData,
//                     onEditComplete: onEditComplete,
//                   );
//                 }

//                 return InputItemBox.getInput(
//                   inputData: fbInputBase,
//                   onEditComplete: onEditComplete,
//                 );
//               },
//             ),
//           ),
//           const Divider(),
//         ],
//       );
//     });
//   }
// }
