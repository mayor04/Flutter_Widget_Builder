import 'package:fb_app/config/theme.dart';
import 'package:fb_app/features/home/views/home_page.dart';
import 'package:fb_app/features/playground/playground.dart';
import 'package:fb_app/features/widget_creator/bloc/input_bloc.dart';
import 'package:fb_app/features/widget_creator/bloc/notifier_bloc.dart';
import 'package:fb_app/features/widget_creator/bloc/widget_tree_bloc.dart';
import 'package:fb_app/features/widget_creator/controller/interface_controller.dart';
import 'package:fb_app/features/widget_creator/view/create_page.dart';
import 'package:fb_core/fb_core.dart';
import 'package:fb_core/src/widgets/app_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatefulWidget {
  final InterfaceController fbController;

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
          create: (_) => WidgetTreeBloc(widget.fbController)..add(InitialWidgetTreeEvent()),
        ),
        BlocProvider<InputBloc>(create: (_) => InputBloc(widget.fbController)),
        BlocProvider<NotifierBloc>(create: (_) => NotifierBloc()),
      ],
      child: AppOverlayWidget(
        child: MaterialApp.router(
          // builder: (context, child) {
          //   return AppOverlayWidget(child: child ?? Container());
          // },
          title: AppStrings.appTitle,
          theme: AppTheme.darkTheme,
          // home: const Playground(),
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
        ),
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
