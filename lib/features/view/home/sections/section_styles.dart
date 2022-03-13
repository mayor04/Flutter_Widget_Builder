import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/features/bloc/styles_input/styles_input_bloc.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/view/home/input_widgets/group_input.dart';
import 'package:flutter_widget_builder/features/view/home/input_widgets/input_map.dart';
import 'package:flutter_widget_builder/features/view/home/input_widgets/input_widget.dart';

class SectionStyles extends StatelessWidget {
  const SectionStyles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<StylesInputBloc>(context)
    //     .add(StylesGetInputsEvent(1647131181583));

    return BlocBuilder<StylesInputBloc, StylesInputState>(
      builder: (context, state) {
        return Container(
          width: 300,
          margin: const EdgeInsets.fromLTRB(0, 120, 0, 70),
          decoration: RadiusDecoration(
            color: AppColors.appDark,
            radius: 10,
          ),
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: RadiusDecoration(
              radius: 10,
            ),
            child: ListView.builder(
              itemCount: state.allInput.length,
              itemBuilder: (context, index) {
                var fbInputBase = state.allInput[index];
                return FInputPad(fbInputBase: fbInputBase);
              },
            ),
          ),
        );
      },
    );
  }
}

class FInputPad extends StatelessWidget {
  final FbInputBase fbInputBase;

  const FInputPad({
    Key? key,
    required this.fbInputBase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 13, 10),
      child: Builder(
        builder: (context) {
          if (fbInputBase.inputType == FbInputType.group) {
            FbGroupInputBase groupData = fbInputBase as FbGroupInputBase;
            var groupWidgetFunction = InputMap.group[groupData.groupType];
            if (groupWidgetFunction == null) return const SizedBox();

            return groupWidgetFunction(groupData);
          }

          var widgetFunction = InputMap.input[fbInputBase.inputType];
          if (widgetFunction == null) return const SizedBox();

          return widgetFunction(fbInputBase);
        },
      ),
    );
  }
}









// Column(
//           children: [
//             FInputPad(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InputSmall(),
//                   InputSmall(),
//                 ],
//               ),
//             ),
//             Divider(),
//             FInputPad(child: InputLTRB()),
//             Divider(),
//             FInputPad(child: InputExpanded()),
//             Divider(),
//           ],
//         ),