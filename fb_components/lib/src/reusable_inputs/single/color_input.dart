import 'package:color_picker_mod/color_picker_mod.dart';
import 'package:fb_components/src/widgets/box_spacing.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

class ColorInput extends StatefulWidget {
  const ColorInput({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.color,
  }) : super(key: key);

  final String title;
  final Color color;
  final ValueChanged<Color> onChanged;

  @override
  State<ColorInput> createState() => _ColorInputState();
}

class _ColorInputState extends State<ColorInput> {
  late final TextEditingController editControl;

  @override
  void initState() {
    super.initState();

    editControl = TextEditingController(
      text: getColorCode(widget.color.value),
    );
  }

  @override
  Widget build(BuildContext context) {
    var colorCode = getColorCode(widget.color.value);

    editControl.text = colorCode;

    return AppOverlayWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: context.textTheme.bodyMedium,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // To get the context of the ovelay widget on top
              Builder(builder: (context) {
                return GestureDetector(
                  onTapDown: (tapDetails) {
                    showColorPicker(context, tapDetails);
                  },
                  child: Container(
                    width: AppDimen.inputHeight,
                    height: AppDimen.inputHeight - 3,
                    decoration: AppDecoration.darkBorder(
                      color: widget.color,
                      radius: 4,
                      borderColor: Colors.white70,
                    ),
                  ),
                );
              }),
              const Box.horizontal(6),
              SizedBox(
                height: AppDimen.inputHeight,
                width: AppDimen.expandedInputWidth,
                child: TextField(
                  style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.focusedBorder,
                  ),
                  controller: editControl,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onSubmitted: (text) {
                    text = text.replaceFirst('#', '');
                    if (text.length <= 6) {
                      text = 'FF$text';
                    }

                    try {
                      var value = int.parse('0x$text');
                      widget.onChanged(Color(value));
                    } catch (e) {
                      AppLog.warn('InputSmall > onSubmitted', 'Incorrect input type  $e');
                      return;
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showColorPicker(BuildContext context, TapDownDetails tapDetails) {
    AppOverlay.showOverlay(
      context,
      position: tapDetails.globalPosition - tapDetails.localPosition,
      overlay: GestureDetector(
        onTap: () {
          //This detector is used to stop the color picker
          //area from closing on tap
        },
        child: SizedBox(
          width: 283,
          child: Card(
            child: ModColorPicker(
              pickerColor: widget.color,
              onColorChanged: (color) {
                widget.onChanged(color);

                setState(() {});
              },
              colorPickerWidth: 280,
              portraitOnly: true,
              hexInputBar: true,
              pickerAreaHeightPercent: 0.6,
            ),
          ),
        ),
      ),
    );
  }

  String getColorCode(int value) {
    var color = Color(value);

    // "Color(0xFF453a34)" split('(0xFF') gives 'FF453a34)"'
    String code = color.toString().split('(0x')[1].split(')')[0].toUpperCase();

    //This means the color has no transparency so we remove
    //To avoid confusion
    if (code.substring(0, 2) == 'FF') {
      code = code.substring(2);
    }

    return '#$code';
  }
}
