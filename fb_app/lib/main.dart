import 'package:fb_app/config/theme.dart';
import 'package:fb_app/features/my_apps/views/my_apps_page.dart';
import 'package:fb_app/features/my_apps/views/my_widgets_page.dart';
import 'package:fb_app/features/playground/playground.dart';
import 'package:fb_app/layout/sidebar_layout/sidebar_layout.dart';
import 'package:fb_app/layout/tab_layout/tab_layout.dart';
import 'package:fb_core/fb_core.dart';
import 'package:fb_widget_editor/fb_widget_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

import 'features/my_apps/blocs/app_details_bloc.dart';
import 'features/my_apps/blocs/app_list_bloc.dart';
import 'features/my_apps/blocs/widget_details_bloc.dart';
import 'features/my_apps/blocs/widget_list_bloc.dart';

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
                    builder: (context, state) => WidgetEditorLayout(state: state)),
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