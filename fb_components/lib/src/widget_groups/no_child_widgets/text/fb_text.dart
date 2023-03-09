import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/params/input_params/input_params.dart';
import 'package:flutter/material.dart';

import 'fb_text_config.dart';

class FbText extends StatelessWidget {
  final BaseFbStyles styles;
  final GlobalParamsMap globalParams;

  const FbText({
    Key? key,
    required this.styles,
    required this.globalParams,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyles = styles.cast<FbTextStyles>();

    // Get inherited widget parameters
    // For each style, check if the style params is not null

    final textParams = globalParams[textStyles.textParamsRef?.paramId ?? ''];

    return Text(
      textParams?.previewValue.toString() ??
          (textStyles.text == '' ? 'Enter Text' : textStyles.text),
      style: TextStyle(
        fontSize: textStyles.fontSize,
        color: textStyles.color,
        fontWeight: textStyles.fontWeight,
      ),
    );
  }
}
