import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_group_inputs.dart';
import 'package:flutter_widget_builder/features/view/home/input_widgets/input_widget.dart';

class GroupInputHW extends StatelessWidget {
  final FbGroupHWData fbGroupData;
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
