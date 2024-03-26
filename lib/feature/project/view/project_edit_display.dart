import 'package:stairs/feature/common/provider/db_provider.dart';
import 'package:stairs/feature/common/provider/git_provider.dart';
import 'package:stairs/feature/common/provider/mw_provider.dart';
import 'package:stairs/feature/common/provider/os_provider.dart';
import 'package:stairs/feature/common/provider/tool_provider.dart';
import 'package:stairs/feature/project/provider/component/dev_lang_provider.dart';
import 'package:stairs/feature/project/enum/project_update_param.dart';
import 'package:stairs/feature/project/provider/project_detail_provider.dart';
import 'package:stairs/feature/project/provider/project_list_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kContentMaxLength = 500;
const _kContentMaxLines = 10;

const _kProjectAndBoardSpace = 30.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0);
final _logger = stairsLogger(name: 'project_edit_display');

class ProjectEditDisplay extends ConsumerStatefulWidget {
  const ProjectEditDisplay({
    super.key,
    required this.projectId,
  });

  final String projectId;
  @override
  ProjectEditDisplayState createState() => ProjectEditDisplayState();
}

class ProjectEditDisplayState extends ConsumerState<ProjectEditDisplay> {
  bool isNewProject = false;
  final List<ProjectUpdateParam> updateParamList = [];

  @override
  void initState() {
    super.initState();
    if (widget.projectId.isEmpty) {
      isNewProject = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _logger.d('===================================');
    _logger.d('プロジェクト編集モーダル 表示 {projectId:${widget.projectId}');
    final theme = LoomTheme.of(context);
    final t = Translations.of(context);

    // プロジェクト詳細
    final projectDetailState =
        ref.watch(projectDetailProvider(projectId: widget.projectId));

    // プロジェクト詳細 Notifier
    final projectDetailNotifier =
        ref.watch(projectDetailProvider(projectId: widget.projectId).notifier);

    // プロジェクト一覧 Notifier
    final projectListNotifier = ref.watch(projectListProvider.notifier);

    // OS一覧
    final osList = ref.watch(osProvider);
    final osNotifier = ref.watch(osProvider.notifier);

    // DB一覧
    final dbList = ref.watch(dbProvider);
    final dbNotifier = ref.watch(dbProvider.notifier);

    // 開発言語一覧
    final devLangList = ref.watch(devLangProvider);

    // Git一覧
    final gitList = ref.watch(gitProvider);
    final gitNotifier = ref.watch(gitProvider.notifier);

    // ミドルウェア一覧
    final mwList = ref.watch(mwProvider);
    final mwNotifier = ref.watch(mwProvider.notifier);

    // 開発Tool一覧
    final toolList = ref.watch(toolProvider);
    final toolNotifier = ref.watch(toolProvider.notifier);

    // 開発工程一覧
    final devProgressList = ref.watch(devProgressProvider);
    final devProgressNotifier = ref.watch(devProgressProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            theme.icons.back,
            color: theme.colorFgDefault,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          AbsorbPointer(
            absorbing: !isNewProject && updateParamList.isEmpty,
            child: IconButton(
              icon: Icon(
                theme.icons.done,
                color: !isNewProject && updateParamList.isEmpty
                    ? theme.colorDisabled
                    : theme.colorPrimary,
              ),
              onPressed: () {
                isNewProject
                    ? projectDetailNotifier.createProject()
                    : updateParamList.isNotEmpty
                        ? projectDetailNotifier.updateProject(
                            updateParamList: updateParamList)
                        : null;
                projectListNotifier.setProjectList();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
        backgroundColor: theme.colorBgLayer1,
      ),
      body: projectDetailState.when(
        data: (detail) {
          // 単一レコードの横幅
          final secondaryItemWidth = MediaQuery.of(context).size.width * 0.52;
          // 2行表示するレコードの横幅
          final fullWidth = MediaQuery.of(context).size.width * 0.85;
          return detail == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: _kContentPadding,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CardLstItem.header(
                          title: t.project.name,
                          bgColor: theme.colorBgLayer1,
                        ),
                        // プロジェクト名
                        CardLstItem.input(
                            width: secondaryItemWidth,
                            label: t.project.name,
                            iconColor: theme.colorPrimary,
                            iconData: theme.icons.project,
                            inputValue: detail.projectName,
                            hintText:
                                t.common.hintWithTitle(title: t.project.name),
                            onSubmitted: (projectName) {
                              if (detail.projectName != projectName) {
                                addUpdateParam(
                                    param: ProjectUpdateParam.project);
                                projectDetailNotifier.changeProjectName(
                                    projectName: projectName);
                              }
                            }),
                        // 色
                        CardLstItem.labeWithIcon(
                          width: secondaryItemWidth,
                          label: t.common.color,
                          iconData: Icons.palette,
                          iconColor: theme.colorPrimary,
                          hintText: t.common.colorHint,
                          itemList: [
                            ColorBox(
                              color: detail.themeColorModel.color,
                            ),
                          ],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectColorDisplay(
                                  title: t.common.color,
                                  selectedColorInfo:
                                      detail.themeColorModel.color,
                                  onTap: (id) {},
                                  onTapBackIcon: (colorModel) {
                                    if (detail.themeColorModel.color !=
                                        colorModel.color) {
                                      addUpdateParam(
                                          param: ProjectUpdateParam.project);
                                      projectDetailNotifier.changeThemeColor(
                                          colorModel: colorModel);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        // 業種
                        CardLstItem.input(
                          width: secondaryItemWidth,
                          label: t.project.industry,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.industry,
                          inputValue: detail.industry,
                          hintText:
                              t.common.hintWithTitle(title: t.project.industry),
                          onSubmitted: (industry) {
                            if (detail.industry != industry) {
                              addUpdateParam(param: ProjectUpdateParam.project);
                              projectDetailNotifier.changeIndustry(
                                  industry: industry);
                            }
                          },
                        ),
                        // 開発手法
                        CardLstItem.dropDown(
                          width: secondaryItemWidth * 0.8,
                          label: t.project.devMethod,
                          iconData: theme.icons.developers,
                          iconColor: theme.colorPrimary,
                          isShownDefaultItem: false,
                          selectedItemId:
                              detail.devMethodType.typeValue.toString(),
                          itemList: DevMethodType.values
                              .map((item) => LabelModel(
                                  id: item.typeValue.toString(),
                                  labelName: item.name))
                              .toList(),
                          onChange: (devMethodType) {
                            if (detail.devMethodType.typeValue.toString() !=
                                devMethodType) {
                              addUpdateParam(param: ProjectUpdateParam.project);
                              projectDetailNotifier.changeDevMethodType(
                                  typeValue: int.tryParse(devMethodType) ?? 0);
                            }
                          },
                        ),

                        // 開発人数
                        CardLstItem.input(
                          width: secondaryItemWidth,
                          label: t.project.devSize,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.group,
                          inputType: TextInputType.number,
                          inputValue: detail.devSize.toString(),
                          hintText:
                              t.common.hintWithTitle(title: t.project.devSize),
                          onSubmitted: (devSize) {
                            if (detail.devSize.toString() != devSize) {
                              addUpdateParam(param: ProjectUpdateParam.project);
                              projectDetailNotifier.changeDevSize(
                                devSize: int.parse(devSize),
                              );
                            }
                          },
                        ),
                        // 画面数
                        CardLstItem.input(
                          width: secondaryItemWidth,
                          label: t.project.displaySize,
                          iconColor: theme.colorPrimary,
                          iconData: Icons.desktop_mac_outlined,
                          inputType: TextInputType.number,
                          inputValue: detail.displayCount == 0
                              ? ''
                              : detail.displayCount.toString(),
                          hintText: t.common
                              .hintWithTitle(title: t.project.displaySize),
                          onSubmitted: (displayCount) {
                            if (detail.displayCount.toString() !=
                                displayCount) {
                              addUpdateParam(param: ProjectUpdateParam.project);
                              projectDetailNotifier.changeDisplayCount(
                                displayCount: int.tryParse(displayCount) ?? 0,
                              );
                            }
                          },
                        ),
                        // テーブル数
                        CardLstItem.input(
                          width: secondaryItemWidth,
                          label: t.project.tableCount,
                          iconColor: theme.colorPrimary,
                          iconData: Icons.table_rows_outlined,
                          inputType: TextInputType.number,
                          inputValue: detail.tableCount == 0
                              ? ''
                              : detail.tableCount.toString(),
                          hintText: t.common
                              .hintWithTitle(title: t.project.tableCount),
                          onSubmitted: (tableCount) {
                            if (detail.tableCount.toString() != tableCount) {
                              addUpdateParam(param: ProjectUpdateParam.project);
                              projectDetailNotifier.changeTableCount(
                                tableCount: int.tryParse(tableCount) ?? 0,
                              );
                            }
                          },
                        ),
                        // 期間
                        CardLstItem.labeWithIcon(
                          width: secondaryItemWidth,
                          label: t.project.period,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.calender,
                          hintText:
                              t.common.hintWithTitle(title: t.project.period),
                          itemList: [
                            DateRange(
                              startDate: detail.startDate,
                              endDate: detail.endDate,
                            )
                          ],
                          onTap: () async {
                            final now = DateTime.now();
                            DateTimeRange? range = await showDateRangePicker(
                              context: context,
                              initialDateRange: DateTimeRange(
                                start: detail.startDate,
                                end: detail.endDate,
                              ),
                              firstDate: DateTime(1990, 1, 1),
                              lastDate: DateTime(now.year + 5),
                              initialEntryMode: DatePickerEntryMode.input,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: LoomTheme.of(context)
                                          .colorPrimary, // ヘッダー背景色
                                      onPrimary: LoomTheme.of(context)
                                          .colorBgLayer1, // ヘッダーテキストカラー
                                      secondary: LoomTheme.of(context)
                                          .colorPrimary, // カレンダー内の期間背景色
                                      onSurface: LoomTheme.of(context)
                                          .colorFgDefault, // カレンダーのテキストカラー
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (range != null) {
                              addUpdateParam(param: ProjectUpdateParam.project);
                              projectDetailNotifier.changeDueDate(
                                startDate: range.start,
                                endDate: range.end,
                              );
                            }
                          },
                        ),
                        // 業務内容
                        CardLstItem.inputArea(
                          width: fullWidth,
                          label: t.project.workContent,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.description,
                          inputValue: detail.description,
                          hintText: t.common
                              .hintWithTitle(title: t.project.workContent),
                          maxLines: _kContentMaxLines,
                          maxLength: _kContentMaxLength,
                          onSubmitted: (description) {
                            if (detail.description != description) {
                              addUpdateParam(param: ProjectUpdateParam.project);
                              projectDetailNotifier.changeDescription(
                                  description: description);
                            }
                          },
                        ),
                        // 役割
                        CardLstItem.labeWithIcon(
                          width: secondaryItemWidth,
                          label: t.common.role,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.resume,
                          hintText: t.common.roleHint,
                          itemList: [
                            for (final roleType in detail.roleList)
                              LabelTip(
                                label: roleType.typeValue,
                                themeColor: theme.colorFgDisabled,
                              )
                          ],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectLabelDisplay(
                                  title: t.common.role,
                                  labelList: RoleType.values
                                      .map((e) => LabelModel(
                                          id: e.code.toString(),
                                          labelName: e.typeValue))
                                      .toList(),
                                  checkedIdList: detail.roleList
                                      .map((e) => e.code.toString())
                                      .toList(),
                                  onTapBackIcon: (idList) {
                                    if (detail.roleList
                                            .map((e) => e.code.toString())
                                            .toList() !=
                                        idList) {
                                      addUpdateParam(
                                          param: ProjectUpdateParam.role);
                                      projectDetailNotifier.changeRole(
                                        roleList: idList
                                            .map((code) =>
                                                getRoleType(int.parse(code)))
                                            .toList(),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        // OS
                        CardLstItem.labeWithIcon(
                          width: secondaryItemWidth,
                          label: t.common.os,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.resume,
                          hintText: t.common.hintWithTitle(title: t.common.os),
                          itemList: [
                            for (final osId in detail.osIdList)
                              LabelTip(
                                label: osNotifier.getName(osId: osId),
                                themeColor: theme.colorFgDisabled,
                              )
                          ],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectLabelDisplay(
                                  title: t.common.os,
                                  labelList: osList.value ?? [],
                                  checkedIdList: detail.osIdList,
                                  hintText: t.common
                                      .inputWithTitle(title: t.common.os),
                                  emptyText: t.common
                                      .emptyWithTitle(title: t.common.os),
                                  isEditable: true,
                                  onAddLabel: (id, labelName) async {
                                    // OS項目追加
                                    await osNotifier.createOs(
                                      labelModel: LabelModel(
                                          id: id, labelName: labelName),
                                    );
                                    // 更新後のOS一覧をStateにセット
                                    await osNotifier.setOsList();
                                  },
                                  onSubmitEditedText: (id, labelName) async {
                                    // OSの名称変更
                                    await osNotifier.updateOs(
                                      labelModel: LabelModel(
                                          id: id, labelName: labelName),
                                    );
                                    // 更新後のOS一覧をStateにセット
                                    await osNotifier.setOsList();
                                  },
                                  onTapDelete: (id) async {
                                    // OSの項目削除
                                    await osNotifier.deleteOs(osId: id);
                                    // 更新後のOS一覧をStateにセット
                                    await osNotifier.setOsList();
                                  },
                                  onTapBackIcon: (idList) {
                                    if (detail.osIdList != idList) {
                                      addUpdateParam(
                                          param: ProjectUpdateParam.os);
                                      projectDetailNotifier.changeOs(
                                          osIdList: idList);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        // DB
                        CardLstItem.labeWithIcon(
                          width: secondaryItemWidth,
                          label: t.common.db,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.resume,
                          hintText: t.common.hintWithTitle(title: t.common.db),
                          itemList: [
                            for (final dbId in detail.dbIdList)
                              LabelTip(
                                label: dbNotifier.getName(dbId: dbId),
                                themeColor: theme.colorFgDisabled,
                              )
                          ],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectLabelDisplay(
                                  title: t.common.db,
                                  labelList: dbList.value ?? [],
                                  checkedIdList: detail.dbIdList,
                                  hintText: t.common
                                      .inputWithTitle(title: t.common.db),
                                  emptyText: t.common
                                      .emptyWithTitle(title: t.common.db),
                                  isEditable: true,
                                  onAddLabel: (id, labelName) async {
                                    // DB項目追加
                                    await dbNotifier.createDb(
                                      labelModel: LabelModel(
                                          id: id, labelName: labelName),
                                    );
                                    // 更新後のDB一覧をStateにセット
                                    await dbNotifier.setDbList();
                                  },
                                  onSubmitEditedText: (id, labelName) async {
                                    // DBの名称変更
                                    await dbNotifier.updateDb(
                                      labelModel: LabelModel(
                                          id: id, labelName: labelName),
                                    );
                                    // 更新後のDB一覧をStateにセット
                                    await dbNotifier.setDbList();
                                  },
                                  onTapDelete: (id) async {
                                    // DBの項目削除
                                    await dbNotifier.deleteDb(dbId: id);
                                    // 更新後のDB一覧をStateにセット
                                    await dbNotifier.setDbList();
                                  },
                                  onTapBackIcon: (idList) {
                                    if (detail.dbIdList != idList) {
                                      addUpdateParam(
                                          param: ProjectUpdateParam.db);
                                      projectDetailNotifier.changeDb(
                                          dbIdList: idList);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        // 開発言語
                        CardLstItem.labeWithIcon(
                          width: secondaryItemWidth,
                          label: t.common.devLang,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.developers,
                          hintText: t.common.devLangHint,
                          itemList: [
                            for (final item in detail.devLanguageList)
                              LabelTip(
                                label: item.labelName,
                                themeColor: theme.colorFgDisabled,
                              )
                          ],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return DrumrollWithContentDisplay(
                                  title: t.common.devLang,
                                  hintText: t.common.devLangVersionHint,
                                  selectedListEmptyText: t.common
                                      .emptyWithTitle(title: t.common.devLang),
                                  labeList: devLangList.value ?? [],
                                  selectedList: detail.devLanguageList,
                                  onTapBack: (data) {
                                    if (detail.devLanguageList != data) {
                                      addUpdateParam(
                                          param: ProjectUpdateParam.devLangRel);
                                      projectDetailNotifier
                                          .changeDevLanguageList(
                                              devLanguageList: (data));
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        // Git
                        CardLstItem.labeWithIcon(
                          width: secondaryItemWidth,
                          label: t.common.git,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.tool,
                          hintText: t.common.hintWithTitle(title: t.common.git),
                          itemList: [
                            for (final gitId in detail.gitIdList)
                              LabelTip(
                                label: gitNotifier.getName(gitId: gitId),
                                themeColor: theme.colorFgDisabled,
                              )
                          ],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectLabelDisplay(
                                  title: t.common.git,
                                  labelList: gitList.value ?? [],
                                  checkedIdList: detail.gitIdList,
                                  hintText: t.common
                                      .inputWithTitle(title: t.common.git),
                                  emptyText: t.common
                                      .emptyWithTitle(title: t.common.git),
                                  isEditable: true,
                                  onAddLabel: (id, labelName) async {
                                    // Git項目追加
                                    await gitNotifier.createGit(
                                      labelModel: LabelModel(
                                          id: id, labelName: labelName),
                                    );
                                    // 更新後のGit一覧をStateにセット
                                    await gitNotifier.setGitList();
                                  },
                                  onSubmitEditedText: (id, labelName) async {
                                    // Gitの名称変更
                                    await gitNotifier.updateGit(
                                      labelModel: LabelModel(
                                          id: id, labelName: labelName),
                                    );
                                    // 更新後のGit一覧をStateにセット
                                    await gitNotifier.setGitList();
                                  },
                                  onTapDelete: (id) async {
                                    // Gitの項目削除
                                    await gitNotifier.deleteGit(gitId: id);
                                    // 更新後のGit一覧をStateにセット
                                    await gitNotifier.setGitList();
                                  },
                                  onTapBackIcon: (idList) {
                                    if (detail.gitIdList != idList) {
                                      addUpdateParam(
                                          param: ProjectUpdateParam.git);
                                      projectDetailNotifier.changeGitList(
                                          gitIdList: idList);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        // ミドルウェア
                        CardLstItem.labeWithIcon(
                          width: secondaryItemWidth,
                          label: t.common.mw,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.tool,
                          hintText: t.common.hintWithTitle(title: t.common.mw),
                          itemList: [
                            for (final mwId in detail.mwIdList)
                              LabelTip(
                                label: mwNotifier.getName(mwId: mwId),
                                themeColor: theme.colorFgDisabled,
                              )
                          ],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectLabelDisplay(
                                  title: t.common.mw,
                                  labelList: mwList.value ?? [],
                                  checkedIdList: detail.mwIdList,
                                  hintText: t.common
                                      .inputWithTitle(title: t.common.mw),
                                  emptyText: t.common
                                      .emptyWithTitle(title: t.common.mw),
                                  isEditable: true,
                                  onAddLabel: (id, labelName) async {
                                    // ミドルウェア項目追加
                                    await mwNotifier.createMw(
                                      labelModel: LabelModel(
                                          id: id, labelName: labelName),
                                    );
                                    // 更新後のミドルウェア一覧をStateにセット
                                    await mwNotifier.setMwList();
                                  },
                                  onSubmitEditedText: (id, labelName) async {
                                    // ミドルウェアの名称変更
                                    await mwNotifier.updateMw(
                                      labelModel: LabelModel(
                                          id: id, labelName: labelName),
                                    );
                                    // 更新後のミドルウェア一覧をStateにセット
                                    await mwNotifier.setMwList();
                                  },
                                  onTapDelete: (id) async {
                                    // ミドルウェアの項目削除
                                    await mwNotifier.deleteMw(mwId: id);
                                    // 更新後のミドルウェア一覧をStateにセット
                                    await mwNotifier.setMwList();
                                  },
                                  onTapBackIcon: (idList) {
                                    if (detail.mwIdList != idList) {
                                      addUpdateParam(
                                          param: ProjectUpdateParam.mw);
                                      projectDetailNotifier.changeMwList(
                                          mwIdList: idList);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        // 開発ツール
                        CardLstItem.labeWithIcon(
                          width: secondaryItemWidth,
                          label: t.common.tool,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.tool,
                          hintText: t.common.toolHint,
                          itemList: [
                            for (final toolId in detail.toolIdList)
                              LabelTip(
                                label: toolNotifier.getName(toolId: toolId),
                                themeColor: theme.colorFgDisabled,
                              )
                          ],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectLabelDisplay(
                                  title: t.common.tool,
                                  labelList: toolList.value ?? [],
                                  checkedIdList: detail.toolIdList,
                                  hintText: t.common
                                      .inputWithTitle(title: t.common.tool),
                                  emptyText: t.common
                                      .emptyWithTitle(title: t.common.tool),
                                  isEditable: true,
                                  onAddLabel: (id, labelName) async {
                                    // Tool項目追加
                                    await toolNotifier.createTool(
                                      labelModel: LabelModel(
                                          id: id, labelName: labelName),
                                    );
                                    // 更新後のTool一覧をStateにセット
                                    await toolNotifier.setToolList();
                                  },
                                  onSubmitEditedText: (id, labelName) async {
                                    // Toolの名称変更
                                    await toolNotifier.updateTool(
                                      labelModel: LabelModel(
                                          id: id, labelName: labelName),
                                    );
                                    // 更新後のTool一覧をStateにセット
                                    await toolNotifier.setToolList();
                                  },
                                  onTapDelete: (id) async {
                                    // Toolの項目削除
                                    await toolNotifier.deleteTool(toolId: id);
                                    // 更新後のTool一覧をStateにセット
                                    await toolNotifier.setToolList();
                                  },
                                  onTapBackIcon: (idList) {
                                    if (detail.toolIdList != idList) {
                                      addUpdateParam(
                                          param: ProjectUpdateParam.tool);
                                      projectDetailNotifier.changeToolList(
                                          toolIdList: idList);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        // 作業工程
                        CardLstItem.labeWithIcon(
                          width: secondaryItemWidth,
                          label: t.common.workProgress,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.resume,
                          hintText: t.common
                              .hintWithTitle(title: t.common.workProgress),
                          itemList: [
                            for (final devProgressId
                                in detail.devProgressIdList)
                              LabelTip(
                                label: devProgressNotifier.getName(
                                    devProgressId: devProgressId),
                                themeColor: theme.colorFgDisabled,
                              )
                          ],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectLabelDisplay(
                                  title: t.common.workProgress,
                                  labelList: devProgressList.value!,
                                  checkedIdList: detail.devProgressIdList,
                                  onTapBackIcon: (idList) {
                                    if (detail.devProgressIdList != idList) {
                                      addUpdateParam(
                                          param:
                                              ProjectUpdateParam.devProgress);
                                      projectDetailNotifier
                                          .changeDevProgressList(
                                        devProgressIdList: idList,
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: _kProjectAndBoardSpace,
                        ),
                        CardLstItem.header(
                          title: t.board.name,
                          bgColor: theme.colorBgLayer1,
                        ),
                        // ラベル
                        CardLstItem.labeWithIcon(
                          width: fullWidth,
                          label: t.common.label,
                          iconColor: theme.colorPrimary,
                          iconData: Icons.label,
                          hintText:
                              t.common.hintWithTitle(title: t.common.label),
                          rowType: RowType.double,
                          itemList: [
                            for (final item in detail.tagList)
                              LabelTip(
                                label: item.labelName,
                                themeColor: item.colorModel.color,
                              )
                          ],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return TagDisplay(
                                  title: t.common.label,
                                  tagList: detail.tagList,
                                  onTapBack: (data) {
                                    if (detail.tagList != data) {
                                      addUpdateParam(
                                          param: ProjectUpdateParam.tag);
                                      projectDetailNotifier.changeTagList(
                                        tagList:
                                            (data as List<ColorLabelModel>),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: _kProjectAndBoardSpace,
                        ),
                      ],
                    ),
                  ),
                );
        },
        loading: () => Align(
          child: CircularProgressIndicator(
            color: theme.colorPrimary,
          ),
        ),
        error: (error, _) => Align(child: Text(error.toString())),
      ),
    );
  }

  void addUpdateParam({required ProjectUpdateParam param}) {
    if (!updateParamList.contains(param)) {
      setState(() {
        updateParamList.add(param);
      });
    }
  }
}
