import 'package:fb_app/features/widget_creator/bloc/code_display_bloc.dart';
import 'package:fb_core/fb_core.dart';
import 'package:fb_core/src/widgets/app_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CodeSection extends StatefulWidget {
  const CodeSection({
    Key? key,
  }) : super(key: key);

  @override
  State<CodeSection> createState() => _CodeSectionState();
}

class _CodeSectionState extends State<CodeSection> {
  bool showCode = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeDisplayBloc, CodeDisplayState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () {
                showCode = !showCode;
                if (showCode) {
                  context.read<CodeDisplayBloc>().generateCode();
                }

                AppOverlay.removeAll(context);
                setState(() {});
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 12,
                color: Colors.white,
              ),
              label: Text(
                'Show Code',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (showCode)
              Expanded(
                child: Container(
                  width: 400,
                  color: AppColors.appGrey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        color: AppColors.appDark,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(17),
                        child: Text(
                          state.generatedCode,
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
