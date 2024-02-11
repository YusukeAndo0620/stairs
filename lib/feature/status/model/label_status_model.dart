import 'package:stairs/feature/status/model/task_status_model.dart';
import 'package:stairs/loom/loom_package.dart';

class LabelStatusModel {
  LabelStatusModel({
    required this.labelId,
    required this.labelName,
    required this.themeColorModel,
    required this.taskStatusList,
  });

  final String labelId;
  final String labelName;
  final ColorModel themeColorModel;
  final List<TaskStatusModel> taskStatusList;

  LabelStatusModel copyWith({
    String? labelId,
    String? labelName,
    ColorModel? themeColorModel,
    List<TaskStatusModel>? taskStatusList,
  }) =>
      LabelStatusModel(
        labelId: labelId ?? this.labelId,
        labelName: labelName ?? this.labelName,
        themeColorModel: themeColorModel ?? this.themeColorModel,
        taskStatusList: taskStatusList ?? this.taskStatusList,
      );

  factory LabelStatusModel.fromJson(dynamic json) {
    final labelId = json['label_id'];
    final labelName = json['label_name'];
    final themeColorModel = ColorModel.fromJson(json['theme_color_model']);
    final List<TaskStatusModel> taskList = [];
    for (final item in json['task_status_list']) {
      final taskStatus = TaskStatusModel.fromJson(item);
      taskList.add(taskStatus);
    }

    final model = LabelStatusModel(
      labelId: labelId,
      labelName: labelName,
      themeColorModel: themeColorModel,
      taskStatusList: taskList,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['label_id'] = labelId;
    data['label_name'] = labelName;
    data['theme_color_model'] = themeColorModel.toJson();
    data['task_status_list'] = taskStatusList.map((e) => e.toJson()).toList();

    return data;
  }

  @override
  String toString() {
    return '''

      LabelStatusModel {
        label_id: $labelId, 
        label_name: $labelName, 
        theme_color_model: ${themeColorModel.toString()},
        task_status_list: ${taskStatusList.map((e) => e.toString()).toList()},
      }''';
  }
}
