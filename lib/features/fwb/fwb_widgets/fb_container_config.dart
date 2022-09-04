// import 'package:flutter/material.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_group_inputs.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
// import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_config.dart';

// class FbContainerConfig extends BaseFbConfig<FbContainerStyles> {
//   var heightInput = FbInputDataWrap<double?>('Height', 50);
//   var widthInput = FbInputDataWrap<double?>('Width', 50);
//   var colorInput = FbInputDataColor('Color', int.parse('0xFFE6E6D6'));

//   var alignInput = FbInputDataDropdownMap(
//     'Alignment',
//     defaultValue: FbContainerStyles.defaultAlign,
//     map: FbContainerStyles.alignmentMap,
//   );

//   var paddingInput = FbInputDataLTRB<List<double>>('Padding', [0, 0, 0, 0]);
//   var marginInput = FbInputDataLTRB<List<double>>('Margin', [0, 0, 0, 0]);

//   var borderInput = FbGroupMultipleInputs('Border', fbInputs: [
//     FbGroupDoubleInputs(
//       '',
//       input1: FbInputDataWrap<double>('radius', 0),
//       input2: FbInputDataWrap<double>('size', 0),
//     ),
//     FbInputDataColor('color', Colors.transparent.value),
//   ]);

//   FbContainerConfig() : super(FbWidgetType.container, FbChildType.single);

//   @override
//   String generateCode(String child) {
//     // TODO: implement generateCode
//     throw UnimplementedError();
//   }

//   @override
//   List<BaseFbInput> getInputs() {
//     return [
//       FbGroupDoubleInputs('', input1: heightInput, input2: widthInput),
//       colorInput,
//       alignInput,
//       paddingInput,
//       marginInput,
//       borderInput,
//     ];
//   }

//   @override
//   FbContainerStyles getWidgetStyles() {
//     return FbContainerStyles(
//       id,
//       widgetType,
//       height: heightInput.value,
//       width: widthInput.value,
//       colorValue: colorInput.value,
//       pad: paddingInput.value,
//       marg: marginInput.value,
//       alignment: alignInput.mapValue,
//       radius: (borderInput.inputAt(0) as FbGroupDoubleInputs).input1.value as double,
//       borderSize: (borderInput.inputAt(0) as FbGroupDoubleInputs).input2.value as double,
//       borderColor: borderInput.inputAt(1).value,
//     );
//   }
// }

// ///Contains styles of the container, ussualy used to style the widget
// class FbContainerStyles extends BaseFbStyles {
//   static String defaultAlign = 'none';
//   static Map<String, Alignment?> alignmentMap = {
//     'none': null,
//     'bottomCenter': Alignment.bottomCenter,
//     'bottomLeft': Alignment.bottomLeft,
//     'bottomRight': Alignment.bottomRight,
//     'center': Alignment.center,
//     'centerLeft': Alignment.centerLeft,
//     'centerRight': Alignment.centerRight,
//     'topCenter': Alignment.topCenter,
//     'topLeft': Alignment.topLeft,
//     'topRight': Alignment.topRight,
//   };
//   final double? height;
//   final double? width;
//   final int colorValue;
//   final Alignment? alignment;
//   late final EdgeInsetsGeometry padding;
//   late final EdgeInsetsGeometry margin;
//   late final BorderRadiusGeometry borderRadius;

//   late final BoxBorder? border;

//   late final List<BoxShadow>? boxShadow;

//   //radius
//   //border width
//   //border color
//   //spread radius
//   //x and y
//   //blur radius
//   //color

//   FbContainerStyles(
//     int id,
//     FbWidgetType widgetType, {
//     required this.height,
//     required this.width,
//     required this.colorValue,
//     required this.alignment,
//     required List<double> pad,
//     required List<double> marg,
//     required double radius,
//     required double borderSize,
//     required int borderColor,
//     // required bool showShadow,
//     // required double offsetX,
//     // required double offsetY,
//     // required int shadowColor,
//     // required double blurRadius,
//     // required double spreadRadius,
//   }) : super(id, widgetType) {
//     padding = EdgeInsets.fromLTRB(pad[0], pad[1], pad[2], pad[3]);
//     margin = EdgeInsets.fromLTRB(marg[0], marg[1], marg[2], marg[3]);

//     borderRadius = BorderRadius.circular(radius);

//     if (borderSize != 0) {
//       border = Border.all(
//         color: Color(borderColor),
//         width: borderSize,
//       );
//     } else {
//       border = null;
//     }

//     // if (showShadow) {
//     //   boxShadow = [];
//     //   boxShadow?.add(
//     //     BoxShadow(
//     //       blurRadius: blurRadius,
//     //       color: Color(shadowColor),
//     //       offset: Offset(offsetX, offsetY),
//     //       spreadRadius: spreadRadius,
//     //     ),
//     //   );
//     // }
//   }
// }
