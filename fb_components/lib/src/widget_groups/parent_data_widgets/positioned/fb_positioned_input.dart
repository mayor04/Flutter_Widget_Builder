import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:fb_components/src/reusable_inputs/single/full_width_input.dart';
import 'package:flutter/material.dart';

import 'fb_positioned_config.dart';

class FbPositionedInput extends StatelessFbInput<FbPositionedStyles> {
  const FbPositionedInput({
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
          title: 'Top',
          value: styles.top,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              top: value?.toDouble(),
            ),
          ),
        ),
        FullWidthInput(
          title: 'Right',
          value: styles.right,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              right: value?.toDouble(),
            ),
          ),
        ),
        FullWidthInput(
          title: 'Bottom',
          value: styles.bottom,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              bottom: value?.toDouble(),
            ),
          ),
        ),
        FullWidthInput(
          title: 'Left',
          value: styles.left,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              left: value?.toDouble(),
            ),
          ),
        ),
      ],
    );
  }
}
