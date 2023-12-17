import 'package:stairs/feature/project/component/view/project_list_item.dart';
import 'package:stairs/feature/project/model/project_list_item_model.dart';
import 'package:stairs/loom/loom_package.dart';
import 'project_edit_modal.dart';

const _kProjectTitleTxt = 'プロジェクト一覧';
const _kProjectListTitlePadding =
    EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);
const _kProjectListItemBorder = 1.0;

class ProjectListDisplay extends StatelessWidget {
  const ProjectListDisplay({super.key, required this.projectList});

  final List<ProjectListItemModel> projectList;

  @override
  Widget build(BuildContext context) {
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
                  for (final listItem in projectList)
                    ProjectListItem(
                      projectId: listItem.projectId,
                      projectName: listItem.projectName,
                      themeColor: listItem.themeColorModel.color,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const SizedBox();
                            // return BoardScreen(
                            //   projectId: listItem.projectId,
                            //   title: listItem.projectName,
                            //   themeColor: listItem.themeColor,
                            // );
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
}
