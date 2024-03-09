import 'package:stairs/feature/status/enum/label_table_type.dart';
import 'package:stairs/feature/status/model/label_status_model.dart';
import 'package:stairs/feature/status/model/project_status_model.dart';
import 'package:stairs/feature/status/view/component/label_status/label_table_area.dart';
import 'package:stairs/feature/status/view/component/status_header.dart';

import 'package:stairs/loom/loom_package.dart';

const _kSelectTypeBarHeight = 30.0;
const _kSelectTypeBarWidth = 45.0;

const _kHeaderTitle = "ラベル";

const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);
const _kSelectTypeBarPadding =
    EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0);

final _logger = stairsLogger(name: 'label_status_area');

/// ラベル一覧表示エリア
class LabelStatusArea extends StatefulWidget {
  const LabelStatusArea({
    super.key,
    required this.projectStatusModel,
  });

  final ProjectStatusModel projectStatusModel;

  @override
  State<StatefulWidget> createState() => _LabelStatusAreaState();
}

class _LabelStatusAreaState extends State<LabelStatusArea> {
  // 表示種別
  LabelTableType selectedDisplayType = LabelTableType.task;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _logger.d('===================================');
    _logger.d('ビルド開始');

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: _kContentPadding,
      child: Column(
        children: [
          StatusHeader(
            title: _kHeaderTitle,
            isShownDate: false,
            trailWidget: _SelectTypeBar(
              selectedType: selectedDisplayType,
              onTap: (type) {
                setState(
                  () {
                    selectedDisplayType = type;
                  },
                );
              },
            ),
          ),
          // 全タスクのラベル
          if (selectedDisplayType == LabelTableType.task) ...[
            LabelTableArea(
              title: selectedDisplayType.typeValue,
              totalLabelTaskCount:
                  widget.projectStatusModel.totalLabelTaskCount,
              labelStatusList: widget.projectStatusModel.labelStatusList,
            ),
            // 開発言語のラベル
          ] else ...[
            // 開発言語がない場合、タイトル名を変更しリストを空にして一覧表示
            if (widget.projectStatusModel.devLangMap.isEmpty) ...[
              LabelTableArea(
                title: selectedDisplayType.typeValue,
                totalLabelTaskCount: 0,
                labelStatusList: const [],
              ),
            ] else ...[
              for (final devLangEntry
                  in widget.projectStatusModel.devLangMap.entries) ...[
                LabelTableArea(
                  title: devLangEntry.value,
                  totalTaskCount:
                      widget.projectStatusModel.taskStatusList.length,
                  taskCount: widget.projectStatusModel
                      .getTaskIdListWithDevLangId(devLangId: devLangEntry.key)
                      .length,
                  totalLabelTaskCount: _getLabelListWithDevLangId(
                          taskIdListWithDevLanguage: widget.projectStatusModel
                              .getTaskIdListWithDevLangId(
                                  devLangId: devLangEntry.key),
                          labelStatusList:
                              widget.projectStatusModel.labelStatusList)
                      .map((item) => item.taskIdList)
                      .toList()
                      .length,
                  labelStatusList: _getLabelListWithDevLangId(
                      taskIdListWithDevLanguage: widget.projectStatusModel
                          .getTaskIdListWithDevLangId(
                              devLangId: devLangEntry.key),
                      labelStatusList:
                          widget.projectStatusModel.labelStatusList),
                ),
              ]
            ],
          ]
        ],
      ),
    );
  }

  // 開発言語が設定されているタスクに紐づくラベルのリストを作成し取得
  List<LabelStatusModel> _getLabelListWithDevLangId({
    required List<String> taskIdListWithDevLanguage,
    required List<LabelStatusModel> labelStatusList,
  }) {
    List<LabelStatusModel> targetList = [];
    for (final item in labelStatusList) {
      final labelStatus = item.copyWith(
          taskIdList: item.taskIdList
              .map((taskId) =>
                  taskIdListWithDevLanguage.contains(taskId) ? taskId : null)
              .whereType<String>()
              .toList());
      if (labelStatus.taskIdList.isNotEmpty) {
        targetList.add(labelStatus);
      }
    }
    return targetList;
  }
}

// 表示タイプ選択エリア
class _SelectTypeBar extends StatelessWidget {
  const _SelectTypeBar({
    required this.selectedType,
    required this.onTap,
  });

  final LabelTableType selectedType;
  final Function(LabelTableType) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return ToggleButtons(
      constraints: const BoxConstraints(
          maxHeight: _kSelectTypeBarHeight, minWidth: _kSelectTypeBarWidth),
      borderRadius: BorderRadius.circular(5.0),
      fillColor: theme.colorPrimary,
      isSelected:
          LabelTableType.values.map((type) => type == selectedType).toList(),
      onPressed: (index) => onTap(LabelTableType.values[index]),
      children: [
        for (final item in LabelTableType.values) ...[
          Padding(
            padding: _kSelectTypeBarPadding,
            child: Text(
              item.typeValue,
              style: theme.textStyleFootnote.copyWith(
                color: item == selectedType
                    ? theme.colorBgLayer1
                    : theme.colorFgDefault,
              ),
            ),
          )
        ]
      ],
    );
  }
}
