import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
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
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  late final controller = TextEditingController(
    text: widget.value,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 15, 13, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: context.textTheme.bodyMedium,
          ),
          SizedBox(
            width: AppDimen.dropDownInputWidth,
            child: TextField(
              maxLines: 3,
              controller: controller,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (text) {
                try {
                  widget.onChanged(text);
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
