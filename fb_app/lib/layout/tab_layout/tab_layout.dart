import 'package:fb_app/layout/tab_layout/tab_header.dart';
import 'package:flutter/material.dart';

class TabLayout extends StatelessWidget {
  const TabLayout({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TabHeader(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
