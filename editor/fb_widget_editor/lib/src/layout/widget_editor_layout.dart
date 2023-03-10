import 'package:fb_widget_editor/src/presentation/widget_creator/bloc/code_display_bloc.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/bloc/notifier_bloc.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/bloc/styles_input_bloc.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/bloc/widget_list_bloc.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/bloc/widget_tree_bloc.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/controller/code_genarator_controller.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/controller/interface_controller.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/tabs/params/widget/global_params_widget.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/view/create_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WidgetEditorLayout extends StatelessWidget {
  const WidgetEditorLayout({super.key, required this.state});

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    final interfaceController = InterfaceController(widgetId: state.params['widget_id']!);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WidgetListBloc()..loadWidgetList(state.params['app_id']!),
        ),
        BlocProvider<WidgetTreeBloc>(
          create: (_) => WidgetTreeBloc(interfaceController)..add(InitialWidgetTreeEvent()),
        ),
        BlocProvider<StylesInputBloc>(create: (_) => StylesInputBloc(interfaceController)),
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
          },
        ),
      ),
    );
  }
}
