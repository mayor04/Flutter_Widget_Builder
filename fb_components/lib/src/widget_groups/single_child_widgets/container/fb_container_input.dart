import 'package:fb_components/fb_components.dart';
import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:fb_components/src/reusable_inputs/groups/multiple_inputs_wrap.dart';
import 'package:fb_components/src/reusable_inputs/single/color_input.dart';
import 'package:fb_components/src/reusable_inputs/single/dropdown_input.dart';
import 'package:fb_components/src/reusable_inputs/single/full_width_input.dart';
import 'package:fb_components/src/reusable_inputs/single/ltrb_input.dart';
import 'package:flutter/material.dart';

class FbContainerInput extends StatelessFbInput<FbContainerStyles> {
  const FbContainerInput({
    super.key,
    required super.styles,
    required super.onStylesUpdated,
    required super.globalParams,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FullWidthInput(
          title: 'Height',
          value: styles.height,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              height: value?.toDouble(),
              heightChanged: true,
            ),
          ),
        ),
        FullWidthInput(
          title: 'Width',
          value: styles.width,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              width: value?.toDouble(),
              widthChanged: true,
            ),
          ),
        ),
        ColorInput(
          title: 'Color',
          color: styles.color,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              color: value,
            ),
          ),
        ),
        // alignment dropdown
        DropdownInput<Alignment?>(
          title: 'Alignment',
          value: styles.alignment,
          dropdownList: FbContainerStyles.alignmentMap.values.toList(),
          getName: (value) => value?.toString().split('.')[1] ?? 'none',
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              alignment: value,
              alignmentChanged: true,
            ),
          ),
        ),
        LTRBInput(
          title: 'Padding',
          list: insetToList(styles.padding),
          onChanged: (list) => onStylesUpdated(
            styles.copyWith(
              padding: insetFromList(list),
            ),
          ),
        ),
        LTRBInput(
          title: 'Margin',
          list: insetToList(styles.margin),
          onChanged: (list) => onStylesUpdated(
            styles.copyWith(
              margin: insetFromList(list),
            ),
          ),
        ),
        MultipleInputWrap(
          title: 'Border',
          children: [
            FullWidthInput(
              title: 'Radius',
              value: styles.radius,
              onChanged: (value) => onStylesUpdated(
                styles.copyWith(
                  radius: value?.toDouble(),
                ),
              ),
            ),
            ColorInput(
              title: 'Color',
              color: styles.borderColor ?? Colors.black,
              onChanged: (value) => onStylesUpdated(
                styles.copyWith(
                  borderColor: value,
                ),
              ),
            ),
            FullWidthInput(
              title: 'Size',
              value: styles.borderSize,
              onChanged: (value) => onStylesUpdated(
                styles.copyWith(
                  borderSize: value?.toDouble(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<double> insetToList(EdgeInsets insets) {
    return [
      insets.left.toDouble(),
      insets.top.toDouble(),
      insets.right.toDouble(),
      insets.bottom.toDouble(),
    ];
  }

  // list to inset
  EdgeInsets insetFromList(List<double> list) {
    return EdgeInsets.fromLTRB(
      list[0],
      list[1],
      list[2],
      list[3],
    );
  }
}
