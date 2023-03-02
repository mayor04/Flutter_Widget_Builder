import 'package:fb_components/src/widgets/box_spacing.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

class DropdownInput<T extends Object?> extends StatefulWidget {
  const DropdownInput({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.value,
    required this.dropdownList,
    required this.getName,
    this.defaultValue,
  }) : super(key: key);

  final String title;
  final T value;
  final T? defaultValue;
  final List<T> dropdownList;
  final ValueChanged<T?> onChanged;
  final String Function(T) getName;

  @override
  State<DropdownInput<T>> createState() => _DropdownInputState<T>();
}

class _DropdownInputState<T extends Object?> extends State<DropdownInput<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 15, 13, 15),
      child: _DropWrapper(
        title: widget.title,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            isExpanded: true,
            value: widget.value,
            onChanged: (value) {
              if (value == null) {
                widget.onChanged(widget.defaultValue);
              }

              widget.onChanged(value);
            },
            focusColor: Colors.transparent,
            items: widget.dropdownList
                .map((element) => DropdownMenuItem<T>(
                      value: element,
                      child: _DropItem(
                        itemName: widget.getName(element),
                        defaultItemName:
                            widget.defaultValue == null ? '' : widget.getName(widget.defaultValue!),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

// class InputDropdownMap extends StatefulWidget {
//   final FbInputDataDropdownMap dropDownMap;
//   final VoidCallback onEditComplete;
//   const InputDropdownMap({
//     Key? key,
//     required this.dropDownMap,
//     required this.onEditComplete,
//   }) : super(key: key);

//   @override
//   State<InputDropdownMap> createState() => _InputDropdownMapState();
// }

// class _InputDropdownMapState extends State<InputDropdownMap> {
//   late FbInputDataDropdownMap inputData;

//   @override
//   Widget build(BuildContext context) {
//     inputData = widget.dropDownMap;

//     return _DropWrapper(
//       inputData: inputData,
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           isExpanded: true,
//           value: inputData.value,
//           onChanged: (text) {
//             inputData.value = text!;

//             setState(() {});
//             widget.onEditComplete();
//           },
//           focusColor: Colors.transparent,
//           items: inputData.map.keys
//               .map((element) => DropdownMenuItem<String>(
//                     value: element,
//                     child: _DropItem(
//                       itemName: element,
//                       defaultItemName: inputData.defaultValue,
//                     ),
//                   ))
//               .toList(),
//         ),
//       ),
//     );
//   }
// }

class _DropWrapper extends StatelessWidget {
  const _DropWrapper({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
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
  final String itemName;

  final String defaultItemName;
  const _DropItem({
    Key? key,
    required this.itemName,
    required this.defaultItemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (itemName == defaultItemName) {
      return Row(
        children: [
          Text(
            itemName,
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
      itemName,
      style: context.textTheme.bodyMedium,
    );
  }
}
