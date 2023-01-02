import 'package:fb_components/src/widgets/box_spacing.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

class LTRBInput extends StatelessWidget {
  const LTRBInput({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.list,
  }) : super(key: key);

  final String title;
  final List<double> list;
  final ValueChanged<List<double>> onChanged;

  @override
  Widget build(BuildContext context) {
    List<String> lt = ['L', 'T', 'R', 'B'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              title,
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
                      final newList = [...list];
                      if (text == '') {
                        newList[i] = 0;
                      }

                      newList[i] = double.parse(text);
                      onChanged(newList);
                    } catch (e) {
                      AppLog.warn('InputSmall > onSubmitted', 'Incorrect input type  $e');
                      return;
                    }
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
    final value = list.itemAt(i) ?? 0;

    ///Check if double is a whole number
    if ((value % 1) == 0) {
      return value.toInt().toString();
    }

    return value.toString();
  }
}
