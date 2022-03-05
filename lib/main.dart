import 'package:flutter/material.dart';
import 'package:flutter_widget_builder/config/theme.dart';
import 'package:flutter_widget_builder/features/view/home/home_view.dart';
import 'package:flutter_widget_builder/features/view/playground.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      home: const HomeView(),
    );
  }
}
