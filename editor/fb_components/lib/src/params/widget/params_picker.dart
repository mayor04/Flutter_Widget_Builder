import 'package:fb_components/src/params/input_params/input_params.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:super_overlay/super_overlay.dart';

class ParamsPicker extends StatefulWidget {
  const ParamsPicker({
    required this.styleName,
    required this.globalParams,
    required this.onParamsSelected,
    required this.onParamsRemoved,
    required this.child,
    super.key,
  });

  final String styleName;
  final Map<String, InputParams> globalParams;
  final Function(String key, String paramsId) onParamsSelected;
  final Function(String key) onParamsRemoved;
  final Widget child;

  @override
  State<ParamsPicker> createState() => _ParamsPickerState();
}

class _ParamsPickerState extends State<ParamsPicker> {
  final overlayController = OverlayController<String>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        overlayController.show();
      },
      child: SuperOverlay(
        childAnchor: Alignment.center,
        overlayAnchor: Alignment.topLeft,
        controller: overlayController,
        offset: const Offset(-60, -23),
        overlay: (context, value) {
          return Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: AppColors.appDark,
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Text(
                  widget.styleName,
                  style: context.textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 220,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: const BoxDecoration(
                    color: AppColors.appGrey,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...widget.globalParams.entries.map(
                        (entry) => GestureDetector(
                          onTap: () {
                            widget.onParamsSelected(widget.styleName, entry.value.id);
                            overlayController.remove();
                          },
                          child: _ParamsPickerItem(
                            name: entry.value.name,
                            paramType: entry.value.type,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class _ParamsPickerItem extends StatelessWidget {
  const _ParamsPickerItem({
    Key? key,
    required this.name,
    required this.paramType,
  }) : super(key: key);

  final String name;
  final InputParamsType paramType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 5),
          Text(
            paramType.name,
            style: context.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
