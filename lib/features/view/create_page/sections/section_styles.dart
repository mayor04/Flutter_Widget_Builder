import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/features/bloc/notifier/notifier_cubit.dart';
import 'package:flutter_widget_builder/features/bloc/styles_input/input_bloc.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/view/create_page/input_widgets/input_map.dart';

class SectionStyles extends StatelessWidget {
  const SectionStyles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<StylesInputBloc>(context)
    //     .add(StylesGetInputsEvent(1647131181583));

    return BlocListener<NotifierCubit, NotifierState>(
      listener: (context, state) {
        if (state is NotifierSelected) {
          context.read<InputBloc>().add(GetInputsEvent(state.id));
        }
      },
      child: BlocBuilder<InputBloc, InputState>(
        builder: (context, state) {
          return Container(
            width: 270,
            margin: const EdgeInsets.fromLTRB(0, 110, 0, 60),
            decoration: AppDecoration.radius(
              color: AppColors.appDark,
              radius: 5,
            ),
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              decoration: AppDecoration.radius(
                color: AppColors.appGrey,
                radius: 5,
              ),
              child: ListView.builder(
                itemCount: state.allInput.length,
                itemBuilder: (context, index) {
                  var fbInputBase = state.allInput[index];
                  return FInputPad(
                    fbInputBase: fbInputBase,
                    widgetId: state.widgetId,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class FInputPad extends StatelessWidget {
  final FbInputBase fbInputBase;
  final int widgetId;

  const FInputPad({
    Key? key,
    required this.fbInputBase,
    required this.widgetId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 13, 15),
          child: Builder(
            builder: (context) {
              if (fbInputBase.inputType == FbInputType.group) {
                FbGroupInputBase groupData = fbInputBase as FbGroupInputBase;
                // var groupWidgetFunction = InputMap.group[groupData.groupType];
                // if (groupWidgetFunction == null) return const SizedBox();

                return InputItemBox.getGroupInput(
                  inputGroup: groupData,
                  onEditComplete: onEditComplete(context),
                );
              }

              // var widgetFunction = InputMap.input[fbInputBase.inputType];
              // if (widgetFunction == null) return const SizedBox();

              return InputItemBox.getInput(
                inputData: fbInputBase,
                onEditComplete: onEditComplete(context),
              );
            },
          ),
        ),
        const Divider(),
      ],
    );
  }

  VoidCallback onEditComplete(BuildContext context) {
    return () {
      context.read<NotifierCubit>().styleChanged(widgetId);
    };
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