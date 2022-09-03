import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/widgets/box_spacing.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

/// This defines the style of the input that should be displayed
/// `FbInputDataDropdown<T>` tells the ui to fill the all the space horizontally
/// and mostly used for item that have multiple options to select from
class FbInputDataDropdown<T> extends BaseFbInput<T> {
  final List<Enum> list;
  final T defaultEnum;
  FbInputDataDropdown(
    String title, {
    required this.list,
    required this.defaultEnum,
  }) : super(title, defaultEnum, FbInputType.dropDownEnum);
}

/// This defines the style of the input that should be displayed
/// `FbInputDataDropdown<T>` tells the ui to fill the all the space horizontally
/// and mostly used for item that have multiple options to select from
class FbInputDataDropdownMap<T> extends BaseFbInput {
  final Map<String, T> map;
  final String defaultValue;
  FbInputDataDropdownMap(String title, {required this.map, required this.defaultValue})
      : super(title, defaultValue, FbInputType.dropDownMap);

  //Since the value is a string it needs to be converted to the main
  //real value that would be used
  T? get mapValue => map[value];
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

class _DropWrapper extends StatelessWidget {
  final BaseFbInput inputData;

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
          style: context.textTheme.bodyMedium?.copyWith(color: AppColors.focusedBorder),
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
