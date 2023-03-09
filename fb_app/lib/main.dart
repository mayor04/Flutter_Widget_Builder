import 'package:fb_app/config/theme.dart';
import 'package:fb_app/features/my_apps/views/my_apps_page.dart';
import 'package:fb_app/features/my_apps/views/my_widgets_page.dart';
import 'package:fb_app/features/playground/playground.dart';
import 'package:fb_app/features/widget_creator/bloc/notifier_bloc.dart';
import 'package:fb_app/features/widget_creator/bloc/styles_input_bloc.dart';
import 'package:fb_app/features/widget_creator/bloc/widget_tree_bloc.dart';
import 'package:fb_app/features/widget_creator/controller/code_genarator_controller.dart';
import 'package:fb_app/features/widget_creator/controller/interface_controller.dart';
import 'package:fb_app/features/widget_creator/tabs/params/widget/global_params_widget.dart';
import 'package:fb_app/features/widget_creator/view/create_page.dart';
import 'package:fb_app/layout/sidebar_layout/sidebar_layout.dart';
import 'package:fb_app/layout/tab_layout/tab_layout.dart';
import 'package:fb_core/di.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

import 'features/my_apps/blocs/app_details_bloc.dart';
import 'features/my_apps/blocs/app_list_bloc.dart';
import 'features/my_apps/blocs/widget_details_bloc.dart';
import 'features/my_apps/blocs/widget_list_bloc.dart';
import 'features/widget_creator/bloc/code_display_bloc.dart';

void main() async {
  setPathUrlStrategy();
  await Datastore.initStorage();

  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
      initialLocation: '/your_apps',
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
              path: '/widget',
              builder: (context, state) => Container(),
              routes: [
                GoRoute(
                  path: 'build/:app_id/:widget_id',
                  builder: (context, state) {
                    final interfaceController =
                        InterfaceController(widgetId: state.params['widget_id']!);

                    return MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) =>
                              WidgetListBloc()..loadWidgetList(state.params['app_id']!),
                        ),
                        BlocProvider<WidgetTreeBloc>(
                          create: (_) =>
                              WidgetTreeBloc(interfaceController)..add(InitialWidgetTreeEvent()),
                        ),
                        BlocProvider<StylesInputBloc>(
                            create: (_) => StylesInputBloc(interfaceController)),
                        BlocProvider<NotifierBloc>(create: (_) => NotifierBloc()),
                        BlocProvider<CodeDisplayBloc>(
                          create: (_) => CodeDisplayBloc(
                            generator: CodeGeneratorController(interfaceController),
                          ),
                        ),
                      ],
                      child: GlobalParamsWidget(
                        controller: interfaceController,
                        child: FutureBuilder(
                            future: interfaceController.ensureInitialized(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return CreatePage(fileId: state.params['widget_id']);
                            }),
                      ),
                    );
                  },
                ),
              ],
            ),
            ShellRoute(
              builder: (context, state, child) => SidebarLayout(child: child),
              routes: [
                GoRoute(
                  path: '/your_apps',
                  builder: (context, state) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => AppListBloc(),
                      ),
                      BlocProvider(
                        create: (context) => AppDetailsBloc(),
                      ),
                    ],
                    child: const MyAppsPage(),
                  ),
                ),
                GoRoute(
                  path: '/app_widgets/:app_id',
                  builder: (context, state) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => WidgetDetailsBloc(),
                      ),
                      BlocProvider(
                        create: (context) => WidgetListBloc(),
                      ),
                    ],
                    child: MyWidgetsPage(
                      applicationId: state.params['app_id'],
                    ),
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

/*~NOTES~
- The routes available are
- /widget/build/{fileId} for building widget
- /widget/view/{fileId} opens the widget without buildable access
- /your_apps/
- /app_widgets/{projectId}
*/