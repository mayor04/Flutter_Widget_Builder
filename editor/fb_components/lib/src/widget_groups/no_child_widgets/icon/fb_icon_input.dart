import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:fb_components/src/reusable_inputs/single/color_input.dart';
import 'package:fb_components/src/reusable_inputs/single/dropdown_input.dart';
import 'package:fb_components/src/reusable_inputs/single/full_width_input.dart';
import 'package:flutter/material.dart';

import 'fb_icon_config.dart';

class FbIconInput extends StatelessFbInput<FbIconStyles> {
  const FbIconInput({
    super.key,
    required super.styles,
    required super.onStylesUpdated,
    required super.globalParams,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.ac_unit,
      Icons.more_horiz,
      Icons.more_vert,
      Icons.abc,
      Icons.access_alarm,
      Icons.ios_share,
      Icons.accessibility,
      Icons.back_hand,
      Icons.access_time,
      Icons.account_balance,
      Icons.account_balance_wallet,
      Icons.account_box,
      Icons.account_circle,
      Icons.ad_units,
      Icons.add,
      Icons.stacked_bar_chart,
      Icons.add,
      Icons.add_a_photo,
      Icons.remove,
      Icons.remove_circle,
      Icons.cancel,
    ];
    // list of 50 random icons

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
        DropdownInput<IconData>(
          title: 'Icons',
          value: icons[0],
          dropdownList: icons,
          getName: (icon) => icon.toString(),
          onChanged: (value) => onStylesUpdated(
            styles.copyWith(
              icon: value,
            ),
          ),
        )
      ],
    );
  }
}
