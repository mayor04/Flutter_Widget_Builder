import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:flutter/material.dart';

import 'fb_divider_config.dart';

class FbDivider extends StatelessWidget {
  final BaseFbStyles styles;

  const FbDivider({
    Key? key,
    required this.styles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dividerStyles = styles.cast<FbDividerStyles>();

    return Divider(
      key: ValueKey('display_${dividerStyles.id}'),
      height: dividerStyles.height,
      thickness: dividerStyles.thickness,
      indent: dividerStyles.indent,
      endIndent: dividerStyles.endIndent,
      color: dividerStyles.color,
    );
  }
}
