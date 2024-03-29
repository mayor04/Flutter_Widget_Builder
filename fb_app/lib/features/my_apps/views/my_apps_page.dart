import 'package:fb_app/features/my_apps/blocs/app_details_bloc.dart';
import 'package:fb_app/features/my_apps/blocs/app_list_bloc.dart';
import 'package:fb_app/features/my_apps/views/dialog/create_app_dialog.dart';
import 'package:fb_app/features/widget_creator/view/widgets/icon_box.dart';
import 'package:fb_core/fb_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyAppsPage extends StatefulWidget {
  const MyAppsPage({Key? key}) : super(key: key);

  @override
  State<MyAppsPage> createState() => _MyAppsPageState();
}

class _MyAppsPageState extends State<MyAppsPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<AppListBloc>(context).loadProjectList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const _ProjectHeader(),
          const SizedBox(height: 30),
          BlocBuilder<AppListBloc, AppListState>(
            builder: (context, state) {
              return Expanded(
                child: GridView.builder(
                  itemCount: state.projectList.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 270,
                    mainAxisExtent: 300,
                    crossAxisSpacing: 35,
                    mainAxisSpacing: 35,
                  ),
                  itemBuilder: (context, index) {
                    final project = state.projectList[index];

                    return InkWell(
                      onTap: () {
                        context.push('/app_widgets/${project.id}');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              height: 220,
                              color: Colors.blue,
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
                                      project.name,
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
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class _ProjectHeader extends StatelessWidget {
  const _ProjectHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Your Projects',
          style: context.textTheme.bodyMedium?.copyWith(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const Expanded(child: SizedBox()),
        // ElevatedButton(
        //   onPressed: () {
        //     showDialog(
        //       context: context,
        //       builder: (_) => Dialog(
        //         child: BlocProvider.value(
        //           value: context.read<ProjectBloc>(),
        //           child: const CreateWidgetDialog(
        //             projectId: AppStrings.rootProjectId,
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        //   child: Text(
        //     'New Projects',
        //     style: context.textTheme.bodyMedium,
        //   ),
        // ),
        const SizedBox(width: 20),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => Dialog(
                child: BlocProvider.value(
                  value: context.read<AppDetailsBloc>(),
                  child: const CreateProjectDialog(),
                ),
              ),
            );
          },
          child: Container(
            height: 32,
            width: 32,
            color: AppColors.appGrey,
            alignment: Alignment.center,
            child: const Icon(Icons.folder_copy),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
