import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

class TabHeader extends StatelessWidget {
  const TabHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      color: AppColors.appDarker,
      child: Row(
        children: const [
          SizedBox(
            width: 70,
            child: Icon(
              Icons.home,
              color: AppColors.inputBorder,
              size: 21,
            ),
          ),
          _Tab(),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appGrey,
      width: 150,
      alignment: Alignment.center,
      child: Text(
        'Twitter widget',
        style: context.textTheme.bodyMedium,
      ),
    );
  }
}
