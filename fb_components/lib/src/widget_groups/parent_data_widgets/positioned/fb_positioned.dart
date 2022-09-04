import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:flutter/material.dart';

import 'fb_positioned_config.dart';

class FbPositioned extends StatelessWidget {
  final Widget child;
  final BaseFbStyles styles;

  const FbPositioned({
    Key? key,
    required this.child,
    required this.styles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var positionedStyles = styles.cast<FbPositionedStyles>();

    return Positioned(
      top: positionedStyles.top,
      bottom: positionedStyles.bottom,
      left: positionedStyles.left,
      right: positionedStyles.right,
      child: child,
    );
  }
}
