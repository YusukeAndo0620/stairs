import 'package:stairs/feature/status/model/label_status_model.dart';
import 'package:stairs/loom/loom_package.dart';

class ProjectStatusModel {
  ProjectStatusModel({
    required this.projectId,
    required this.projectName,
    required this.themeColorModel,
    required this.startDate,
    required this.endDate,
    required this.labelStatusList,
  });

  final String projectId;
  final String projectName;
  final ColorModel themeColorModel;
  // 開始日
  final DateTime startDate;
  // 終了日
  final DateTime endDate;
  final List<LabelStatusModel> labelStatusList;

// 完了したタスク数
  int get completedTaskCount {
    final List<String> taskIdList = [];
    for (final label in labelStatusList) {
      taskIdList.addAll(label.taskStatusList
          .map((task) => task.doneDate != null ? task.taskItemId : null)
          .whereType<String>()
          .toList());
    }
    return taskIdList.toSet().toList().length;
  }

  // 総タスク数
  int get totalTaskCount {
    final List<String> taskIdList = [];
    for (final label in labelStatusList) {
      taskIdList.addAll(label.taskStatusList.map((e) => e.taskItemId).toList());
    }
    return taskIdList.toSet().toList().length;
  }

  ProjectStatusModel copyWith({
    String? projectId,
    String? projectName,
    ColorModel? themeColorModel,
    DateTime? startDate,
    DateTime? endDate,
    List<LabelStatusModel>? labelStatusList,
  }) =>
      ProjectStatusModel(
        projectId: projectId ?? this.projectId,
        projectName: projectName ?? this.projectName,
        themeColorModel: themeColorModel ?? this.themeColorModel,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        labelStatusList: labelStatusList ?? this.labelStatusList,
      );

  factory ProjectStatusModel.fromJson(dynamic json) {
    final projectId = json['project_id'];
    final projectName = json['project_name'];
    final startDate = DateTime.parse(json['start_date']);
    final endDate = DateTime.parse(json['end_date']);
    final themeColorModel = ColorModel.fromJson(json['theme_color_model']);
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
        labelStatusList: labelList);

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['project_id'] = projectId;
    data['project_name'] = projectName;
    data['start_date'] = startDate.toIso8601String();
    data['end_date'] = endDate.toIso8601String();
    data['theme_color_model'] = themeColorModel.toJson();
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
        label_status_list: ${labelStatusList.map((e) => e.toString()).toList()},
      }''';
  }
}
