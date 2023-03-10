import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

/// This defines the style of the input that should be displayed
/// `FbInputDataSmall<T>` tells the ui to wraps content
class FbInputDataWrap<T extends num?> extends BaseFbInput<T> {
  FbInputDataWrap(String title, T value) : super(title, value, FbInputType.small);
}

class InputSmall extends StatelessWidget {
  final FbInputDataWrap smallInputData;
  final VoidCallback onEditComplete;
  const InputSmall({
    Key? key,
    required this.smallInputData,
    required this.onEditComplete,
  }) : super(key: key);

  String get valueText {
    if (smallInputData.value == null) {
      return '';
    }

    var value = smallInputData.value ?? 0;

    ///Check if double is a whole number
    if ((value % 1) == 0) {
      return value.toInt().toString();
    }

    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimen.inputBoxSmallWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            smallInputData.title,
            style: context.textTheme.bodyMedium?.copyWith(color: AppColors.stylesInputTitle),
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
                  if (text == '') {
                    smallInputData.value = null;
                  }

                  smallInputData.value = double.parse(text);
                } catch (e) {
                  AppLog.warn('InputSmall > onSubmitted', 'Incorrect input type  $e');
                  return;
                }
                onEditComplete();
              },
            ),
          ),
        ],
      ),
    );
  }
}
