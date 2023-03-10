import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:flutter/material.dart';

import 'fb_row_config.dart';

class FbRow extends StatelessWidget {
  final List<Widget> children;
  final BaseFbStyles styles;

  const FbRow({
    Key? key,
    required this.children,
    required this.styles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rowStyles = styles.cast<FbRowStyles>();

    return Row(
      mainAxisAlignment: rowStyles.mainAlignment,
      crossAxisAlignment: rowStyles.crossAlignment,
      mainAxisSize: rowStyles.axisSize,
      children: children,
    );
  }
}
