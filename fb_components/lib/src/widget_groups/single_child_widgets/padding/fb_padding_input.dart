import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:flutter/material.dart';

import 'fb_padding_config.dart';

class FbTemplateInput extends StatelessFbInput<FbTemplateStyles> {
  const FbTemplateInput({
    super.key,
    required super.styles,
    required super.onStylesUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
