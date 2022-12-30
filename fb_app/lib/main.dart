import 'package:fb_app/config/theme.dart';
import 'package:fb_app/features/home/presentation/blocs/project_list_bloc.dart';
import 'package:fb_app/features/home/presentation/sidebar_view/your_project_view.dart';
import 'package:fb_app/features/home/presentation/views/home_layout.dart';
import 'package:fb_app/features/playground/playground.dart';
import 'package:fb_app/features/tab/view/tab_layout.dart';
import 'package:fb_app/features/widget_creator/bloc/input_bloc.dart';
import 'package:fb_app/features/widget_creator/bloc/notifier_bloc.dart';
import 'package:fb_app/features/widget_creator/bloc/widget_tree_bloc.dart';
import 'package:fb_app/features/widget_creator/controller/code_genarator_controller.dart';
import 'package:fb_app/features/widget_creator/controller/interface_controller.dart';
import 'package:fb_app/features/widget_creator/view/create_page.dart';
import 'package:fb_core/fb_core.dart';
import 'package:fb_core/src/widgets/app_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

import 'features/home/presentation/blocs/project_bloc.dart';
import 'features/widget_creator/bloc/code_display_bloc.dart';

void main() async {
  setPathUrlStrategy();
  await Datastore.initStorage();

  runApp(MyApp(
    fbController: InterfaceController(),
  ));
}

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
    // TODO: Perform a redirect to the home page on initial route
    final _router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/your_projects',
      routes: [
        GoRoute(
          path: '/play',
          builder: (context, state) {
            return const Playground();
          },
        ),
        ShellRoute(
          builder: (context, state, child) => TabLayout(child: child),
          routes: [
            GoRoute(
              path: '/create/:project_id',
              builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider<WidgetTreeBloc>(
                    create: (_) =>
                        WidgetTreeBloc(widget.fbController)..add(InitialWidgetTreeEvent()),
                  ),
                  BlocProvider<InputBloc>(create: (_) => InputBloc(widget.fbController)),
                  BlocProvider<NotifierBloc>(create: (_) => NotifierBloc()),
                  BlocProvider<CodeDisplayBloc>(
                    create: (_) => CodeDisplayBloc(
                      generator: CodeGeneratorController(widget.fbController),
                    ),
                  ),
                ],
                child: const CreatePage(),
              ),
            ),
            ShellRoute(
              builder: (context, state, child) => HomeLayout(child: child),
              routes: [
                GoRoute(
                  path: '/your_projects',
                  builder: (context, state) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => ProjectListBloc(),
                      ),
                      BlocProvider(
                        create: (context) => ProjectBloc(),
                      ),
                    ],
                    child: const YourProjectsView(),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
    return AppOverlayWidget(
      child: MaterialApp.router(
        title: AppStrings.appTitle,
        theme: AppTheme.darkTheme,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        routeInformationProvider: _router.routeInformationProvider,
      ),
    );
  }
}
