import 'package:stairs/feature/status/model/label_status_model.dart';
import 'package:stairs/feature/status/model/task_status_model.dart';
import 'package:stairs/loom/loom_package.dart';

class ProjectStatusModel {
  ProjectStatusModel({
    required this.projectId,
    required this.projectName,
    required this.themeColorModel,
    required this.startDate,
    required this.endDate,
    required this.devLangMap,
    required this.taskStatusList,
    required this.labelStatusList,
  });

  final String projectId;
  final String projectName;
  final ColorModel themeColorModel;
  // 開始日
  final DateTime startDate;
  // 終了日
  final DateTime endDate;
  // 開発言語 key: devLangId, value: 開発言語名
  final Map<String, String> devLangMap;
  // 全てのタスク
  final List<TaskStatusModel> taskStatusList;
  final List<LabelStatusModel> labelStatusList;

  /// タスクに使用されているラベルの総数
  int get totalLabelTaskCount {
    int count = 0;
    for (final label in labelStatusList) {
      count += label.taskIdList.length;
    }
    return count;
  }

  /// ラベルが設定されているタスクリスト
  List<TaskStatusModel> getTaskListWithLabel({required String labelId}) {
    final targetLabelIdx =
        labelStatusList.indexWhere((element) => element.labelId == labelId);
    if (targetLabelIdx == -1) return [];
    final List<TaskStatusModel> target = [];
    for (final taskId in labelStatusList[targetLabelIdx].taskIdList) {
      target
          .add(taskStatusList.firstWhere((task) => task.taskItemId == taskId));
    }
    return target;
  }

  // 開発言語IDより、該当するタスクのIDリストを取得
  List<String> getTaskIdListWithDevLangId({required String devLangId}) {
    final List<String> targetList = [];
    for (final task in taskStatusList) {
      if (task.devLangId == devLangId) {
        targetList.add(task.taskItemId);
      }
    }
    return targetList;
  }

  /// 完了したタスク数
  int get completedTaskCount {
    return taskStatusList
        .map((task) => task.doneDate != null ? task.taskItemId : null)
        .whereType<String>()
        .toList()
        .length;
  }

  /// 期限切れのタスク数
  int get overDueDateTaskCount {
    return taskStatusList
        .map((task) =>
            task.doneDate == null && task.dueDate.isBefore(DateTime.now())
                ? task.taskItemId
                : null)
        .whereType<String>()
        .toList()
        .length;
  }

  /// 先月の進行中タスク数
  int get lastMonthProgressTaskCount {
    final now = DateTime.now();
    final List<String> taskIdList = taskStatusList
        .map((task) =>
            task.startDate.isAfter(DateTime(now.year, now.month - 1)) &&
                    task.doneDate == null &&
                    task.dueDate.isBefore(DateTime(now.year, now.month - 1))
                ? task.taskItemId
                : null)
        .whereType<String>()
        .toList();
    return (taskStatusList.length - overDueDateTaskCount - completedTaskCount) <
            taskIdList.length
        ? taskIdList.length * -1
        : taskIdList.length;
  }

  /// 先月の完了タスク数
  int get lastMonthCompletedTaskCount {
    final now = DateTime.now();
    final List<String> taskIdList = taskStatusList
        .map((task) => task.doneDate != null &&
                task.doneDate!.isAfter(DateTime(now.year, now.month - 1))
            ? task.taskItemId
            : null)
        .whereType<String>()
        .toList();
    return completedTaskCount < taskIdList.length
        ? taskIdList.length * -1
        : taskIdList.length;
  }

  /// 先月の期限切れタスク数
  int get lastMonthOverDueDateTaskCount {
    final now = DateTime.now();
    final List<String> taskIdList = taskStatusList
        .map((task) => task.doneDate == null &&
                task.dueDate.isAfter(DateTime(now.year, now.month - 1))
            ? task.taskItemId
            : null)
        .whereType<String>()
        .toList();
    return overDueDateTaskCount < taskIdList.length
        ? taskIdList.length * -1
        : taskIdList.length;
  }

  /// 先月の総タスク数
  int get lastMonthTotalTaskCount {
    final now = DateTime.now();
    final List<String> taskIdList = taskStatusList
        .map((task) => task.startDate.isAfter(DateTime(now.year, now.month - 1))
            ? task.taskItemId
            : null)
        .whereType<String>()
        .toList();
    return taskIdList.length;
  }

  ProjectStatusModel copyWith({
    String? projectId,
    String? projectName,
    ColorModel? themeColorModel,
    DateTime? startDate,
    DateTime? endDate,
    Map<String, String>? devLangMap,
    List<TaskStatusModel>? taskStatusList,
    List<LabelStatusModel>? labelStatusList,
  }) =>
      ProjectStatusModel(
        projectId: projectId ?? this.projectId,
        projectName: projectName ?? this.projectName,
        themeColorModel: themeColorModel ?? this.themeColorModel,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        devLangMap: devLangMap ?? this.devLangMap,
        taskStatusList: taskStatusList ?? this.taskStatusList,
        labelStatusList: labelStatusList ?? this.labelStatusList,
      );

  factory ProjectStatusModel.fromJson(dynamic json) {
    final projectId = json['project_id'];
    final projectName = json['project_name'];
    final startDate = DateTime.parse(json['start_date']);
    final endDate = DateTime.parse(json['end_date']);
    final themeColorModel = ColorModel.fromJson(json['theme_color_model']);
    final devLangMap = json['dev_lang_map'];
    final List<TaskStatusModel> taskList = [];
    for (final item in json['task_status_list']) {
      final taskStatus = TaskStatusModel.fromJson(item);
      taskList.add(taskStatus);
    }
    final List<LabelStatusModel> labelList = [];
    for (final item in json['label_status_list']) {
      final taskStatus = LabelStatusModel.fromJson(item);
      labelList.add(taskStatus);
    }

    final model = ProjectStatusModel(
      projectId: projectId,
      projectName: projectName,
      startDate: startDate,
      endDate: endDate,
      themeColorModel: themeColorModel,
      devLangMap: devLangMap,
      taskStatusList: taskList,
      labelStatusList: labelList,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['project_id'] = projectId;
    data['project_name'] = projectName;
    data['start_date'] = startDate.toIso8601String();
    data['end_date'] = endDate.toIso8601String();
    data['theme_color_model'] = themeColorModel.toJson();
    data['dev_lang_map'] = devLangMap;
    data['task_status_list'] = taskStatusList.map((e) => e.toJson()).toList();
    data['label_status_list'] = labelStatusList.map((e) => e.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return '''

      ProjectStatusModel {
        project_id: $projectId, 
        project_name: $projectName, 
        start_date: ${startDate.toString()},
        end_date: ${endDate.toString()},
        theme_color_model: ${themeColorModel.toString()},
        dev_lang_map: ${devLangMap.toString()},
        task_status_list: ${taskStatusList.map((e) => e.toString()).toList()},
        label_status_list: ${labelStatusList.map((e) => e.toString()).toList()},
      }''';
  }
}
