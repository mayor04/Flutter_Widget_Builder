import 'package:fb_components/src/params/input_params/input_params.dart';
import 'package:fb_components/src/params/widget/params_picker.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:super_overlay/super_overlay.dart';

class TextFieldInput extends StatefulWidget {
  const TextFieldInput({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.value,
    required this.styleName,
    required this.globalParams,
    required this.onParamsSelected,
    required this.onParamsRemoved,
  }) : super(key: key);

  final String title;
  final String value;
  final String styleName;
  final ValueChanged<String> onChanged;

  final Map<String, InputParams> globalParams;
  final Function(String key, String paramsId) onParamsSelected;
  final Function(String key) onParamsRemoved;

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  late final controller = TextEditingController(
    text: widget.value,
  );

  final overlayController = OverlayController<String>();

  @override
  Widget build(BuildContext context) {
    return ParamsPicker(
      styleName: widget.styleName,
      globalParams: widget.globalParams,
      onParamsSelected: widget.onParamsSelected,
      onParamsRemoved: widget.onParamsRemoved,
      child: Padding(
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
      ),
    );
  }
}
