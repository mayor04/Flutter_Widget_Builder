import 'package:fb_components/src/base/base_input.dart';
import 'package:fb_components/src/base/fb_enum.dart';
import 'package:fb_components/src/widgets/box_spacing.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

/// This defines the style of the input that should be displayed
/// `FbInputDataLTRB<T>` tells the ui to fill the all the space horizontally
/// and mostly used for item like `padding`, `margin`, `border radius`
class FbInputDataLTRB<T extends List?> extends BaseFbInput<T> {
  FbInputDataLTRB(String title, T value) : super(title, value, FbInputType.ltrb);
}

class InputLTRB extends StatelessWidget {
  final FbInputDataLTRB ltrbInputData;
  final VoidCallback onEditComplete;
  const InputLTRB({
    Key? key,
    required this.ltrbInputData,
    required this.onEditComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> lt = ['L', 'T', 'R', 'B'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              ltrbInputData.title,
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
        const Box.vertical(15),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: List.generate(lt.length, (i) {
              return SizedBox(
                height: AppDimen.inputHeight,
                width: AppDimen.smallInputWidth,
                child: TextField(
                  controller: TextEditingController(
                    text: valueAt(i),
                  ),
                  decoration: InputDecoration(
                    hintText: lt[i],
                  ),
                  onSubmitted: (text) {
                    try {
                      if (text == '') {
                        ltrbInputData.value?[i] = 0;
                      }

                      ltrbInputData.value?[i] = double.parse(text);
                    } catch (e) {
                      AppLog.warn('InputSmall > onSubmitted', 'Incorrect input type  $e');
                      return;
                    }
                    onEditComplete();
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  String valueAt(int i) {
    if (ltrbInputData.value == null) {
      return '';
    }

    var value = (ltrbInputData.value?.itemAt(i) as num?) ?? 0;

    ///Check if double is a whole number
    if ((value % 1) == 0) {
      return value.toInt().toString();
    }

    return value.toString();
  }
}
