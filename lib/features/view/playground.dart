import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/view/home/input_widgets/input_widget.dart';

///This is where all widget appearance are being tested
class Playground extends StatelessWidget {
  const Playground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            Container(
              height: 50,
              width: 100,
              decoration: AppDecoration.lightBorder(
                color: AppColors.appGrey,
              ),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: AppDecoration.darkBorder(color: AppColors.appGrey),
            ),
            SizedBox(
              width: 95,
              child: Row(
                children: [
                  Text(
                    'Width',
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 30,
                    width: 45,
                    child: TextField(),
                  ),
                ],
              ),
            ),
            InputSmall(
              smallInputData: FbInputDataSmall('he', 2),
              onEditComplete: () {},
            ),
            SizedBox(
              width: 275,
              child: InputExpanded(
                expandedInputData: FbInputDataExpanded('he', 2),
                onEditComplete: () {},
              ),
            ),
            SizedBox(
              width: 275,
              child: InputLTRB(
                ltrbInputData: FbInputDataLTRB('he', [0, 0, 0, 0]),
                onEditComplete: () {},
              ),
            ),
            const SizedBox(
              height: 30,
              width: 100,
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
