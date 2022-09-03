import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

/// This defines the style of the input that should be displayed
/// `FbInputDataExpanded<T>` tells the ui to fill the all the space horizontally
class FbInputDataExpanded<T extends num?> extends BaseFbInput<T> {
  FbInputDataExpanded(String title, T value) : super(title, value, FbInputType.expanded);
}

class InputExpanded extends StatelessWidget {
  final FbInputDataExpanded expandedInputData;
  final VoidCallback onEditComplete;
  const InputExpanded({
    Key? key,
    required this.expandedInputData,
    required this.onEditComplete,
  }) : super(key: key);

  String get valueText {
    var value = expandedInputData.value ?? 0;

    ///Check if double is a whole number
    if ((value % 1) == 0) {
      return value.toInt().toString();
    }

    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          expandedInputData.title,
          style: context.textTheme.bodyMedium,
        ),
        SizedBox(
          height: AppDimen.inputHeight,
          width: AppDimen.expandedInputWidth,
          child: TextField(
            controller: TextEditingController(
              text: valueText,
            ),
            onSubmitted: (text) {
              try {
                if (text == '') {
                  expandedInputData.value = null;
                }

                expandedInputData.value = double.parse(text);
              } catch (e) {
                AppLog.warn('InputExpanded > onSubmitted', 'Incorrect input type  $e');
                return;
              }
              onEditComplete();
            },
          ),
        ),
      ],
    );
  }
}
