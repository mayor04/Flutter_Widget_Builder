import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:flutter/material.dart';

import 'fb_custom_config.dart';

class FbCustomInput extends StatelessFbInput<FbCustomStyles> {
  const FbCustomInput({
    super.key,
    required super.styles,
    required super.onStylesUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
