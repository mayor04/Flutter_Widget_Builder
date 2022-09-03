import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/inputs/fb_input_factory.dart';
import 'package:fb_components/src/widgets/box_spacing.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

///This groups has multiple sub inputs
class FbGroupMultipleInputs extends BaseFbGroupInput {
  List<BaseFbInput> fbInputs;

  FbGroupMultipleInputs(
    String title, {
    required this.fbInputs,
  }) : super(title, fbInputs, FbGroupType.multiple);

  BaseFbInput inputAt(int index) {
    var input = fbInputs.itemAt(index);

    if (input == null) {
      throw (Exception('Range Error: Unable to get input at $index for fb multiple'));
    }

    return input;
  }
}

class GroupInputMultiple extends StatelessWidget {
  final FbGroupMultipleInputs fbGroupData;
  final VoidCallback onEditComplete;
  const GroupInputMultiple({
    Key? key,
    required this.fbGroupData,
    required this.onEditComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
          child: Row(
            children: [
              Text(
                fbGroupData.title,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const Box.vertical(15),
        Container(
          color: AppColors.groupBg,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...allInputs(fbGroupData),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> allInputs(FbGroupMultipleInputs fbGroupData) {
    return List.generate(fbGroupData.fbInputs.length, (index) {
      BaseFbInput fbInputBase = fbGroupData.fbInputs[index];

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 10, 13, 10),
            child: Builder(
              builder: (context) {
                if (fbInputBase.inputType == FbInputType.group) {
                  BaseFbGroupInput groupData = fbInputBase as BaseFbGroupInput;

                  return FbInputFactory.getGroupInput(
                    inputGroup: groupData,
                    onEditComplete: onEditComplete,
                  );
                }

                return FbInputFactory.getInput(
                  inputData: fbInputBase,
                  onEditComplete: onEditComplete,
                );
              },
            ),
          ),
          const Divider(),
        ],
      );
    });
  }
}
