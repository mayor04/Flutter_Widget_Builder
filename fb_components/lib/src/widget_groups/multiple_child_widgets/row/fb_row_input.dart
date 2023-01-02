import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:fb_components/src/reusable_inputs/single/dropdown_input.dart';
import 'package:flutter/material.dart';

import 'fb_row_config.dart';

class FbRowInput extends StatelessFbInput<FbRowStyles> {
  const FbRowInput({
    super.key,
    required super.styles,
    required super.onStylesUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownInput<MainAxisAlignment>(
          title: 'MainAxisAlign',
          value: styles.mainAlignment,
          defaultValue: MainAxisAlignment.start,
          dropdownList: MainAxisAlignment.values,
          getName: (value) => value.name,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              mainAlignment: value,
            ),
          ),
        ),
        DropdownInput<CrossAxisAlignment>(
          title: 'CrossAxisAlign',
          value: styles.crossAlignment,
          defaultValue: CrossAxisAlignment.center,
          dropdownList: CrossAxisAlignment.values,
          getName: (value) => value.name,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              crossAlignment: value,
            ),
          ),
        ),
        DropdownInput<MainAxisSize>(
          title: 'FontWeight',
          value: styles.axisSize,
          defaultValue: MainAxisSize.max,
          dropdownList: MainAxisSize.values,
          getName: (value) => value.name,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              axisSize: value,
            ),
          ),
        ),
      ],
    );
  }
}
