import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: AppColors.appBg,
      child: Column(
        children: [
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'New Widget',
              style: context.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SidebarTab(
                    title: 'Home',
                    icon: Icon(
                      Icons.home,
                      size: 16,
                      color: AppColors.iconColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const _SidebarTab(
                    title: 'Learn',
                    icon: Icon(
                      Icons.label_important_outline_rounded,
                      size: 16,
                      color: AppColors.iconColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'PROEJCTS',
                    style: context.textTheme.bodyMedium?.copyWith(fontSize: 10),
                  ),
                  const SizedBox(height: 10),
                  const _SidebarTab(
                    title: 'Your Projects',
                    icon: Icon(
                      Icons.book,
                      size: 16,
                      color: AppColors.iconColor,
                    ),
                  ),
                  const _SidebarTab(
                    title: 'Shared Projects',
                    icon: Icon(
                      Icons.share_location_rounded,
                      size: 16,
                      color: AppColors.iconColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarTab extends StatelessWidget {
  const _SidebarTab({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 11),
          Text(
            title,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
