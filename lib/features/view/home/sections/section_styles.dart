import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/features/bloc/styles_input/styles_input_bloc.dart';
import 'package:flutter_widget_builder/features/view/home/input_widgets/input_widget.dart';

class SectionStyles extends StatelessWidget {
  const SectionStyles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              itemBuilder: (context, index) {},
            ),
          ),
        );
      },
    );
  }
}

class FInputPad extends StatelessWidget {
  final Widget child;
  const FInputPad({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 13, 10),
      child: child,
    );
  }
}

var mapInput = {};

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