import 'package:flutter/material.dart';

///Only home route present at the moment
class AppRoutes {
  static const String home = '/';
  static const String savedWidget = '/savedWidget';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      // case home:
      //   return MaterialPageRoute(builder: (_) => const IntroView());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No Route Found')),
          ),
        );
    }
  }
}
