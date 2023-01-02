import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:fb_components/src/reusable_inputs/single/dropdown_input.dart';
import 'package:fb_components/src/widget_groups/multiple_child_widgets/stack/fb_stack_config.dart';
import 'package:flutter/material.dart';

class FbStackInput extends StatelessFbInput<FbStackStyles> {
  const FbStackInput({
    super.key,
    required super.styles,
    required super.onStylesUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownInput<StackFit>(
          title: 'FontWeight',
          value: styles.stackFit,
          defaultValue: StackFit.loose,
          dropdownList: StackFit.values,
          getName: (value) => value.name,
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              stackFit: value,
            ),
          ),
        ),
      ],
    );
  }
}
