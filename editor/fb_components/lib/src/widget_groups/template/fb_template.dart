import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:flutter/material.dart';

import 'fb_template_config.dart';

class FbTemplate extends StatelessWidget {
  final BaseFbStyles styles;

  const FbTemplate({
    Key? key,
    required this.styles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var TemplateStyles = styles.cast<FbTemplateStyles>();

    return Container();
  }
}
