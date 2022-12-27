// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/extension.dart/num_extension.dart';
import 'package:fb_components/src/inputs/groups/double_inputs.dart';
import 'package:fb_components/src/inputs/groups/multiple_inputs.dart';
import 'package:fb_components/src/inputs/single/color_input.dart';
import 'package:fb_components/src/inputs/single/dropdown_input.dart';
import 'package:fb_components/src/inputs/single/ltrb_input.dart';
import 'package:fb_components/src/inputs/single/wrap_input.dart';
import 'package:flutter/material.dart';

part 'fb_input_config.dart';

class FbContainerConfig extends BaseFbConfig<FbContainerStyles> with CodeGeneratorLogic {
  final _Inputs _config = _Inputs();
  FbContainerConfig() : super(FbWidgetType.container, FbChildType.single);

  @override
  List<BaseFbInput> getInputs() {
    return [
      FbGroupDoubleInputs(
        '',
        input1: _config.heightInput,
        input2: _config.widthInput,
      ),
      _config.colorInput,
      _config.alignInput,
      _config.paddingInput,
      _config.marginInput,
      _config.borderInput,
    ];
  }

  @override
  FbContainerStyles getWidgetStyles() {
    return FbContainerStyles(
      id,
      widgetType,
      height: _config.height?.toDouble(),
      width: _config.width?.toDouble(),
      colorValue: _config.color,
      pad: _config.padding,
      marg: _config.margin,
      alignment: _config.alignment,
      radius: _config.radius?.toDouble() ?? 0,
      borderSize: _config.borderSize?.toDouble() ?? 0,
      borderColor: _config.borderColor,
    );
  }

  @override
  String generateCode(String? childCode, int level) {
    final pad = _config.padding.map((e) => e.removeZeroDecimal).toList();
    final marg = _config.margin.map((e) => e.removeZeroDecimal).toList();

    var widgetCode = {
      '_name': 'Container',
      'height': _config.height,
      'width': _config.width,
      'color': nullMapper(
        prefix: 'Color(',
        value: _config.color,
        suffix: ')',
        returnNullChecks: [(value) => value == 0],
      ),
      'padding': nullMapper(
        prefix: 'EdgeInsets.fromLTRB(',
        value: '${pad[0]},${pad[0]},${pad[0]},${pad[0]}',
        suffix: ')',
        returnNullChecks: [(_) => pad.where((v) => v != 0).isEmpty],
      ),
      'margin': nullMapper(
        prefix: 'EdgeInsets.fromLTRB(',
        value: '${marg[0]},${marg[0]},${marg[0]},${marg[0]}',
        suffix: ')',
        returnNullChecks: [
          // Check if all the element in the list is not zero
          (_) => marg.where((v) => v != 0).isEmpty,
        ],
      ),
      'decoration': {
        '_name': 'BoxDecoration',
        'borderRadius': {
          '_name': 'BorderRadius.circular',
          '': _config.radius,
        },
        'border': {
          '_name': 'Border.all',
          'width': _config.borderSize,
          'color': nullMapper(
            prefix: 'Color(',
            value: _config.borderColor,
            suffix: ')',
            returnNullChecks: [(value) => value == 0],
          ),
        }
      },
      'child': childCode,
    };

    return getCode(widgetCode) ?? '';
  }
}

///Contains styles of the container, ussualy used to style the widget
class FbContainerStyles extends BaseFbStyles {
  static String defaultAlign = 'none';
  static Map<String, Alignment?> alignmentMap = {
    'none': null,
    'bottomCenter': Alignment.bottomCenter,
    'bottomLeft': Alignment.bottomLeft,
    'bottomRight': Alignment.bottomRight,
    'center': Alignment.center,
    'centerLeft': Alignment.centerLeft,
    'centerRight': Alignment.centerRight,
    'topCenter': Alignment.topCenter,
    'topLeft': Alignment.topLeft,
    'topRight': Alignment.topRight,
  };

  final double? height;
  final double? width;
  final int colorValue;
  final Alignment? alignment;
  late final EdgeInsetsGeometry padding;
  late final EdgeInsetsGeometry margin;
  late final BorderRadiusGeometry borderRadius;
  late final BoxBorder? border;
  late final List<BoxShadow>? boxShadow;

  //radius
  //border width
  //border color
  //spread radius
  //x and y
  //blur radius
  //color

  FbContainerStyles(
    int id,
    FbWidgetType widgetType, {
    required this.height,
    required this.width,
    required this.colorValue,
    required this.alignment,
    required List<double> pad,
    required List<double> marg,
    required double radius,
    required double borderSize,
    required int borderColor,
    // required bool showShadow,
    // required double offsetX,
    // required double offsetY,
    // required int shadowColor,
    // required double blurRadius,
    // required double spreadRadius,
  }) : super(id, widgetType) {
    padding = EdgeInsets.fromLTRB(pad[0], pad[1], pad[2], pad[3]);
    margin = EdgeInsets.fromLTRB(marg[0], marg[1], marg[2], marg[3]);

    borderRadius = BorderRadius.circular(radius);

    if (borderSize != 0) {
      border = Border.all(
        color: Color(borderColor),
        width: borderSize,
      );
    } else {
      border = null;
    }

    // if (showShadow) {
    //   boxShadow = [];
    //   boxShadow?.add(
    //     BoxShadow(
    //       blurRadius: blurRadius,
    //       color: Color(shadowColor),
    //       offset: Offset(offsetX, offsetY),
    //       spreadRadius: spreadRadius,
    //     ),
    //   );
    // }
  }
}
