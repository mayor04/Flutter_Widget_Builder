import 'package:fb_app/layout/sidebar_layout/sidebar_widget.dart';
import 'package:flutter/material.dart';

class SidebarLayout extends StatelessWidget {
  const SidebarLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [const SidebarWidget(), Expanded(child: child)],
      ),
    );
  }
}
