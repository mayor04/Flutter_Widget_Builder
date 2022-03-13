import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/dimension.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/widget/box_spacing.dart';

class InputSmall extends StatelessWidget {
  final FbInputDataSmall smallInputData;
  const InputSmall({
    Key? key,
    required this.smallInputData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimen.inputBoxSmallWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            smallInputData.title,
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(
            height: AppDimen.inputHeight,
            width: AppDimen.smallInputWidth,
            child: TextField(),
          ),
        ],
      ),
    );
  }
}

class InputLTRB extends StatelessWidget {
  final FbInputDataLTRB ltrbInputData;
  const InputLTRB({
    Key? key,
    required this.ltrbInputData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              ltrbInputData.title,
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
        const Box.vertical(10),
        Row(
          children: ['L', 'T', 'R', 'B'].map((e) {
            return const Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: SizedBox(
                  height: AppDimen.inputHeight,
                  width: AppDimen.smallInputWidth,
                  child: TextField(),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class InputExpanded extends StatelessWidget {
  final FbInputDataExpanded expandedInputData;
  const InputExpanded({
    Key? key,
    required this.expandedInputData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          expandedInputData.title,
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(
          height: AppDimen.inputHeight,
          width: AppDimen.expandedInputWidth,
          child: TextField(),
        ),
      ],
    );
  }
}

class _ErrorInputBox extends StatelessWidget {
  const _ErrorInputBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'The wrong input type was received',
      style: context.textTheme.bodyMedium,
    );
  }
}
