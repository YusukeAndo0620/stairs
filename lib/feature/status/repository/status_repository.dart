import 'package:stairs/db/database.dart';
import 'package:stairs/feature/status/model/label_status_model.dart';
import 'package:stairs/feature/status/model/project_status_model.dart';
import 'package:stairs/feature/status/model/task_status_model.dart';
import 'package:stairs/loom/loom_package.dart' hide Row;

class StatusRepository {
  StatusRepository({required this.db});

  final StairsDatabase db;

  final _logger = stairsLogger(name: 'status_repository');

  /// ステータス一覧取得
  Future<List<ProjectStatusModel>> getStatusList(
      {required String accountId}) async {
    try {
      _logger.i('getStatusList 開始');
      final projectResponse =
          await db.tProjectDao.getProjectList(accountId: accountId);
      _logger.i('取得データ length: ${projectResponse.length}');

      List<ProjectStatusModel> projectStatusList = [];

      for (final projectRow in projectResponse) {
        // プロジェクト単位でタスクに紐づくタグを全て取得
        // {task_tag}, {board}, {task}, {tag_rel}, {tag}, {color}
        final tagResponse = await db.tTaskTagDao.getTaskTagListByProjectId(
            projectId: projectRow.readTable(db.tProject).projectId);
        // プロジェクト単位でタスクに紐づく開発言語を取得
        // {task_dev}, {board}, {task}, {dev_language}
        final devResponse = await db.tTaskDevDao.getTaskDevListByProjectId(
            projectId: projectRow.readTable(db.tProject).projectId);

        projectStatusList.add(
          _convertProjectStatusModel(
            projectData: projectRow.readTable(db.tProject),
            projectColorData: projectRow.readTable(db.mColor),
            taskData: tagResponse.map((e) => e.readTable(db.tTask)).toList(),
            taskTagData: tagResponse
                .map((e) => e.readTableOrNull(db.tTaskTag))
                .whereType<TTaskTagData>()
                .toList(),
            tagData: tagResponse
                .map((e) => e.readTableOrNull(db.tTag))
                .whereType<TTagData>()
                .toList(),
            tagColorData: tagResponse
                .map((e) => e.readTableOrNull(db.mColor))
                .whereType<MColorData>()
                .toList(),
            devData: devResponse.map((e) => e.readTable(db.tTaskDev)).toList(),
            devLangData:
                devResponse.map((e) => e.readTable(db.tDevLanguage)).toList(),
          ),
        );
      }

      _logger.d('projectStatusList: $projectStatusList');
      return projectStatusList;
    } on Exception catch (exception) {
      _logger.e(exception);
      throw Exception(exception);
    } finally {
      _logger.i('getStatusList 終了');
    }
  }

// ステータス一覧 entity to model
  ProjectStatusModel _convertProjectStatusModel({
    required TProjectData projectData,
    required MColorData projectColorData,
    required List<TTaskData> taskData,
    required List<TTaskTagData> taskTagData,
    required List<TTagData> tagData,
    required List<MColorData> tagColorData,
    required List<TTaskDevData> devData,
    required List<TDevLanguageData> devLangData,
  }) {
    // 重複ラベルステータスリスト
    List<LabelStatusModel> tempLabelStatusList = [];
    // ラベルステータスリスト
    final List<LabelStatusModel> labelStatusList = [];
    // タスクステータスリスト
    final List<TaskStatusModel> taskStatusList = [];

    // ラベルIDに紐づくタスクIDのMap {key: labelId, value: taskId list}
    final Map<String, List<String>> labelMap = {};
    // 開発言語のMap {key: task_id, value: 言語名}
    final Map<String, String> devMap = {};

    // タスクに設定されている開発言語
    for (var i = 0; i < devData.length; i++) {
      devMap[devData[i].taskId] = devLangData[i].devLangId;
    }

    // タスクの全量をリストにセット
    for (var i = 0; i < taskData.length; i++) {
      final taskStatus = TaskStatusModel(
        taskItemId: taskData[i].taskId,
        devLangId: devMap[taskData[i].taskId] ?? '',
        startDate: DateTime.parse(taskData[i].startDate).toLocal(),
        doneDate: taskData[i].endDate != null
            ? DateTime.parse(taskData[i].endDate!).toLocal()
            : null,
        dueDate: DateTime.parse(taskData[i].dueDate).toLocal(),
      );
      taskStatusList.add(taskStatus);
    }

    for (var i = 0; i < taskTagData.length; i++) {
      final labelStatus = LabelStatusModel(
        labelId: tagData[i].id.toString(),
        labelName: tagData[i].name,
        themeColorModel: ColorModel(
            id: tagColorData[i].id,
            color: getColorFromCode(code: tagColorData[i].colorCodeId)),
        taskStatusList: [],
      );
      tempLabelStatusList.add(labelStatus);
      // ラベルIDをキーにし、紐づくタスクIDをマップに保持しておく
      if (labelMap.containsKey(tagData[i].id.toString())) {
        labelMap[tagData[i].id.toString()]!.add(taskTagData[i].taskId);
      } else {
        labelMap[tagData[i].id.toString()] = [taskTagData[i].taskId];
      }
    }

    // ラベル（タグ）情報が重複しているため重複削除
    tempLabelStatusList = tempLabelStatusList.toSet().toList();

    // ラベルに紐づくタスクを特定し、labelStatusListにセットする
    for (final item in tempLabelStatusList) {
      if (labelMap.containsKey(item.labelId)) {
        final List<TaskStatusModel> targetList = [];
        for (final taskId in labelMap[item.labelId] ?? []) {
          targetList
              .add(taskStatusList.firstWhere((e) => e.taskItemId == taskId));
        }
        labelStatusList.add(item.copyWith(taskStatusList: targetList));
      }
    }

    return ProjectStatusModel(
      projectId: projectData.projectId,
      projectName: projectData.name,
      themeColorModel: ColorModel(
        id: projectColorData.id,
        color: getColorFromCode(code: projectColorData.colorCodeId),
      ),
      startDate: DateTime.parse(projectData.startDate).toLocal(),
      endDate: DateTime.parse(projectData.endDate).toLocal(),
      labelStatusList: labelStatusList,
    );
  }
}
