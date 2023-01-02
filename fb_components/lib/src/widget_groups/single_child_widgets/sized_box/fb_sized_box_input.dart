import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:fb_components/src/reusable_inputs/single/full_width_input.dart';
import 'package:fb_components/src/widget_groups/single_child_widgets/sized_box/fb_sized_box_config.dart';
import 'package:flutter/material.dart';

class FbSizedBoxInput extends StatelessFbInput<FbSizedBoxStyles> {
  const FbSizedBoxInput({
    super.key,
    required super.styles,
    required super.onStylesUpdated,
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
        FullWidthInput(
          title: 'Width',
          value: styles.height,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              width: value?.toDouble(),
            ),
          ),
        ),
      ],
    );
  }
}
