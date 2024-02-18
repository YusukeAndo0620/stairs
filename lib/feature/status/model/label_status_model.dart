import 'package:stairs/loom/loom_package.dart';

class LabelStatusModel {
  LabelStatusModel({
    required this.labelId,
    required this.labelName,
    required this.themeColorModel,
    required this.taskIdList,
  });

  final String labelId;
  final String labelName;
  final ColorModel themeColorModel;
  final List<String> taskIdList;

  LabelStatusModel copyWith({
    String? labelId,
    String? labelName,
    ColorModel? themeColorModel,
    List<String>? taskIdList,
  }) =>
      LabelStatusModel(
        labelId: labelId ?? this.labelId,
        labelName: labelName ?? this.labelName,
        themeColorModel: themeColorModel ?? this.themeColorModel,
        taskIdList: taskIdList ?? this.taskIdList,
      );

  factory LabelStatusModel.fromJson(dynamic json) {
    final labelId = json['label_id'];
    final labelName = json['label_name'];
    final themeColorModel = ColorModel.fromJson(json['theme_color_model']);
    final taskIdList = json['task_id_list'];

    final model = LabelStatusModel(
      labelId: labelId,
      labelName: labelName,
      themeColorModel: themeColorModel,
      taskIdList: taskIdList,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['label_id'] = labelId;
    data['label_name'] = labelName;
    data['theme_color_model'] = themeColorModel.toJson();
    data['task_id_list'] = taskIdList;

    return data;
  }

  @override
  String toString() {
    return '''

      LabelStatusModel {
        label_id: $labelId, 
        label_name: $labelName, 
        theme_color_model: ${themeColorModel.toString()},
        task_id_list: $taskIdList,
      }''';
  }
}
