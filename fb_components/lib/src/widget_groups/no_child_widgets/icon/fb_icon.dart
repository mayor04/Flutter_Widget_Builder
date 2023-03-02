import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:flutter/material.dart';

import 'fb_icon_config.dart';

class FbIcon extends StatelessWidget {
  final BaseFbStyles styles;

  const FbIcon({
    Key? key,
    required this.styles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var iconStyles = styles.cast<FbIconStyles>();

    return Icon(
      iconStyles.icon,
      size: iconStyles.size,
      color: iconStyles.color,
    );
  }
}
