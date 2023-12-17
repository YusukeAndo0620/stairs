import 'package:stairs/feature/project/component/provider/dev_lang_provider.dart';
import 'package:stairs/feature/project/provider/project_detail_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kProjectTitleTxt = 'プロジェクト';
const _kProjectHintTxt = 'プロジェクト名';
const _kColorTxt = '色';
const _kColorHintTxt = 'メインテーマを設定';
const _kIndustryHintTxt = '業種';
const _kDueTxt = '期間';
const _kDueHintTxt = '期間を設定';
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
const _kDevLangVersionHintTxt = 'バージョンなどを入力してください。表示例：Java(Java8)';

const _kToolTxt = '開発ツール';
const _kToolHintTxt = '使用したツールを設定（Backlog, Miro, Figmaなど）';
const _kToolInputHintTxt = 'ツール名を入力';
const _kToolListEmptyTxt = '開発ツールが登録されていません。\n開発ツールを追加してください';

const _kProgressTxt = '作業工程';
const _kProgressHintTxt = '携わった作業工程を設定';
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
    final projectDetailState =
        ref.watch(projectDetailProvider(projectId: projectId));
    //開発言語一覧
    final devLangState = ref.watch(devLangProvider);

    return Modal(
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
                    // プロジェクト名,
                    CardLstItem.input(
                        icon: Icon(
                          Icons.assessment,
                          color: theme.colorPrimary,
                        ),
                        inputValue: detail.projectName,
                        hintText: _kProjectHintTxt,
                        onSubmitted: (projectName) {
                          final notifier = ref.read(
                              projectDetailProvider(projectId: projectId)
                                  .notifier);
                          notifier.changeProjectName(projectName: projectName);
                        }),
                    // 色,
                    CardLstItem.labeWithIcon(
                      label: _kColorTxt,
                      iconColor: theme.colorPrimary,
                      iconData: Icons.palette,
                      hintText: _kColorHintTxt,
                      itemList: [
                        ColorBox(
                          color: detail.themeColor,
                        ),
                      ],
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SelectColorDisplay(
                              title: _kColorTxt,
                              selectedColorInfo: detail.themeColor,
                              onTap: (id) {},
                              onTapBackIcon: (colorInfo) {
                                final notifier = ref.read(
                                    projectDetailProvider(projectId: projectId)
                                        .notifier);
                                notifier.changeThemeColor(colorInfo: colorInfo);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    // 業種
                    CardLstItem.input(
                        icon: Icon(
                          theme.icons.trash,
                          color: theme.colorPrimary,
                        ),
                        inputValue: detail.industry,
                        hintText: _kIndustryHintTxt,
                        onSubmitted: (industry) {
                          final notifier = ref.read(
                              projectDetailProvider(projectId: projectId)
                                  .notifier);
                          notifier.changeIndustry(industry: industry);
                        }),
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
                          final notifier = ref.read(
                              projectDetailProvider(projectId: projectId)
                                  .notifier);
                          notifier.changeDueDate(
                            startDate: range.start,
                            endDate: range.end,
                          );
                        }
                      },
                    ),
                    // 業務内容
                    CardLstItem.input(
                      icon: Icon(
                        theme.icons.trash,
                        color: theme.colorPrimary,
                      ),
                      inputValue: detail.description,
                      hintText: _kContentHintTxt,
                      maxLength: _kContentMaxLength,
                      onSubmitted: (description) {
                        final notifier = ref.read(
                            projectDetailProvider(projectId: projectId)
                                .notifier);
                        notifier.changeDescription(description: description);
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
                                final notifier = ref.read(
                                    projectDetailProvider(projectId: projectId)
                                        .notifier);
                                notifier.changeOs(
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
                                final notifier = ref.read(
                                    projectDetailProvider(projectId: projectId)
                                        .notifier);
                                notifier.changeDb(
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
                                final notifier = ref.read(
                                    projectDetailProvider(projectId: projectId)
                                        .notifier);
                                notifier.changeDevLanguageList(
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
                                final notifier = ref.read(
                                    projectDetailProvider(projectId: projectId)
                                        .notifier);
                                notifier.changeToolList(
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
                                final notifier = ref.read(
                                    projectDetailProvider(projectId: projectId)
                                        .notifier);
                                notifier.changeDevProgressList(
                                  devProgressList: labelList,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    // 開発人数
                    CardLstItem.input(
                      inputType: TextInputType.number,
                      inputValue: detail.devSize.toString(),
                      icon: Icon(
                        Icons.group,
                        color: theme.colorPrimary,
                      ),
                      hintText: _kDevSizeHintTxt,
                      onSubmitted: (devSize) {
                        final notifier = ref.read(
                            projectDetailProvider(projectId: projectId)
                                .notifier);
                        notifier.changeDevSize(
                          devSize: int.parse(devSize),
                        );
                      },
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
                            themeColor: item.color,
                          )
                      ],
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return TagDisplay(
                              title: _kLabelTxt,
                              tagList: detail.tagList,
                              onTapBack: (data) {
                                final notifier = ref.read(
                                    projectDetailProvider(projectId: projectId)
                                        .notifier);
                                notifier.changeTagList(
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