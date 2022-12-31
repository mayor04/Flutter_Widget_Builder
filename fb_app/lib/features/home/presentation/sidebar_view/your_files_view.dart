import 'package:fb_app/features/home/presentation/blocs/file_bloc.dart';
import 'package:fb_app/features/home/presentation/blocs/file_list_bloc.dart';
import 'package:fb_app/features/home/presentation/dialogs/create_widget_dialog.dart';
import 'package:fb_app/features/widget_creator/view/widgets/icon_box.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class YourFilesView extends StatefulWidget {
  const YourFilesView({Key? key, required this.projectId}) : super(key: key);

  final String? projectId;

  @override
  State<YourFilesView> createState() => _YourFilesViewState();
}

class _YourFilesViewState extends State<YourFilesView> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<FileListBloc>(context).loadFileList(widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileListBloc, FileListState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _FilesHeader(
                projectName: state.projectName,
                projectId: widget.projectId,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  itemCount: state.fileList.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 270,
                    mainAxisExtent: 320,
                    crossAxisSpacing: 35,
                    mainAxisSpacing: 35,
                  ),
                  itemBuilder: (context, index) {
                    final file = state.fileList[index];

                    return Column(
                      children: [
                        Container(
                          height: 220,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  file.name,
                                  style: context.textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 9),
                                Text(
                                  '10 months ago',
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTapUp: (tapDetails) {},
                              child: const IconBox(
                                filled: true,
                                icon: Icon(Icons.more_horiz),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilesHeader extends StatelessWidget {
  const _FilesHeader({
    Key? key,
    required this.projectName,
    required this.projectId,
  }) : super(key: key);

  final String projectName;
  final String? projectId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => context.pop(),
          child: Container(
            height: 32,
            width: 32,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.appGrey,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        const SizedBox(width: 25),
        Text(
          projectName,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Expanded(child: SizedBox()),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => Dialog(
                child: BlocProvider.value(
                  value: context.read<FileBloc>(),
                  child: CreateWidgetDialog(
                    projectId: projectId ?? AppStrings.rootProjectId,
                  ),
                ),
              ),
            );
          },
          child: Text(
            'Create Widget',
            style: context.textTheme.bodyMedium,
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
