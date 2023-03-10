import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:flutter/material.dart';

import 'fb_expanded_config.dart';

class FbExpanded extends StatelessWidget {
  final Widget child;
  final BaseFbStyles styles;

  const FbExpanded({
    Key? key,
    required this.child,
    required this.styles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var expandedStyles = styles.cast<FbExpandedStyles>();

    return Expanded(
      flex: expandedStyles.flex,
      child: child,
    );
  }
}
