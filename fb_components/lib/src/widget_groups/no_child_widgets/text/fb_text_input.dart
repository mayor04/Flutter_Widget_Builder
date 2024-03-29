import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:fb_components/src/params/style_params/style_params.dart';
import 'package:fb_components/src/reusable_inputs/single/color_input.dart';
import 'package:fb_components/src/reusable_inputs/single/dropdown_input.dart';
import 'package:fb_components/src/reusable_inputs/single/full_width_input.dart';
import 'package:fb_components/src/reusable_inputs/single/text_field_input.dart';
import 'package:flutter/material.dart';

import 'fb_text_config.dart';

class FbTextInput extends StatelessFbInput<FbTextStyles> {
  const FbTextInput({
    super.key,
    required super.styles,
    required super.onStylesUpdated,
    required super.globalParams,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldInput(
          title: 'Text',
          value: styles.text,
          styleName: styles.textSn,
          globalParams: globalParams,
          onParamsSelected: (styleName, globalParamsId) {
            final params = {...styles.params};
            params[styleName] = StyleParams(
              paramId: globalParamsId,
              styleName: styleName,
            );

            onStylesUpdated(
              styles.copyWith(
                params: params,
              ),
            );
          },
          onParamsRemoved: (styleName) {
            final params = {...styles.params};
            params.remove(styleName);

            onStylesUpdated(
              styles.copyWith(
                params: params,
              ),
            );
          },
          // onAddParams: (key, params){
          //   // Add params to the style
          // },
          // onRemoveParams: (key, params){
          //   // Add params to the style
          // },
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              text: value,
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
        // Font size
        FullWidthInput(
          title: 'Font size',
          value: styles.fontSize,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              fontSize: value?.toDouble(),
            ),
          ),
        ),
        DropdownInput<FontWeight?>(
          title: 'FontWeight',
          value: styles.fontWeight,
          defaultValue: FontWeight.normal,
          dropdownList: FontWeight.values,
          getName: (value) => value.toString().split('.')[1],
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              fontWeight: value,
            ),
          ),
        )
      ],
    );
  }
}
