import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/tabs/params/bloc/global_params_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddParamsDialog extends StatefulWidget {
  const AddParamsDialog({Key? key, required this.onBack}) : super(key: key);

  final VoidCallback onBack;

  @override
  State<AddParamsDialog> createState() => _AddParamsDialogState();
}

class _AddParamsDialogState extends State<AddParamsDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: Container(
          width: 300,
          color: AppColors.appGrey,
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Add Parameters',
                  style: context.textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 60),
              Row(
                children: [
                  const Text('Name'),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => widget.onBack(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      addParams();
                      widget.onBack();
                    },
                    child: const Text('Add Params'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addParams() {
    final String name = _nameController.text;

    if (name.isEmpty) {
      return;
    }

    BlocProvider.of<GlobalParamsBloc>(context).addParam(
      InputParams(
        name: name,
        type: InputParamsType.string,
        isRequired: true,
        previewValue: name,
      ),
    );
  }
}
