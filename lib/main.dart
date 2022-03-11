import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/config/theme.dart';
import 'package:flutter_widget_builder/features/bloc/widget_tree/widget_tree_bloc.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
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
    final FbInterfaceController fbController = FbInterfaceController();

    return MultiBlocProvider(
      providers: [
        BlocProvider<WidgetTreeBloc>(
          create: (_) => WidgetTreeBloc(fbController)
            ..add(
              InitialWidgetTreeEvent(),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        home: const HomeView(),
      ),
    );
  }
}
