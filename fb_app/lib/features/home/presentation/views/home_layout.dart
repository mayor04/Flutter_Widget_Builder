import 'package:fb_app/features/home/presentation/widgets/home_sidebar.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [const HomeSidebar(), Expanded(child: child)],
      ),
    );
  }
}
