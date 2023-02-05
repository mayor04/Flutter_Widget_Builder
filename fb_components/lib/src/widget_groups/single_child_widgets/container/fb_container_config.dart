// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:fb_components/src/base/base_fb_config.dart';
import 'package:fb_components/src/base/code_logic_mixin.dart';
import 'package:fb_components/src/extension.dart/num_extension.dart';
import 'package:fb_components/src/widget_groups/builders/all.dart';
import 'package:flutter/material.dart';

const _type = FbWidgetType.container;

class FbContainerConfig extends BaseFbConfig<FbContainerStyles> with CodeGeneratorLogic {
  FbContainerStyles? styles;

  FbContainerConfig({
    String? id,
    this.styles,
  }) : super(_type, FbChildType.single, id: id);

  factory FbContainerConfig.fromJson(Map<String, dynamic> json) {
    return FbContainerConfig(
      id: json['id'],
      styles: json['styles'] == null
          ? null
          : FbContainerStyles.fromJson(
              (json['styles'] as Map<dynamic, dynamic>).cast(),
            ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': widgetType.name,
      'styles': styles?.toJson(),
    };
  }

  @override
  void updateStyles(FbContainerStyles styles) {
    this.styles = styles;
  }

  @override
  FbContainerStyles getWidgetStyles() {
    // If style is null re-inititalize it
    return styles ??= FbContainerStyles(
      id,
      color: Colors.blue,
      borderColor: const Color(0xFF000000),
    );
  }

  @override
  String generateCode(String? childCode) {
    final styles = getWidgetStyles();

    final padInset = styles.padding;
    final margInset = styles.margin;

    final pad = [padInset.left, padInset.top, padInset.right, padInset.bottom]
        .map((e) => e.removeZeroDecimal)
        .toList();
    final marg = [margInset.left, margInset.top, margInset.right, margInset.bottom]
        .map((e) => e.removeZeroDecimal)
        .toList();

    var widgetCode = {
      '_name': 'Container',
      'height': styles.height,
      'width': styles.width,
      'color': nullMapper(
        prefix: 'Color(',
        value: styles.color.value,
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
          '': styles.radius,
        },
        'border': {
          '_name': 'Border.all',
          'width': styles.borderSize,
          'color': nullMapper(
            prefix: 'Color(',
            value: styles.borderColor?.value,
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
  final Color color;
  final Alignment? alignment;
  final double radius;
  final double borderSize;
  final Color? borderColor;

  late final EdgeInsets padding;
  late final EdgeInsets margin;
  late final BorderRadius borderRadius;
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
    String id, {
    this.height = 300,
    this.width = 300,
    required this.color,
    this.alignment,
    List<double> pad = const [],
    List<double> marg = const [],
    this.radius = 0,
    this.borderSize = 0,
    this.borderColor,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    // required bool showShadow,
    // required double offsetX,
    // required double offsetY,
    // required int shadowColor,
    // required double blurRadius,
    // required double spreadRadius,
  }) : super(id, _type) {
    // padding = EdgeInsets.fromLTRB(pad[0], pad[1], pad[2], pad[3]);
    // margin = EdgeInsets.fromLTRB(marg[0], marg[1], marg[2], marg[3]);

    borderRadius = BorderRadius.circular(radius);

    if (borderSize != 0) {
      border = Border.all(
        color: borderColor ?? Colors.transparent,
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

  // from json
  factory FbContainerStyles.fromJson(Map<String, dynamic> json) {
    return FbContainerStyles(
      json['id'],
      height: json['height'],
      width: json['width'],
      color: json['color'] == null ? Colors.transparent : Color(json['color']),
      alignment: alignmentMap[json['alignment']],
      padding: EdgeInsets.fromLTRB(
        json['padding'][0],
        json['padding'][1],
        json['padding'][2],
        json['padding'][3],
      ),
      margin: EdgeInsets.fromLTRB(
        json['margin'][0],
        json['margin'][1],
        json['margin'][2],
        json['margin'][3],
      ),
      radius: json['radius'] ?? 0,
      borderSize: json['borderSize'] ?? 0,
      borderColor: json['borderColor'],
      pad: [],
      marg: [],
      // showShadow: json['showShadow'],
      // offsetX: json['offsetX'],
      // offsetY: json['offsetY'],
      // shadowColor: json['shadowColor'],
      // blurRadius: json['blurRadius'],
      // spreadRadius: json['spreadRadius'],
    );
  }

  // copy with
  FbContainerStyles copyWith({
    double? height,
    double? width,
    int? colorValue,
    Color? color,
    Alignment? alignment,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadiusGeometry? borderRadius,
    BoxBorder? border,
    double? radius,
    double? borderSize,
    Color? borderColor,
    List<BoxShadow>? boxShadow,
  }) {
    return FbContainerStyles(
      id,
      height: height ?? this.height,
      width: width ?? this.width,
      color: color ?? this.color,
      alignment: alignment ?? this.alignment,
      padding: padding ?? this.padding,
      pad: [0, 0, 0, 0],
      marg: [0, 0, 0, 0],
      margin: margin ?? this.margin,
      radius: radius ?? this.borderRadius.topLeft.x,
      borderSize: borderSize ?? this.border?.top.width ?? 0,
      borderColor: borderColor ?? this.border?.top.color,
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'height': height,
      'width': width,
      'color': color.value,
      'alignment': alignmentMap.keys.firstWhere(
        (key) => alignmentMap[key] == alignment,
        orElse: () => defaultAlign,
      ),
      'padding': [
        padding.left,
        padding.top,
        padding.right,
        padding.bottom,
      ],
      'margin': [
        margin.left,
        margin.top,
        margin.right,
        margin.bottom,
      ],
      'radius': borderRadius.topLeft.x,
      'borderSize': border?.top.width,
      'borderColor': border?.top.color.value,
      // 'showShadow': boxShadow != null,
      // 'offsetX': boxShadow?.first.offset.dx ?? 0,
      // 'offsetY': boxShadow?.first.offset.dy ?? 0,
      // 'shadowColor': boxShadow?.first.color.value ?? 0,
      // 'blurRadius': boxShadow?.first.blurRadius ?? 0,
      // 'spreadRadius': boxShadow?.first.spreadRadius ?? 0,
    };
  }
}
