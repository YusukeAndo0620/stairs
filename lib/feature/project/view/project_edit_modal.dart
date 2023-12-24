import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/project/component/provider/dev_lang_provider.dart';
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

const _kDueTxt = '期間';
const _kDueHintTxt = '期間を設定';

const _kContentTxt = '業務内容';
const _kContentHintTxt = '業務内容';
const _kContentMaxLength = 500;

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

const _kDevSizeTxt = '開発人数';
const _kDevSizeHintTxt = '開発人数を設定';

const _kBoardTitleTxt = 'ボード';
const _kLabelTxt = 'ラベル';
const _kLabelHintTxt = 'ラベルを設定';

const _kProjectAndBoardSpace = 30.0;

class ProjectEditModal extends ConsumerWidget {
  const ProjectEditModal({
    super.key,
    required this.projectId,
  });

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);
    //プロジェクト詳細
    final projectDetailState = ref.watch(projectDetailProvider(
        projectId: projectId, database: ref.watch(databaseProvider)));

    //プロジェクト詳細 Notifier
    final projectDetailNotifier = ref.watch(projectDetailProvider(
            projectId: projectId, database: ref.watch(databaseProvider))
        .notifier);

    //プロジェクト一覧 Notifier
    final projectListNotifier = ref.watch(
        projectListProvider(database: ref.watch(databaseProvider)).notifier);

    //開発言語一覧
    final devLangState =
        ref.watch(devLangProvider(db: ref.watch(databaseProvider)));

    return Modal(
      onClose: () {
        projectDetailNotifier.updateDetail();
        projectListNotifier.setProjectList(
            database: ref.watch(databaseProvider));
      },
      buildMainContent: projectDetailState.when(
        data: (detail) {
          return detail == null
              ? const SizedBox.shrink()
              : Column(
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
                        label: _kProjectNameTitleTxt,
                        iconColor: theme.colorPrimary,
                        iconData: Icons.assessment,
                        inputValue: detail.projectName,
                        hintText: _kProjectHintTxt,
                        onSubmitted: (projectName) {
                          projectDetailNotifier.changeProjectName(
                              projectName: projectName);
                        }),
                    // 色
                    CardLstItem.labeWithIcon(
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
                              selectedColorInfo: detail.themeColorModel.color,
                              onTap: (id) {},
                              onTapBackIcon: (colorModel) {
                                projectDetailNotifier.changeThemeColor(
                                    colorModel: colorModel);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    // 業種
                    CardLstItem.input(
                      label: _kIndustryTxt,
                      iconColor: theme.colorPrimary,
                      iconData: theme.icons.trash,
                      inputValue: detail.industry,
                      hintText: _kIndustryHintTxt,
                      onSubmitted: (industry) {
                        projectDetailNotifier.changeIndustry(
                            industry: industry);
                      },
                    ),
                    // 開発人数
                    CardLstItem.input(
                      label: _kDevSizeTxt,
                      iconColor: theme.colorPrimary,
                      iconData: Icons.group,
                      inputType: TextInputType.number,
                      inputValue: detail.devSize.toString(),
                      hintText: _kDevSizeHintTxt,
                      onSubmitted: (devSize) {
                        projectDetailNotifier.changeDevSize(
                          devSize: int.parse(devSize),
                        );
                      },
                    ),
                    // 期日
                    CardLstItem.labeWithIcon(
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
                        DateTimeRange? range = await showDateRangePicker(
                          context: context,
                          initialDateRange: DateTimeRange(
                            start: detail.startDate,
                            end: detail.endDate,
                          ),
                          firstDate: DateTime(1990, 1, 1),
                          lastDate: DateTime.now(),
                          initialEntryMode: DatePickerEntryMode.input,
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: LoomTheme.of(context)
                                      .colorPrimary, // ヘッダー背景色
                                  onPrimary: LoomTheme.of(context)
                                      .colorBgLayer1, // ヘッダーテキストカラー
                                  onSurface: LoomTheme.of(context)
                                      .colorFgDefault, // カレンダーのテキストカラー
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (range != null) {
                          projectDetailNotifier.changeDueDate(
                            startDate: range.start,
                            endDate: range.end,
                          );
                        }
                      },
                    ),
                    // 業務内容
                    CardLstItem.input(
                      label: _kContentTxt,
                      iconColor: theme.colorPrimary,
                      iconData: theme.icons.trash,
                      inputValue: detail.description,
                      hintText: _kContentHintTxt,
                      maxLength: _kContentMaxLength,
                      onSubmitted: (description) {
                        projectDetailNotifier.changeDescription(
                            description: description);
                      },
                    ),
                    // OS,
                    CardLstItem.labeWithIcon(
                      label: _kOsTxt,
                      iconColor: theme.colorPrimary,
                      iconData: theme.icons.resume,
                      hintText: _kOsHintTxt,
                      itemList: [
                        for (final item in detail.osList)
                          LabelTip(
                            label: item.labelName,
                            themeColor: theme.colorFgDisabled,
                          )
                      ],
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return LabelInputDisplay(
                              title: _kOsTxt,
                              labelList: detail.osList,
                              hintText: _kOsInputHintTxt,
                              emptyText: _kOsListEmptyTxt,
                              onTapBack: (data) {
                                projectDetailNotifier.changeOs(
                                    osList: (data as List<LabelModel>));
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    // DB
                    CardLstItem.labeWithIcon(
                      label: _kDbTxt,
                      iconColor: theme.colorPrimary,
                      iconData: theme.icons.resume,
                      hintText: _kDbHintTxt,
                      itemList: [
                        for (final item in detail.dbList)
                          LabelTip(
                            label: item.labelName,
                            themeColor: theme.colorFgDisabled,
                          )
                      ],
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return LabelInputDisplay(
                              title: _kDbTxt,
                              labelList: detail.dbList,
                              hintText: _kDbInputHintTxt,
                              emptyText: _kDbListEmptyTxt,
                              onTapBack: (data) {
                                projectDetailNotifier.changeDb(
                                    dbList: (data as List<LabelModel>));
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    // 開発言語
                    CardLstItem.labeWithIcon(
                      label: _kDevLangTxt,
                      iconColor: theme.colorPrimary,
                      iconData: theme.icons.resume,
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
                              labeList: devLangState.value ?? [],
                              selectedList: detail.devLanguageList,
                              onTapBack: (data) {
                                projectDetailNotifier.changeDevLanguageList(
                                    devLanguageList: (data));
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    // 開発ツール,
                    CardLstItem.labeWithIcon(
                      label: _kToolTxt,
                      iconColor: theme.colorPrimary,
                      iconData: theme.icons.resume,
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
                                projectDetailNotifier.changeToolList(
                                    toolList: (data as List<LabelModel>));
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    // 作業工程
                    CardLstItem.labeWithIcon(
                      label: _kProgressTxt,
                      iconColor: theme.colorPrimary,
                      iconData: theme.icons.resume,
                      hintText: _kProgressHintTxt,
                      itemList: [
                        for (final item in detail.devProgressList)
                          LabelTip(
                            label: item.labelName,
                            themeColor: theme.colorFgDisabled,
                          )
                      ],
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SelectLabelDisplay(
                              title: _kProgressTxt,
                              labelList: const [],
                              selectedLabelList: detail.devProgressList,
                              onTap: (id) {},
                              onTapBackIcon: (labelList) {
                                projectDetailNotifier.changeDevProgressList(
                                  devProgressList: labelList,
                                );
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
                    // ラベル,
                    CardLstItem.labeWithIcon(
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
                                projectDetailNotifier.changeTagList(
                                  tagList: (data as List<ColorLabelModel>),
                                );
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
                );
        },
        loading: () => const Align(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Align(child: Text(error.toString())),
      ),
    );
  }
}
