import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/constant/dimension.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/core/utils/formatters.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/widget/box_spacing.dart';

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

class InputDropdown extends StatefulWidget {
  final FbInputDataDropdown<Enum> dropDownInputData;
  final VoidCallback onEditComplete;
  const InputDropdown({
    Key? key,
    required this.dropDownInputData,
    required this.onEditComplete,
  }) : super(key: key);

  @override
  State<InputDropdown> createState() => _InputDropdownState();
}

class InputDropdownMap extends StatefulWidget {
  final FbInputDataDropdownMap dropDownMap;
  final VoidCallback onEditComplete;
  const InputDropdownMap({
    Key? key,
    required this.dropDownMap,
    required this.onEditComplete,
  }) : super(key: key);

  @override
  State<InputDropdownMap> createState() => _InputDropdownMapState();
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
                AppLog.warn(
                    'InputExpanded > onSubmitted', 'Incorrect input type  $e');
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

class InputLTRB extends StatelessWidget {
  final FbInputDataLTRB ltrbInputData;
  final VoidCallback onEditComplete;
  const InputLTRB({
    Key? key,
    required this.ltrbInputData,
    required this.onEditComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> lt = ['L', 'T', 'R', 'B'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              ltrbInputData.title,
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
        const Box.vertical(15),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: List.generate(lt.length, (i) {
              return SizedBox(
                height: AppDimen.inputHeight,
                width: AppDimen.smallInputWidth,
                child: TextField(
                  controller: TextEditingController(
                    text: valueAt(i),
                  ),
                  decoration: InputDecoration(
                    hintText: lt[i],
                  ),
                  onSubmitted: (text) {
                    try {
                      if (text == '') {
                        ltrbInputData.value?[i] = 0;
                      }

                      ltrbInputData.value?[i] = double.parse(text);
                    } catch (e) {
                      AppLog.warn('InputSmall > onSubmitted',
                          'Incorrect input type  $e');
                      return;
                    }
                    onEditComplete();
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  String valueAt(int i) {
    if (ltrbInputData.value == null) {
      return '';
    }

    var value = (ltrbInputData.value?.itemAt(i) as num?) ?? 0;

    ///Check if double is a whole number
    if ((value % 1) == 0) {
      return value.toInt().toString();
    }

    return value.toString();
  }
}

class InputSmall extends StatelessWidget {
  final FbInputDataSmall smallInputData;
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
            style: context.textTheme.bodyMedium
                ?.copyWith(color: AppColors.stylesInputTitle),
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
                  AppLog.warn(
                      'InputSmall > onSubmitted', 'Incorrect input type  $e');
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
                AppLog.warn(
                    'InputExpanded > onSubmitted', 'Incorrect input type  $e');
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

class _DropItem extends StatelessWidget {
  final String itemEnum;

  final String defaultEnum;
  const _DropItem({
    Key? key,
    required this.itemEnum,
    required this.defaultEnum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (itemEnum == defaultEnum) {
      return Row(
        children: [
          Text(
            itemEnum,
            style: context.textTheme.bodyMedium,
          ),
          const Box.horizontal(6),
          Container(
            padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
            decoration: AppDecoration.radius(
              color: AppColors.focusedBorder.withOpacity(0.3),
              radius: 2,
            ),
            child: Text(
              'd',
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 8,
              ),
            ),
          )
        ],
      );
    }

    return Text(
      itemEnum,
      style: context.textTheme.bodyMedium,
    );
  }
}

class _DropWrapper extends StatelessWidget {
  final FbInputBase inputData;

  final Widget child;
  const _DropWrapper({
    Key? key,
    required this.inputData,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          inputData.title,
          style: context.textTheme.bodyMedium
              ?.copyWith(color: AppColors.focusedBorder),
        ),
        Container(
          height: AppDimen.inputHeight,
          width: AppDimen.dropDownInputWidth,
          decoration: AppDecoration.lightBorder(
            color: AppColors.appDark.withOpacity(0.7),
          ),
          padding: const EdgeInsets.fromLTRB(6, 0, 3, 0),
          child: child,
        ),
      ],
    );
  }
}

// ignore: unused_element
class _ErrorInputBox extends StatelessWidget {
  const _ErrorInputBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'The wrong input type was received',
      style: context.textTheme.bodyMedium,
    );
  }
}

class _InputColorState extends State<InputColor> {
  late FbInputDataColor colorInputData;
  late final TextEditingController editControl;

  @override
  Widget build(BuildContext context) {
    colorInputData = widget.colorInputData;
    var colorCode = getColorCode(colorInputData.value);

    editControl.text = colorCode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.colorInputData.title,
          style: context.textTheme.bodyMedium,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppDimen.inputHeight,
              height: AppDimen.inputHeight - 3,
              decoration: AppDecoration.darkBorder(
                color: Color(colorInputData.value),
                radius: 4,
                borderColor: Colors.white70,
              ),
            ),
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
                    AppLog.warn(
                        'InputSmall > onSubmitted', 'Incorrect input type  $e');
                    return;
                  }

                  widget.onEditComplete();
                },
              ),
            ),
          ],
        ),
      ],
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

class _InputDropdownMapState extends State<InputDropdownMap> {
  late FbInputDataDropdownMap inputData;

  @override
  Widget build(BuildContext context) {
    inputData = widget.dropDownMap;

    return _DropWrapper(
      inputData: inputData,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: inputData.value,
          onChanged: (text) {
            inputData.value = text!;

            setState(() {});
            widget.onEditComplete();
          },
          focusColor: Colors.transparent,
          items: inputData.map.keys
              .map((element) => DropdownMenuItem<String>(
                    value: element,
                    child: _DropItem(
                      itemEnum: element,
                      defaultEnum: inputData.defaultValue,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _InputDropdownState extends State<InputDropdown> {
  late FbInputDataDropdown<Enum> inputData;

  @override
  Widget build(BuildContext context) {
    inputData = widget.dropDownInputData;

    return _DropWrapper(
      inputData: inputData,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Enum>(
          isExpanded: true,
          value: inputData.value,
          onChanged: (text) {
            inputData.value = text!;

            setState(() {});
            widget.onEditComplete();
          },
          focusColor: Colors.transparent,
          items: widget.dropDownInputData.list
              .map((element) => DropdownMenuItem<Enum>(
                    value: element,
                    child: _DropItem(
                      itemEnum: element.name,
                      defaultEnum: inputData.defaultEnum.name,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
