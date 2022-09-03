import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

///This defines the style of the input that should be displayed
///`FbInputDataText<T>` is used for mostly input that requires a text
class FbInputDataText extends BaseFbInput<String> {
  FbInputDataText(String title, String value) : super(title, value, FbInputType.text);
}

class InputText extends StatelessWidget {
  final FbInputDataText textInputData;
  final VoidCallback onEditComplete;
  const InputText({
    Key? key,
    required this.textInputData,
    required this.onEditComplete,
  }) : super(key: key);

  String get valueText {
    return textInputData.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textInputData.title,
          style: context.textTheme.bodyMedium,
        ),
        SizedBox(
          width: AppDimen.dropDownInputWidth,
          child: TextField(
            maxLines: 3,
            controller: TextEditingController(
              text: valueText,
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10),
            ),
            onChanged: (text) {
              try {
                textInputData.value = text;
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
