import 'package:fb_app/features/widget_creator/view/widgets/icon_box.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

class BuilderSidebar extends StatelessWidget {
  const BuilderSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      color: AppColors.appGrey,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: const IconBox(
              icon: Icon(
                Icons.widgets,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
