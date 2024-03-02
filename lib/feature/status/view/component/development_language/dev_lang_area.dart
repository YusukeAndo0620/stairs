import 'package:stairs/feature/status/model/label_status_model.dart';
import 'package:stairs/feature/status/model/project_status_model.dart';
import 'package:stairs/feature/status/view/component/development_language/dev_lang_table.dart';
import 'package:stairs/feature/status/view/component/status_header.dart';

import 'package:stairs/loom/loom_package.dart';

const _kHeaderTitle = "開発言語";
const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);

final _logger = stairsLogger(name: 'dev_lang_area');

/// 開発言語ステータス表示エリア
class DevLangArea extends StatelessWidget {
  const DevLangArea({
    super.key,
    required this.projectStatusModel,
  });

  final ProjectStatusModel projectStatusModel;

  @override
  Widget build(BuildContext context) {
    _logger.d('===================================');
    _logger.d('ビルド開始');

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: _kContentPadding,
      child: Column(
        children: [
          const StatusHeader(
            title: _kHeaderTitle,
            isShownDate: false,
          ),
          for (final devLangEntry in projectStatusModel.devLangMap.entries) ...[
            DevLangTable(
              devLangName: devLangEntry.value,
              totalTaskCount: projectStatusModel.taskStatusList.length,
              taskCount: projectStatusModel
                  .getTaskIdListWithDevLangId(devLangId: devLangEntry.key)
                  .length,
              labelStatusList: _getLabelListWithDevLangId(
                  taskIdListWithDevLanguage: projectStatusModel
                      .getTaskIdListWithDevLangId(devLangId: devLangEntry.key),
                  labelStatusList: projectStatusModel.labelStatusList),
            ),
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
