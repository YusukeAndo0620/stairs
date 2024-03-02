import 'package:collection/collection.dart';
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
        final taskResponse = await db.tTaskDao.getTaskDetailByProjectId(
            projectId: projectRow.readTable(db.tProject).projectId);

        // プロジェクトで使用されている開発言語
        final projectDevLangResponse = await db.tDevLangRelDao.getDevLangList(
            projectId: projectRow.readTable(db.tProject).projectId);

        projectStatusList.add(
          _convertProjectStatusModel(
            projectData: projectRow.readTable(db.tProject),
            projectColorData: projectRow.readTable(db.mColor),
            projectDevLangData: projectDevLangResponse
                .map((e) => e.readTableOrNull(db.tDevLanguage))
                .whereType<TDevLanguageData>()
                .toList(),
            taskData: taskResponse.map((e) => e.readTable(db.tTask)).toList(),
            taskTagData: taskResponse
                .map((e) => e.readTableOrNull(db.tTaskTag))
                .toList(),
            tagData:
                taskResponse.map((e) => e.readTableOrNull(db.tTag)).toList(),
            tagColorData:
                taskResponse.map((e) => e.readTableOrNull(db.mColor)).toList(),
            devData: taskResponse.map((e) => e.readTable(db.tTaskDev)).toList(),
            devLangData: taskResponse
                .map((e) => e.readTableOrNull(db.tDevLanguage))
                .toList(),
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
    required List<TDevLanguageData> projectDevLangData,
    required List<TTaskData> taskData,
    required List<TTaskTagData?> taskTagData,
    required List<TTagData?> tagData,
    required List<MColorData?> tagColorData,
    required List<TTaskDevData> devData,
    required List<TDevLanguageData?> devLangData,
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
      devMap[devData[i].taskId] =
          devLangData[i] != null ? devLangData[i]!.devLangId : '';
    }

    // タスクの全量をリストにセット
    for (var i = 0; i < taskData.length; i++) {
      // すでに同じタスクが追加されている場合は追加しない
      if (taskStatusList
              .indexWhere((task) => task.taskItemId == taskData[i].taskId) !=
          -1) {
        continue;
      }

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
      if (taskTagData[i] == null) {
        continue;
      }
      final labelStatus = LabelStatusModel(
        labelId: tagData[i]!.id.toString(),
        labelName: tagData[i]!.name,
        themeColorModel: ColorModel(
            id: tagColorData[i]!.id,
            color: getColorFromCode(code: tagColorData[i]!.colorCodeId)),
        taskIdList: [],
      );
      // すでに同じラベルが追加されていない場合追加する
      if (tempLabelStatusList.firstWhereOrNull(
              (item) => item.labelId == tagData[i]!.id.toString()) ==
          null) {
        tempLabelStatusList.add(labelStatus);
      }
      // ラベルIDをキーにし、紐づくタスクIDをマップに保持しておく
      if (labelMap.containsKey(tagData[i]!.id.toString())) {
        labelMap[tagData[i]!.id.toString()]!.add(taskTagData[i]!.taskId);
      } else {
        labelMap[tagData[i]!.id.toString()] = [taskTagData[i]!.taskId];
      }
    }

    // ラベルに紐づくタスクを特定し、labelStatusListにセットする
    for (final item in tempLabelStatusList) {
      if (labelMap.containsKey(item.labelId)) {
        labelStatusList.add(item.copyWith(taskIdList: labelMap[item.labelId]));
      }
    }
    // 開発言語 key: devLangId, value: 開発言語名
    Map<String, String> projectDevLangMap = {};
    for (final projectDev in projectDevLangData) {
      projectDevLangMap[projectDev.devLangId] = projectDev.name;
    }

    return ProjectStatusModel(
      projectId: projectData.projectId,
      projectName: projectData.name,
      themeColorModel: ColorModel(
        id: projectColorData.id,
        color: getColorFromCode(code: projectColorData.colorCodeId),
      ),
      devLangMap: projectDevLangMap,
      startDate: DateTime.parse(projectData.startDate).toLocal(),
      endDate: DateTime.parse(projectData.endDate).toLocal(),
      taskStatusList: taskStatusList,
      labelStatusList: labelStatusList,
    );
  }
}
