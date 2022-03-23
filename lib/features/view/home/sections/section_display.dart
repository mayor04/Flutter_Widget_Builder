import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/core/constant/colors.dart';
import 'package:flutter_widget_builder/core/enum/fb_enum.dart';
import 'package:flutter_widget_builder/core/utils/box_decoration.dart';
import 'package:flutter_widget_builder/core/utils/extension.dart';
import 'package:flutter_widget_builder/core/utils/logg.dart';
import 'package:flutter_widget_builder/features/bloc/notifier/notifier_cubit.dart';
import 'package:flutter_widget_builder/features/bloc/widget_tree/widget_tree_bloc.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_data.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_widgets/base_fb_widget.dart';
import 'package:flutter_widget_builder/features/view/home/widgets/widget_mapper.dart';

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

            return _SelectBorder(
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
class _SelectBorder extends StatefulWidget {
  final Map<int, FbWidgetDetails> allWidgetDetails;
  final FbWidgetDetails details;

  const _SelectBorder({
    Key? key,
    required this.allWidgetDetails,
    required this.details,
  }) : super(key: key);

  @override
  State<_SelectBorder> createState() => _SelectBorderState();
}

class _SelectBorderState extends State<_SelectBorder> {
  late final FbWidgetDetails details;
  late final Map<int, FbWidgetDetails> allWidgetDetails;

  @override
  void initState() {
    super.initState();
    details = widget.details;
    allWidgetDetails = widget.allWidgetDetails;
  }

  @override
  Widget build(BuildContext context) {
    //This bloc consumer/builder might be fired multiple times so we
    //shouldn't be rebuilding the child always
    Widget mappedWidget = const SizedBox();

    if (details.childType == FbChildType.multiple) {
      mappedWidget = MultipleChildWidgetMapper(
        widgetStyles: details.styles,
        children: List.generate(details.children.length, (i) {
          var childDetails = getChildDetails(i);
          assert(childDetails != null,
              'Error, could not get child details of a multiple widget');

          return _SelectBorder(
            allWidgetDetails: allWidgetDetails,
            details: childDetails!,
          );
        }),
      );
    } else {
      FbWidgetDetails? childDetails;

      if (details.hasChild) {
        childDetails = getChildDetails(0);
        assert(childDetails != null,
            'Error, could not get child details of a single widget');
      }

      mappedWidget = SingleChildWidgetMapper(
        child: details.hasChild
            ? _SelectBorder(
                allWidgetDetails: allWidgetDetails,
                details: childDetails!,
              )
            //Means this widget has no child
            : const SizedBox(),
        widgetStyles: details.styles,
      );
    }

    return BlocConsumer<NotifierCubit, NotifierState>(
      listenWhen: (previous, current) {
        return current is NotifierStyleChanged;
      },
      buildWhen: (prev, current) {
        return current is NotifierSelected;
      },
      listener: (context, state) {
        //Since a style has change like the height of the widget all
        //The children should be rebuilded; which means
        //we want to rebuild map widget
        setState(() {});
      },
      builder: (context, state) {
        bool? isSelected = false;

        if (state is NotifierSelected) {
          isSelected = state.id == details.id;
        }

        return Container(
          margin: const EdgeInsets.all(17),
          decoration: CustomDecoration(
            borderColor: isSelected ? Color.fromARGB(255, 1, 233, 183) : null,
            borderWidth: isSelected ? 2 : null,
          ),
          child: GestureDetector(
            onTap: () {
              context.read<NotifierCubit>().select(details.id);
            },
            child: mappedWidget,
          ),
        );
      },
    );
  }

  FbWidgetDetails? getChildDetails(int index) {
    return allWidgetDetails[details.children[index]];
  }
}
