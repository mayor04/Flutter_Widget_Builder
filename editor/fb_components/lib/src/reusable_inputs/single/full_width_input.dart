import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

class FullWidthInput extends StatelessWidget {
  const FullWidthInput({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final String title;
  final num? value;
  final ValueChanged<num?> onChanged;

  String valueText(num? value) {
    if (value == null) {
      return '';
    }

    var val = value;

    ///Check if double is a whole number
    if ((val % 1) == 0) {
      return val.toInt().toString();
    }

    return val.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 15, 13, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium,
          ),
          SizedBox(
            height: AppDimen.inputHeight,
            width: AppDimen.expandedInputWidth,
            child: TextField(
              controller: TextEditingController(
                text: value.toString(),
              ),
              onSubmitted: (text) {
                try {
                  if (text == '') {
                    onChanged(null);
                  }

                  onChanged(double.parse(text));
                } catch (e) {
                  AppLog.warn('InputExpanded > onSubmitted', 'Incorrect input type  $e');
                  return;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
