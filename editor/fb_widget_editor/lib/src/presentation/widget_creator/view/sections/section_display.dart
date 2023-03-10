import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:fb_core/src/widgets/app_overlay.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/bloc/notifier_bloc.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/bloc/widget_tree_bloc.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/models/fb_details.dart';
import 'package:fb_widget_editor/src/presentation/widget_creator/tabs/params/widget/global_params_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionDisplay extends StatelessWidget {
  const SectionDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 600,
        width: 600,
        color: Colors.white,
        alignment: Alignment.center,
        child: BlocBuilder<WidgetTreeBloc, WidgetTreeState>(
          builder: (context, state) {
            var firstWidgetDetails = state.firstWidgetDetails;

            if (firstWidgetDetails == null) {
              return Container();
            }

            return _ChildWidgetBuilder(
              details: firstWidgetDetails,
              allWidgetDetails: state.fbDetailsMap,
            );
          },
        ),
      ),
    );
  }
}

/// Adds a border to every widget that is selected
/// Also rebuilds child widget when the input changes
class _ChildWidgetBuilder extends StatefulWidget {
  final Map<String, FbWidgetDetails> allWidgetDetails;
  final FbWidgetDetails details;

  const _ChildWidgetBuilder({
    Key? key,
    required this.allWidgetDetails,
    required this.details,
  }) : super(key: key);

  @override
  State<_ChildWidgetBuilder> createState() => _ChildWidgetBuilderState();
}

class _ChildWidgetBuilderState extends State<_ChildWidgetBuilder> {
  late FbWidgetDetails details;
  late Map<String, FbWidgetDetails> allWidgetDetails;
  late Map<String, BaseFbConfig> allWidgetConfig;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    details = widget.details;
    allWidgetDetails = widget.allWidgetDetails;
  }

  @override
  Widget build(BuildContext context) {
    details = widget.details;

    final bloc = BlocProvider.of<WidgetTreeBloc>(context);
    allWidgetDetails = bloc.state.fbDetailsMap;
    allWidgetConfig = bloc.state.fbConfigMap;

    return BlocConsumer<NotifierBloc, NotifierState>(
      listenWhen: (previous, current) {
        return current is NotifierSelected;
      },
      listener: (context, state) {
        isSelected = false;

        if (state is NotifierSelected && state.id == details.id) {
          isSelected = true;
          showSelectedOverlay(context, details);
        }
      },
      buildWhen: (prev, current) {
        return current is NotifierStyleChanged;
      },
      builder: (context, state) {
        if ((state is NotifierStyleChanged) && state.id == details.id) {
          showSelectedOverlay(context, details);
        } else if ((state is NotifierSelected && state.id == details.id)) {
          showSelectedOverlay(context, details);
        }

        void selectCallback() => context.read<NotifierBloc>().select(details.id);
        final widgetStyles = allWidgetConfig[details.id]!.getWidgetStyles();

        if (details.widgetType == FbWidgetType.expanded ||
            details.widgetType == FbWidgetType.positioned) {
          return _buildParenDataWidget(
            details: details,
            allWidgetDetails: allWidgetDetails,
            widgetStyles: widgetStyles,
          );
        }

        final GlobalParamsMap globalParams = GlobalParamsWidget.of(context).parameters;

        switch (details.childType) {
          case FbChildType.single:
            return _buildSingleChildWidget(
              onTap: selectCallback,
              details: details,
              allWidgetDetails: allWidgetDetails,
              widgetStyles: widgetStyles,
            );
          case FbChildType.multiple:
            return _buildMultipleChildWidget(
              onTap: selectCallback,
              details: details,
              allWidgetDetails: allWidgetDetails,
              widgetStyles: widgetStyles,
            );
          default:
            return NoChildChildWidgetBuilder(
              onTap: selectCallback,
              widgetStyles: widgetStyles,
              globalParams: globalParams,
            );
        }
      },
    );
  }

  showSelectedOverlay(BuildContext context, FbWidgetDetails details) async {
    // This should only run after rebuild else the context would
    // Only have previous coordinate so add a delay to run after
    await Future.delayed(Duration.zero);

    AppOverlay.showWidgetSelection(
      context,
      position: context.position,
      size: context.widgetSize,
    );
  }

  FbWidgetDetails? getChildDetailsAt(int index) {
    return allWidgetDetails[details.children.itemAt(index)];
  }

  Widget _buildSingleChildWidget({
    required FbWidgetDetails details,
    required BaseFbStyles widgetStyles,
    required Map<String, FbWidgetDetails> allWidgetDetails,
    required VoidCallback onTap,
  }) {
    FbWidgetDetails? childDetails;

    if (details.hasChild) {
      childDetails = getChildDetailsAt(0);
      assert(childDetails != null, 'Error, could not get child details of a single widget');
    }

    return SingleChildWidgetBuilder(
      onTap: onTap,
      widgetStyles: widgetStyles,
      child: details.hasChild && childDetails != null
          ? _ChildWidgetBuilder(
              allWidgetDetails: allWidgetDetails,
              details: childDetails,
            )
          //Means this widget has no child
          : const SizedBox(),
    );
  }

  Widget _buildParenDataWidget({
    required FbWidgetDetails details,
    required BaseFbStyles widgetStyles,
    required Map<String, FbWidgetDetails> allWidgetDetails,
  }) {
    FbWidgetDetails? childDetails;

    if (details.hasChild) {
      childDetails = getChildDetailsAt(0);
      assert(childDetails != null, 'Error, could not get child details of a single widget');
    }

    return ParentDataWidgetBuilder(
      widgetStyles: widgetStyles,
      child: details.hasChild && childDetails != null
          ? _ChildWidgetBuilder(
              allWidgetDetails: allWidgetDetails,
              details: childDetails,
            )
          //Means this widget has no child
          : const SizedBox(),
    );
  }

  Widget _buildMultipleChildWidget({
    required FbWidgetDetails details,
    required BaseFbStyles widgetStyles,
    required Map<String, FbWidgetDetails> allWidgetDetails,
    required VoidCallback onTap,
  }) {
    return MultipleChildWidgetBuilder(
      onTap: onTap,
      widgetStyles: widgetStyles,
      children: List.generate(details.children.length, (i) {
        var childDetails = getChildDetailsAt(i);
        assert(childDetails != null, 'Error, could not get child details of a multiple widget');

        if (childDetails == null) {
          return const SizedBox();
        }

        return _ChildWidgetBuilder(
          allWidgetDetails: allWidgetDetails,
          details: childDetails,
        );
      }),
    );
  }
}
