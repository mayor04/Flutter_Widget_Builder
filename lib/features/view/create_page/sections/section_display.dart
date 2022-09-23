import 'package:fb_components/fb_components.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/features/view/overlay/app_overlay.dart';
import 'package:flutter_widget_builder/features/widget_creator/bloc/notifier_bloc.dart';
import 'package:flutter_widget_builder/features/widget_creator/bloc/widget_tree_bloc.dart';
import 'package:flutter_widget_builder/features/widget_creator/controller/fb_details.dart';

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
  final Map<int, FbWidgetDetails> allWidgetDetails;
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
  late Map<int, FbWidgetDetails> allWidgetDetails;
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
    allWidgetDetails = widget.allWidgetDetails;

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

        if (details.widgetType == FbWidgetType.expanded ||
            details.widgetType == FbWidgetType.positioned) {
          return _buildParenDataWidget(
            details: details,
            allWidgetDetails: allWidgetDetails,
          );
        }

        switch (details.childType) {
          case FbChildType.single:
            return _buildSingleChildWidget(
              onTap: selectCallback,
              details: details,
              allWidgetDetails: allWidgetDetails,
            );
          case FbChildType.multiple:
            return _buildMultipleChildWidget(
              onTap: selectCallback,
              details: details,
              allWidgetDetails: allWidgetDetails,
            );
          default:
            return NoChildChildWidgetBuilder(
              widgetStyles: details.styles,
              onTap: selectCallback,
            );
        }

        // return GestureDetector(
        //   onTap: () {
        //     context.read<NotifierCubit>().select(details!.id);
        //   },
        //   child: getMappedWidget(
        //     details: details!,
        //     allWidgetDetails: allWidgetDetails,
        //   ),
        // );
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
    required Map<int, FbWidgetDetails> allWidgetDetails,
    required VoidCallback onTap,
  }) {
    FbWidgetDetails? childDetails;

    if (details.hasChild) {
      childDetails = getChildDetailsAt(0);
      assert(childDetails != null, 'Error, could not get child details of a single widget');
    }

    return SingleChildWidgetBuilder(
      onTap: onTap,
      child: details.hasChild && childDetails != null
          ? _ChildWidgetBuilder(
              allWidgetDetails: allWidgetDetails,
              details: childDetails,
            )
          //Means this widget has no child
          : const SizedBox(),
      widgetStyles: details.styles,
    );
  }

  Widget _buildParenDataWidget({
    required FbWidgetDetails details,
    required Map<int, FbWidgetDetails> allWidgetDetails,
  }) {
    FbWidgetDetails? childDetails;

    if (details.hasChild) {
      childDetails = getChildDetailsAt(0);
      assert(childDetails != null, 'Error, could not get child details of a single widget');
    }

    return ParentDataWidgetBuilder(
      child: details.hasChild && childDetails != null
          ? _ChildWidgetBuilder(
              allWidgetDetails: allWidgetDetails,
              details: childDetails,
            )
          //Means this widget has no child
          : const SizedBox(),
      widgetStyles: details.styles,
    );
  }

  Widget _buildMultipleChildWidget({
    required FbWidgetDetails details,
    required Map<int, FbWidgetDetails> allWidgetDetails,
    required VoidCallback onTap,
  }) {
    return MultipleChildWidgetBuilder(
      onTap: onTap,
      widgetStyles: details.styles,
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

  // Widget getMappedWidget({
  //   required FbWidgetDetails details,
  //   required Map<int, FbWidgetDetails> allWidgetDetails,
  // }) {
  //   switch (details.childType) {
  //     case FbChildType.multiple:
  //       return MultipleChildWidgetMapper(
  //         widgetStyles: details.styles,
  //         children: List.generate(details.children.length, (i) {
  //           var childDetails = getChildDetailsAt(i);
  //           assert(childDetails != null, 'Error, could not get child details of a multiple widget');

  //           //If the child is a positioned then we create a special layout
  //           if (childDetails?.widgetType == FbWidgetType.positioned) {
  //             return PositionedChildWidgetMapper(
  //               widgetStyle: childDetails!.styles,
  //               parentStyle: details.styles,
  //               child: _ChildWidgetBuilder(
  //                 allWidgetDetails: allWidgetDetails,
  //                 details: allWidgetDetails[childDetails.childAt(0)],
  //               ),
  //             );
  //           }

  //           return _ChildWidgetBuilder(
  //             allWidgetDetails: allWidgetDetails,
  //             details: childDetails!,
  //           );
  //         }),
  //       );

  //     case FbChildType.single:
  //       FbWidgetDetails? childDetails;

  //       if (details.hasChild) {
  //         childDetails = getChildDetailsAt(0);
  //         assert(childDetails != null, 'Error, could not get child details of a single widget');
  //       }

  //       return SingleChildWidgetMapper(
  //         child: details.hasChild
  //             ? _ChildWidgetBuilder(
  //                 allWidgetDetails: allWidgetDetails,
  //                 details: childDetails!,
  //               )
  //             //Means this widget has no child
  //             : const SizedBox(),
  //         widgetStyles: details.styles,
  //       );

  //     default:
  //       return NoChildChildWidgetMapper(
  //         widgetStyles: details.styles,
  //       );
  //   }
  // }
}
