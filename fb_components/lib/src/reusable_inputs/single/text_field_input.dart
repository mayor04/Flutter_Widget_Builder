import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;
  final ValueChanged<String> onChanged;

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
            width: AppDimen.dropDownInputWidth,
            child: TextField(
              maxLines: 3,
              controller: TextEditingController(
                text: value,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (text) {
                try {
                  onChanged(text);
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
