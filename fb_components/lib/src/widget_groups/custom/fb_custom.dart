import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:flutter/material.dart';

import 'fb_custom_config.dart';

class FbCustom extends StatelessWidget {
  final BaseFbStyles styles;

  const FbCustom({
    Key? key,
    required this.styles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var customStyles = styles.cast<FbCustomStyles>();

    return Container();
  }
}
