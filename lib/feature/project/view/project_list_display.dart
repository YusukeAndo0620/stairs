import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/board/view/board_screen.dart';
import 'package:stairs/feature/project/component/view/project_list_item.dart';
import 'package:stairs/feature/project/model/project_list_item_model.dart';
import 'package:stairs/feature/project/provider/project_detail_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'project_edit_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kProjectTitleTxt = 'プロジェクト一覧';
const _kProjectListTitlePadding =
    EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);
const _kProjectListItemBorder = 1.0;

final _logger = stairsLogger(name: 'project_list');

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
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return BoardScreen(
                                projectId: item.projectId,
                                title: item.projectName,
                                themeColor: item.themeColorModel.color,
                                devLangList: getDevLangList(
                                    projectId: item.projectId, ref: ref),
                                labelList: getTagList(
                                    projectId: item.projectId, ref: ref));
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<LabelWithContent> getDevLangList(
      {required String projectId, required WidgetRef ref}) {
    //プロジェクト詳細
    final projectDetailState = ref.watch(projectDetailProvider(
        projectId: projectId, database: ref.watch(databaseProvider)));
    return projectDetailState.value == null
        ? []
        : projectDetailState.value!.devLanguageList;
  }

  List<ColorLabelModel> getTagList(
      {required String projectId, required WidgetRef ref}) {
    //プロジェクト詳細
    final projectDetailState = ref.watch(projectDetailProvider(
        projectId: projectId, database: ref.watch(databaseProvider)));
    return projectDetailState.value == null
        ? []
        : projectDetailState.value!.tagList;
  }
}
