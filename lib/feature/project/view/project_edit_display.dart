import 'package:stairs/feature/common/provider/db_provider.dart';
import 'package:stairs/feature/common/provider/os_provider.dart';
import 'package:stairs/feature/project/provider/component/dev_lang_provider.dart';
import 'package:stairs/feature/project/enum/project_update_param.dart';
import 'package:stairs/feature/project/provider/project_detail_provider.dart';
import 'package:stairs/feature/project/provider/project_list_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kProjectTitleTxt = 'プロジェクト';
const _kProjectNameTitleTxt = 'プロジェクト名';
const _kProjectHintTxt = 'プロジェクト名';

const _kColorTxt = '色';
const _kColorHintTxt = 'メインテーマを設定';

const _kIndustryTxt = '業種';
const _kIndustryHintTxt = '業種';

const _kDevMethodTxt = '開発手法';

const _kDueTxt = '期間';
const _kDueHintTxt = '期間を設定';

const _kContentTxt = '業務内容';
const _kContentHintTxt = '業務内容';
const _kContentMaxLength = 500;
const _kContentMaxLines = 8;

const _kDevSizeTxt = '開発人数';
const _kDevSizeHintTxt = '開発人数を設定';

const _kDisplayCountTxt = '画面数';
const _kDisplayCountHintTxt = '画面数を設定';

const _kTableCountTxt = 'テーブル数';
const _kTableCountHintTxt = 'テーブル数を設定';

const _kOsTxt = 'OS';
const _kOsHintTxt = '使用OS・機種';
const _kOsInputHintTxt = 'OSを入力';
const _kOsListEmptyTxt = 'OSが登録されていません。\nOSを追加してください';

const _kDbTxt = 'DB';
const _kDbHintTxt = '使用DB';
const _kDbInputHintTxt = 'DBを入力';
const _kDbListEmptyTxt = 'DBが登録されていません。\nDBを追加してください';

const _kDevLangTxt = '開発言語';
const _kDevLangHintTxt = '開発言語、フレームワークを設定';
const _kDevLangListEmptyTxt = '言語が登録されていません。\n言語を登録してください。';
const _kDevLangVersionHintTxt = 'バージョンなどを入力してください。表示例: Java(Java8)';

const _kToolTxt = '開発ツール';
const _kToolHintTxt = 'ツールを設定（Backlog, Figmaなど）';
const _kToolInputHintTxt = 'ツール名を入力';
const _kToolListEmptyTxt = '開発ツールが登録されていません。\n開発ツールを追加してください';

const _kProgressTxt = '作業工程';
const _kProgressHintTxt = '携わった作業工程を設定';

const _kBoardTitleTxt = 'ボード';
const _kLabelTxt = 'ラベル';
const _kLabelHintTxt = 'ラベルを設定';

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
    //プロジェクト詳細
    final projectDetailState =
        ref.watch(projectDetailProvider(projectId: widget.projectId));

    //プロジェクト詳細 Notifier
    final projectDetailNotifier =
        ref.watch(projectDetailProvider(projectId: widget.projectId).notifier);

    //プロジェクト一覧 Notifier
    final projectListNotifier = ref.watch(projectListProvider.notifier);

    //開発言語一覧
    final devLangList = ref.watch(devLangProvider);

    // OS一覧
    final osList = ref.watch(osProvider);
    final osNotifier = ref.watch(osProvider.notifier);

    // DB一覧
    final dbList = ref.watch(dbProvider);
    final dbNotifier = ref.watch(dbProvider.notifier);
    //開発工程一覧
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
          final secondaryItemWidth = MediaQuery.of(context).size.width * 0.52;
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
                          title: _kProjectTitleTxt,
                          bgColor: theme.colorBgLayer1,
                        ),
                        // プロジェクト名
                        CardLstItem.input(
                            width: secondaryItemWidth,
                            label: _kProjectNameTitleTxt,
                            iconColor: theme.colorPrimary,
                            iconData: theme.icons.project,
                            inputValue: detail.projectName,
                            hintText: _kProjectHintTxt,
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
                          label: _kColorTxt,
                          iconData: Icons.palette,
                          iconColor: theme.colorPrimary,
                          hintText: _kColorHintTxt,
                          itemList: [
                            ColorBox(
                              color: detail.themeColorModel.color,
                            ),
                          ],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectColorDisplay(
                                  title: _kColorTxt,
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
                          label: _kIndustryTxt,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.industry,
                          inputValue: detail.industry,
                          hintText: _kIndustryHintTxt,
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
                          label: _kDevMethodTxt,
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
                          label: _kDevSizeTxt,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.group,
                          inputType: TextInputType.number,
                          inputValue: detail.devSize.toString(),
                          hintText: _kDevSizeHintTxt,
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
                          label: _kDisplayCountTxt,
                          iconColor: theme.colorPrimary,
                          iconData: Icons.desktop_mac_outlined,
                          inputType: TextInputType.number,
                          inputValue: detail.displayCount == 0
                              ? ''
                              : detail.displayCount.toString(),
                          hintText: _kDisplayCountHintTxt,
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
                          label: _kTableCountTxt,
                          iconColor: theme.colorPrimary,
                          iconData: Icons.table_rows_outlined,
                          inputType: TextInputType.number,
                          inputValue: detail.tableCount == 0
                              ? ''
                              : detail.tableCount.toString(),
                          hintText: _kTableCountHintTxt,
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
                          label: _kDueTxt,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.calender,
                          hintText: _kDueHintTxt,
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
                        CardLstItem.input(
                          width: secondaryItemWidth,
                          label: _kContentTxt,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.description,
                          inputValue: detail.description,
                          hintText: _kContentHintTxt,
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
                        // OS
                        CardLstItem.labeWithIcon(
                          width: secondaryItemWidth,
                          label: _kOsTxt,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.resume,
                          hintText: _kOsHintTxt,
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
                                  title: _kOsTxt,
                                  labelList: osList.value ?? [],
                                  checkedIdList: detail.osIdList,
                                  hintText: _kOsInputHintTxt,
                                  emptyText: _kOsListEmptyTxt,
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
                          label: _kDbTxt,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.resume,
                          hintText: _kDbHintTxt,
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
                                  title: _kDbTxt,
                                  labelList: dbList.value ?? [],
                                  checkedIdList: detail.dbIdList,
                                  hintText: _kDbInputHintTxt,
                                  emptyText: _kDbListEmptyTxt,
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
                          label: _kDevLangTxt,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.developers,
                          hintText: _kDevLangHintTxt,
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
                                  title: _kDevLangTxt,
                                  hintText: _kDevLangVersionHintTxt,
                                  selectedListEmptyText: _kDevLangListEmptyTxt,
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
                        // 開発ツール
                        CardLstItem.labeWithIcon(
                          width: secondaryItemWidth,
                          label: _kToolTxt,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.tool,
                          hintText: _kToolHintTxt,
                          itemList: [
                            for (final item in detail.toolList)
                              LabelTip(
                                label: item.labelName,
                                themeColor: theme.colorFgDisabled,
                              )
                          ],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return LabelInputDisplay(
                                  title: _kToolTxt,
                                  labelList: detail.toolList,
                                  hintText: _kToolInputHintTxt,
                                  emptyText: _kToolListEmptyTxt,
                                  onTapBack: (data) {
                                    if (detail.toolList != data) {
                                      addUpdateParam(
                                          param: ProjectUpdateParam.tool);
                                      projectDetailNotifier.changeToolList(
                                          toolList: (data as List<LabelModel>));
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
                          label: _kProgressTxt,
                          iconColor: theme.colorPrimary,
                          iconData: theme.icons.resume,
                          hintText: _kProgressHintTxt,
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
                                  title: _kProgressTxt,
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
                          title: _kBoardTitleTxt,
                          bgColor: theme.colorBgLayer1,
                        ),
                        // ラベル
                        CardLstItem.labeWithIcon(
                          width: secondaryItemWidth,
                          label: _kLabelTxt,
                          iconColor: theme.colorPrimary,
                          iconData: Icons.label,
                          hintText: _kLabelHintTxt,
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
                                  title: _kLabelTxt,
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
