import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

class SmallInput extends StatelessWidget {
  const SmallInput({
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
    return SizedBox(
      width: AppDimen.inputBoxSmallWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(color: AppColors.stylesInputTitle),
          ),
          SizedBox(
            height: AppDimen.inputHeight,
            width: AppDimen.smallInputWidth,
            child: TextField(
              controller: TextEditingController(
                text: valueText(value),
              ),
              onSubmitted: (text) {
                try {
                  if (text == '') {
                    onChanged(null);
                  }

                  onChanged(double.parse(text));
                } catch (e) {
                  AppLog.warn('InputSmall > onSubmitted', 'Incorrect input type  $e');
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
