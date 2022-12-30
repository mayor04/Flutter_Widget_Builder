import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

class CreateProjectDialog extends StatelessWidget {
  const CreateProjectDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(30),
      color: AppColors.appDark,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Create Project',
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 50),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.appGrey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              label: Text(
                'Enter Widget Name',
                style: context.textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Create',
              style: context.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
