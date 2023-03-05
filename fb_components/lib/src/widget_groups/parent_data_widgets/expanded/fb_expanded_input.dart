import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:fb_components/src/reusable_inputs/single/full_width_input.dart';
import 'package:flutter/material.dart';

import 'fb_expanded_config.dart';

class FbExpandedInput extends StatelessFbInput<FbExpandedStyles> {
  const FbExpandedInput({
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
          title: 'Flex',
          value: styles.flex,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              flex: value?.toInt(),
            ),
          ),
        ),
      ],
    );
  }
}
