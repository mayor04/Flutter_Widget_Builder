import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:flutter/material.dart';

import 'fb_container_config.dart';

class FbContainer extends StatelessWidget {
  final Widget child;
  final BaseFbStyles styles;

  const FbContainer({
    Key? key,
    required this.child,
    required this.styles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final containerStyles = styles.cast<FbContainerStyles>();

    return Container(
      key: ValueKey('display_${containerStyles.id}'),
      padding: containerStyles.padding,
      margin: containerStyles.margin,
      height: containerStyles.height,
      width: containerStyles.width,
      alignment: containerStyles.alignment,
      decoration: BoxDecoration(
        color: containerStyles.color,
        borderRadius: containerStyles.borderRadius,
        border: containerStyles.border,
      ),
      child: child,
    );
  }
}
