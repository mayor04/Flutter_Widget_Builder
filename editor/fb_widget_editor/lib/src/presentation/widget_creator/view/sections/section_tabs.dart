import 'package:fb_core/fb_core.dart';
import 'package:fb_core/src/widgets/icon_box.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/tabs/tab_type_enum.dart';
import 'package:flutter/material.dart';

class SectionTabs extends StatefulWidget {
  const SectionTabs({
    Key? key,
    required this.onTabChanged,
  }) : super(key: key);

  final ValueChanged<TabType> onTabChanged;

  @override
  State<SectionTabs> createState() => _SectionTabsState();
}

class _SectionTabsState extends State<SectionTabs> {
  TabType _currentTab = TabType.widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      color: AppColors.appDark,
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          _TabItem(
            icon: const Icon(
              Icons.widgets,
              color: AppColors.inputBorder,
              size: 21,
            ),
            currentTab: _currentTab,
            tabType: TabType.widget,
            onTabChanged: onTabChanged,
            tabTitle: 'Widget',
          ),
          const SizedBox(height: 50),
          _TabItem(
            icon: const Icon(
              Icons.panorama_photosphere_outlined,
              color: AppColors.inputBorder,
              size: 21,
            ),
            currentTab: _currentTab,
            tabType: TabType.parameters,
            onTabChanged: onTabChanged,
            tabTitle: 'Parameters',
          ),
        ],
      ),
    );
  }

  void onTabChanged(TabType tabType) {
    setState(() {
      _currentTab = tabType;
    });
    widget.onTabChanged(tabType);
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    Key? key,
    required this.currentTab,
    required this.tabType,
    required this.onTabChanged,
    required this.icon,
    required this.tabTitle,
  }) : super(key: key);

  final TabType currentTab;
  final TabType tabType;
  final ValueChanged<TabType> onTabChanged;
  final Widget icon;
  final String tabTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTabChanged(tabType);
      },
      child: IconBox(
        filled: currentTab == tabType,
        tooltip: tabTitle,
        icon: icon,
      ),
    );
  }
}
