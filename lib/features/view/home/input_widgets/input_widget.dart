import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/dimension.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/widget/box_spacing.dart';

class InputSmall extends StatelessWidget {
  final FbInputDataSmall smallInputData;
  final VoidCallback onEditComplete;
  const InputSmall({
    Key? key,
    required this.smallInputData,
    required this.onEditComplete,
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
          SizedBox(
            height: AppDimen.inputHeight,
            width: AppDimen.smallInputWidth,
            child: TextField(
              controller: TextEditingController(
                text: valueText,
              ),
              onSubmitted: (text) {
                try {
                  smallInputData.value = double.parse(text);
                } catch (e) {
                  AppLog.warn(
                      'InputSmall > onSubmitted', 'Incorrect input type  $e');
                }
                onEditComplete();
              },
            ),
          ),
        ],
      ),
    );
  }

  String get valueText {
    var value = (smallInputData.value as num?) ?? 0;

    ///Check if double is a whole number
    if ((value % 1) == 0) {
      return value.toInt().toString();
    }

    return value.toString();
  }
}

class InputLTRB extends StatelessWidget {
  final FbInputDataLTRB ltrbInputData;
  final VoidCallback onEditComplete;
  const InputLTRB({
    Key? key,
    required this.ltrbInputData,
    required this.onEditComplete,
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
  final VoidCallback onEditComplete;
  const InputExpanded({
    Key? key,
    required this.expandedInputData,
    required this.onEditComplete,
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
