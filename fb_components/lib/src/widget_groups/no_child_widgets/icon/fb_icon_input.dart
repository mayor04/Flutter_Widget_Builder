import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:fb_components/src/reusable_inputs/single/color_input.dart';
import 'package:fb_components/src/reusable_inputs/single/full_width_input.dart';
import 'package:flutter/material.dart';

import 'fb_icon_config.dart';

class FbIconInput extends StatelessFbInput<FbIconStyles> {
  const FbIconInput({
    super.key,
    required super.styles,
    required super.onStylesUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FullWidthInput(
          title: 'Size',
          value: styles.size,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              size: value?.toDouble(),
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
