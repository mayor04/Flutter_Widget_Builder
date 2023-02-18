import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:flutter/material.dart';

import 'fb_center_config.dart';

class FbCenter extends StatelessWidget {
  final BaseFbStyles styles;
  final Widget child;

  const FbCenter({
    Key? key,
    required this.styles,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var centerStyles = styles.cast<FbCenterStyles>();

    return Container(
      child: child,
    );
  }
}
