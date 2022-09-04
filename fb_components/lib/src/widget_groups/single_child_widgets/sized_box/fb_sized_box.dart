import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:flutter/material.dart';

import 'fb_sized_box_config.dart';

class FbSizedBox extends StatelessWidget {
  final Widget child;
  final BaseFbStyles styles;

  const FbSizedBox({
    Key? key,
    required this.child,
    required this.styles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizedBoxStyles = styles.cast<FbSizedBoxStyles>();

    return SizedBox(
      height: sizedBoxStyles.height,
      width: sizedBoxStyles.width,
      child: child,
    );
  }
}
