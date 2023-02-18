import 'package:fb_components/src/base/stateless_fb_input.dart';
import 'package:flutter/material.dart';

import 'fb_center_config.dart';

class FbCenterInput extends StatelessFbInput<FbCenterStyles> {
  const FbCenterInput({
    super.key,
    required super.styles,
    required super.onStylesUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
