

// class MyApp extends StatefulWidget {
//   final InterfaceController fbController;

//   const MyApp({Key? key, required this.fbController}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<WidgetTreeBloc>(
//           create: (_) => WidgetTreeBloc(widget.fbController)..add(InitialWidgetTreeEvent()),
//         ),
//         BlocProvider<InputBloc>(create: (_) => InputBloc(widget.fbController)),
//         BlocProvider<NotifierBloc>(create: (_) => NotifierBloc()),
//       ],
//       child: AppOverlayWidget(
//         child: MaterialApp.router(
//           // builder: (context, child) {
//           //   return AppOverlayWidget(child: child ?? Container());
//           // },
//           title: AppStrings.appTitle,
//           theme: AppTheme.darkTheme,
//           // home: const Playground(),
//           routeInformationParser: _router.routeInformationParser,
//           routerDelegate: _router.routerDelegate,
//         ),
//       ),
//     );
//   }

//   // TODO: Perform a redirect to the home page on initial route
//   final _router = GoRouter(
//     urlPathStrategy: UrlPathStrategy.path,
//     debugLogDiagnostics: true,
//     initialLocation: '/create_page/123',
//     // initialLocation: '/playground',
//     routes: [
//       GoRoute(
//         path: '/playground',
//         builder: (context, state) {
//           return const Playground();
//         },
//       ),
//       GoRoute(
//         path: '/',
//         builder: (context, state) {
//           return Container();
//         },
//         routes: [
//           GoRoute(
//             path: 'create_page/:project_id',
//             builder: (context, state) {
//               return CreatePage(
//                 key: state.pageKey,
//               );
//             },
//           ),
//           GoRoute(
//             path: 'home_page',
//             builder: (context, state) {
//               return HomePage(
//                 key: state.pageKey,
//               );
//             },
//           )
//         ],
//       ),
//     ],
//   );
// }
