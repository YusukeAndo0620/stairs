import 'package:stairs/feature/board/view/board_screen.dart';
import 'package:stairs/feature/project/component/view/project_list_item.dart';
import 'package:stairs/feature/project/model/project_detail_model.dart';
import 'package:stairs/feature/project/model/project_list_item_model.dart';
import 'package:stairs/feature/project/provider/project_detail_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'project_edit_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kProjectTitleTxt = 'プロジェクト一覧';
const _kProjectListTitlePadding =
    EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);
const _kProjectListItemBorder = 1.0;
final _logger = stairsLogger(name: 'project_list_display');

class ProjectListDisplay extends ConsumerWidget {
  const ProjectListDisplay({super.key, required this.projectList});

  final List<ProjectListItemModel> projectList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(theme.icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return const ProjectEditModal(
                projectId: '',
              );
            },
          );
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: _kProjectListTitlePadding,
            decoration: BoxDecoration(
              color: theme.colorFgDefaultWhite,
              border: Border(
                bottom: BorderSide(
                  color: theme.colorFgDefault,
                  width: _kProjectListItemBorder,
                ),
              ),
            ),
            child: Text(
              _kProjectTitleTxt,
              style: theme.textStyleSubHeading,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (final item in projectList)
                    ProjectListItem(
                      projectId: item.projectId,
                      projectName: item.projectName,
                      themeColor: item.themeColorModel.color,
                      onTap: () async {
                        _getProjectDetail(projectId: item.projectId, ref: ref)
                            .then(
                          (detail) => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return BoardScreen(
                                  projectId: item.projectId,
                                  title: item.projectName,
                                  themeColor: item.themeColorModel.color,
                                  devLangList: detail != null
                                      ? detail.devLanguageList
                                      : [],
                                  labelList:
                                      detail != null ? detail.tagList : [],
                                );
                              },
                            ),
                          ),
                        );
                        // final projectDetailState = ref.watch(
                        //     projectDetailProvider(
                        //         projectId: item.projectId,
                        //         database: ref.watch(databaseProvider)));
                        // projectDetailState.when(
                        //   data: (detail) => Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder: (context) {
                        //         _logger.d('detail');
                        //         return BoardScreen(
                        //           projectId: item.projectId,
                        //           title: item.projectName,
                        //           themeColor: item.themeColorModel.color,
                        //           devLangList: detail != null
                        //               ? detail.devLanguageList
                        //               : [],
                        //           labelList:
                        //               detail != null ? detail.tagList : [],
                        //         );
                        //       },
                        //     ),
                        //   ),
                        //   error: (error, _) =>
                        //       Align(child: Text(error.toString())),
                        //   loading: () => const Align(
                        //     child: CircularProgressIndicator(),
                        //   ),
                        // );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<ProjectDetailModel?> _getProjectDetail(
      {required String projectId, required WidgetRef ref}) async {
    ProjectDetailModel? detail;
    //プロジェクト詳細
    final projectDetailNotifier =
        ref.watch(projectDetailProvider(projectId: projectId).notifier);
    detail = await projectDetailNotifier.getDetail(
      projectId: projectId,
    );
    return detail;
  }
}
