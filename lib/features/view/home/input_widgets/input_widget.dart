import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/dimension.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/widget/box_spacing.dart';

class InputSmall extends StatelessWidget {
  const InputSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimen.inputBoxSmallWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Width',
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
  const InputLTRB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              'Style',
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
  const InputExpanded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Style',
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
