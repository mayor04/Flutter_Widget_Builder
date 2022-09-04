import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:flutter/material.dart';

import 'fb_stack_config.dart';

class FbStack extends StatelessWidget {
  final List<Widget> children;
  final BaseFbStyles styles;

  const FbStack({
    Key? key,
    required this.children,
    required this.styles,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var stackStyles = styles.cast<FbStackStyles>();

    return Stack(
      fit: stackStyles.stackFit,
      children: children,
    );
  }
}
