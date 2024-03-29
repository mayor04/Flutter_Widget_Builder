import 'package:fb_components/src/params/input_params/input_params.dart';
import 'package:flutter/material.dart';

import 'base_fb_config.dart';

/// A base class for all input widgets that are stateless
abstract class StatelessFbInput<T extends BaseFbStyles> extends StatelessWidget {
  const StatelessFbInput({
    Key? key,
    required this.styles,
    required this.onStylesUpdated,
    required this.globalParams,
    required,
  }) : super(key: key);

  final T styles;
  final ValueChanged<T> onStylesUpdated;
  final GlobalParamsMap globalParams;
}
