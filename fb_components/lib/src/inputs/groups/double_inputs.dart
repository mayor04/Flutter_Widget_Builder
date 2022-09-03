import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/inputs/single/wrap_input.dart';
import 'package:flutter/material.dart';

///This groups two inputs together
///For example this groups the height and width in the same row
class FbGroupDoubleInputs extends BaseFbGroupInput {
  final FbInputDataWrap input1;
  final FbInputDataWrap input2;

  FbGroupDoubleInputs(
    String title, {
    required this.input1,
    required this.input2,
  }) : super(title, [input1, input2], FbGroupType.smallHW);
}

class GroupInputHW extends StatelessWidget {
  final FbGroupDoubleInputs fbGroupData;
  final VoidCallback onEditComplete;
  const GroupInputHW({
    Key? key,
    required this.fbGroupData,
    required this.onEditComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InputSmall(
          smallInputData: fbGroupData.input1,
          onEditComplete: onEditComplete,
        ),
        InputSmall(
          smallInputData: fbGroupData.input2,
          onEditComplete: onEditComplete,
        ),
      ],
    );
  }
}
