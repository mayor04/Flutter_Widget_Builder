import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:fb_components/src/reusable_inputs/single/color_input.dart';
import 'package:fb_components/src/reusable_inputs/single/full_width_input.dart';
import 'package:flutter/material.dart';

import 'fb_divider_config.dart';

class FbDividerInput extends StatelessFbInput<FbDividerStyles> {
  const FbDividerInput({
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
            ),
          ),
        ),
        // Thickness
        FullWidthInput(
          title: 'Thickness',
          value: styles.thickness,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              thickness: value?.toDouble(),
            ),
          ),
        ),
        // Indent
        FullWidthInput(
          title: 'Indent',
          value: styles.indent,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              indent: value?.toDouble(),
            ),
          ),
        ),
        // End Indent
        FullWidthInput(
          title: 'End Indent',
          value: styles.endIndent,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              endIndent: value?.toDouble(),
            ),
          ),
        ),
        // Color
        ColorInput(
          title: 'Color',
          color: styles.color ?? Colors.black,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              color: value,
            ),
          ),
        ),
      ],
    );
  }
}
