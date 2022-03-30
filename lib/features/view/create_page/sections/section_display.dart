import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/features/bloc/notifier/notifier_cubit.dart';
import 'package:flutter_widget_builder/features/bloc/overlay/app_overlay_cubit.dart';
import 'package:flutter_widget_builder/features/bloc/widget_tree/widget_tree_bloc.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_details.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_objects/fb_enum.dart';
import 'package:flutter_widget_builder/features/view/create_page/widgets/widget_mapper.dart';

class SectionDisplay extends StatelessWidget {
  const SectionDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 370,
        width: 400,
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

///Adds a border to every widget that is selected
///Also rebuilds child widget when the input changes
class _ChildWidgetBuilder extends StatefulWidget {
  final Map<int, FbWidgetDetails> allWidgetDetails;
  final FbWidgetDetails? details;

  const _ChildWidgetBuilder({
    Key? key,
    required this.allWidgetDetails,
    required this.details,
  }) : super(key: key);

  @override
  State<_ChildWidgetBuilder> createState() => _ChildWidgetBuilderState();
}

class _ChildWidgetBuilderState extends State<_ChildWidgetBuilder> {
  late final FbWidgetDetails? details;
  late final Map<int, FbWidgetDetails> allWidgetDetails;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    details = widget.details;
    allWidgetDetails = widget.allWidgetDetails;
  }

  @override
  Widget build(BuildContext context) {
    if (details == null) {
      return const SizedBox();
    }

    return BlocConsumer<NotifierCubit, NotifierState>(
      listenWhen: (previous, current) {
        return current is NotifierSelected;
      },
      listener: (context, state) {
        isSelected = false;

        if (state is NotifierSelected && state.id == details!.id) {
          isSelected = true;
          showSelectedOverlay(context, details!);
        }
      },
      buildWhen: (prev, current) {
        return current is NotifierStyleChanged;
      },
      builder: (context, state) {
        if ((state is NotifierStyleChanged) && state.id == details!.id) {
          showSelectedOverlay(context, details!);
        } else if ((state is NotifierSelected && state.id == details!.id)) {
          showSelectedOverlay(context, details!);
        }

        return GestureDetector(
          onTap: () {
            context.read<NotifierCubit>().select(details!.id);
          },
          child: getMappedWidget(
            details: details!,
            allWidgetDetails: allWidgetDetails,
          ),
        );
      },
    );
  }

  showSelectedOverlay(BuildContext context, FbWidgetDetails details) async {
    //This should only be ran after rebuild else the context would
    //Only have previous coordinate so add a delay to run after
    await Future.delayed(Duration.zero);
    context.read<AppOverlayCubit>().showSelectionOverlay(
          position: context.position,
          size: context.widgetSize,
          widgetType: details.widgetType,
          parentId: details.id,
        );
  }

  FbWidgetDetails? getChildDetails(int index) {
    return allWidgetDetails[details!.children[index]];
  }

  Widget getMappedWidget({
    required FbWidgetDetails details,
    required Map<int, FbWidgetDetails> allWidgetDetails,
  }) {
    switch (details.childType) {
      case FbChildType.multiple:
        return MultipleChildWidgetMapper(
          widgetStyles: details.styles,
          children: List.generate(details.children.length, (i) {
            var childDetails = getChildDetails(i);
            assert(childDetails != null,
                'Error, could not get child details of a multiple widget');

            //If the child is a positioned then we create a special layout
            if (childDetails?.widgetType == FbWidgetType.positioned) {
              return PositionedChildWidgetMapper(
                widgetStyle: childDetails!.styles,
                parentStyle: details.styles,
                child: _ChildWidgetBuilder(
                  allWidgetDetails: allWidgetDetails,
                  details: allWidgetDetails[childDetails.childAt(0)],
                ),
              );
            }

            return _ChildWidgetBuilder(
              allWidgetDetails: allWidgetDetails,
              details: childDetails!,
            );
          }),
        );

      case FbChildType.single:
        FbWidgetDetails? childDetails;

        if (details.hasChild) {
          childDetails = getChildDetails(0);
          assert(childDetails != null,
              'Error, could not get child details of a single widget');
        }

        return SingleChildWidgetMapper(
          child: details.hasChild
              ? _ChildWidgetBuilder(
                  allWidgetDetails: allWidgetDetails,
                  details: childDetails!,
                )
              //Means this widget has no child
              : const SizedBox(),
          widgetStyles: details.styles,
        );

      default:
        return NoChildChildWidgetMapper(
          widgetStyles: details.styles,
        );
    }
  }
}
