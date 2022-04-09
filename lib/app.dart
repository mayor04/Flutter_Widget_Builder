import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/config/theme.dart';
import 'package:flutter_widget_builder/core/constant/strings.dart';
import 'package:flutter_widget_builder/features/bloc/notifier/notifier_cubit.dart';
import 'package:flutter_widget_builder/features/bloc/overlay/app_overlay_cubit.dart';
import 'package:flutter_widget_builder/features/bloc/styles_input/input_bloc.dart';
import 'package:flutter_widget_builder/features/bloc/widget_tree/widget_tree_bloc.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/view/create_page/create_page.dart';
import 'package:flutter_widget_builder/features/view/home_page/home_page.dart';
import 'package:flutter_widget_builder/features/view/playground.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatefulWidget {
  final FbInterfaceController fbController;

  const MyApp({Key? key, required this.fbController}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WidgetTreeBloc>(
          create: (_) => WidgetTreeBloc(widget.fbController)
            ..add(InitialWidgetTreeEvent()),
        ),
        BlocProvider<InputBloc>(create: (_) => InputBloc(widget.fbController)),
        BlocProvider<NotifierCubit>(create: (_) => NotifierCubit()),
        BlocProvider<AppOverlayCubit>(create: (_) => AppOverlayCubit()),
      ],
      child: MaterialApp.router(
        title: AppStrings.appTitle,
        theme: AppTheme.darkTheme,
        // home: const Playground(),
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
      ),
    );
  }

  // TODO: Perform a redirect to the home page on initial route
  final _router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    debugLogDiagnostics: true,
    initialLocation: '/create_page/123',
    // initialLocation: '/playground',
    routes: [
      GoRoute(
        path: '/playground',
        builder: (context, state) {
          return const Playground();
        },
      ),
      GoRoute(
        path: '/',
        builder: (context, state) {
          return Container();
        },
        routes: [
          GoRoute(
            path: 'create_page/:project_id',
            builder: (context, state) {
              return CreatePage(
                key: state.pageKey,
              );
            },
          ),
          GoRoute(
            path: 'home_page',
            builder: (context, state) {
              return HomePage(
                key: state.pageKey,
              );
            },
          )
        ],
      ),
    ],
  );
}
