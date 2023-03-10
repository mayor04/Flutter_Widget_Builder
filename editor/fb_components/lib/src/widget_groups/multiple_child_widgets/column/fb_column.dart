import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:flutter/material.dart';

import 'fb_column_config.dart';

class FbColumn extends StatelessWidget {
  final List<Widget> children;
  final BaseFbStyles styles;

  const FbColumn({
    Key? key,
    required this.children,
    required this.styles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var columnStyles = styles.cast<FbColumnStyles>();

    return Column(
      mainAxisAlignment: columnStyles.mainAlignment,
      crossAxisAlignment: columnStyles.crossAlignment,
      mainAxisSize: columnStyles.axisSize,
      children: children,
    );
  }
}
