import 'package:fb_core/fb_core.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/tabs/params/bloc/global_params_bloc.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/tabs/params/view/add_params_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParametersTab extends StatefulWidget {
  const ParametersTab({Key? key}) : super(key: key);

  @override
  State<ParametersTab> createState() => _ParametersTabState();
}

class _ParametersTabState extends State<ParametersTab> {
  bool showAddParamsDialog = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BlocBuilder<GlobalParamsBloc, GlobalParamsState>(
          builder: (context, state) {
            final paramList = state.parameters.values.toList();

            return Container(
              color: AppColors.appDark,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Parameters',
                    style: context.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 60),
                  ...paramList
                      .map((e) => Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: Text(
                              e.toString(),
                              style: context.textTheme.bodyMedium,
                            ),
                          ))
                      .toList(),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showAddParamsDialog = true;
                        });
                      },
                      child: Text(
                        'Add Params',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        if (showAddParamsDialog)
          AddParamsDialog(
            onBack: () {
              showAddParamsDialog = false;
              setState(() {});
            },
          ),
      ],
    );
  }
}
