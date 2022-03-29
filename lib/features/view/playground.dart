import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/features/bloc/notifier/notifier_cubit.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/fb_inputs.dart';
import 'package:flutter_widget_builder/features/view/create_page/input_widgets/input_widget.dart';
import 'package:flutter_widget_builder/widget/box_spacing.dart';

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
            _PlayBorder(
              child: Container(
                height: 50,
                width: 100,
                decoration: AppDecoration.lightBorder(
                  color: AppColors.appGrey,
                ),
              ),
            ),
            _PlayBorder(
              child: Container(
                height: 50,
                width: 100,
                decoration: AppDecoration.darkBorder(color: AppColors.appGrey),
              ),
            ),
            _PlayBorder(
              child: SizedBox(
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
            ),
            _PlayBorder(
              title: 'Small input',
              child: InputSmall(
                smallInputData: FbInputDataSmall('width', 2),
                onEditComplete: () {},
              ),
            ),
            _PlayBorder(
              title: 'Expanded input',
              child: SizedBox(
                width: 275,
                child: InputExpanded(
                  expandedInputData: FbInputDataExpanded('name', 2),
                  onEditComplete: () {},
                ),
              ),
            ),
            _PlayBorder(
              title: 'LTRB input',
              child: SizedBox(
                width: 275,
                child: InputLTRB(
                  ltrbInputData: FbInputDataLTRB('margin', [0, 0, 0, 0]),
                  onEditComplete: () {},
                ),
              ),
            ),
            const _PlayBorder(
              title: 'icon',
              child: SizedBox(
                height: 30,
                width: 100,
                child: Icon(Icons.add),
              ),
            ),
            _PlayBorder(
              title: 'parse color',
              child: Container(
                height: 50,
                width: 50,
                // color: Colors.white,
                color: () {
                  int value = int.parse('0xFF7BBAAF');
                  var l = Color(value).toString();
                  return Color(value);
                }(),
              ),
            ),
            _PlayBorder(
              child: SizedBox(
                width: 275,
                child: InputColor(
                  colorInputData: FbInputDataColor('color', 0xFFC4C4C4),
                  onEditComplete: () {},
                ),
              ),
            ),
            _PlayBorder(
              child: SizedBox(
                width: 275,
                child: InputDropdown(
                  dropDownInputData: FbInputDataDropdown(
                    'color',
                    defaultEnum: MainAxisAlignment.center,
                    list: MainAxisAlignment.values,
                  ),
                  onEditComplete: () {},
                ),
              ),
            ),
            _PlayBorder(
              child: SizedBox(
                width: 275,
                height: 150,
                child: Column(
                  children: [
                    GestWr(
                      child: Expanded(
                        child: Container(
                          color: Colors.white,
                          // alignment: Alignment.topLeft,
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      alignment: Alignment.center,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GestWr extends StatefulWidget {
  final Widget child;

  const GestWr({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<GestWr> createState() => _GestWrState();
}

class _GestWrState extends State<GestWr> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotifierCubit, NotifierState>(
      builder: (context, state) {
        return widget.child;
      },
    );
  }
}

class _PlayBorder extends StatelessWidget {
  final Widget child;
  final String? title;
  const _PlayBorder({Key? key, required this.child, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: AppDecoration.lightBorder(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title ?? 'No title',
            style: context.textTheme.bodyMedium,
          ),
          const Box.vertical(10),
          child,
        ],
      ),
    );
  }
}
