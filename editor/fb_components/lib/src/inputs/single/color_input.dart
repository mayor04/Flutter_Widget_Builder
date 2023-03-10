import 'package:color_picker_mod/color_picker_mod.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/widgets/box_spacing.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

///This defines the style of inputs that allows color selection
///`FbInputDataColor<T>` tells the ui to fill the all the space horizontally
class FbInputDataColor extends BaseFbInput<int> {
  FbInputDataColor(String title, int value) : super(title, value, FbInputType.color);
}

class InputColor extends StatefulWidget {
  final FbInputDataColor colorInputData;
  final VoidCallback onEditComplete;
  const InputColor({
    Key? key,
    required this.colorInputData,
    required this.onEditComplete,
  }) : super(key: key);

  @override
  State<InputColor> createState() => _InputColorState();
}

class _InputColorState extends State<InputColor> {
  late FbInputDataColor colorInputData;
  late final TextEditingController editControl;

  @override
  Widget build(BuildContext context) {
    colorInputData = widget.colorInputData;
    var colorCode = getColorCode(colorInputData.value);

    editControl.text = colorCode;

    return AppOverlayWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.colorInputData.title,
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
                      color: Color(colorInputData.value),
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
                      colorInputData.value = value;
                      setState(() {});
                    } catch (e) {
                      AppLog.warn('InputSmall > onSubmitted', 'Incorrect input type  $e');
                      return;
                    }

                    widget.onEditComplete();
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
              pickerColor: Color(colorInputData.value),
              onColorChanged: (color) {
                colorInputData.value = color.value;
                setState(() {});

                widget.onEditComplete();
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

  @override
  void initState() {
    super.initState();
    colorInputData = widget.colorInputData;

    editControl = TextEditingController(
      text: getColorCode(colorInputData.value),
    );
  }
}
