import 'package:stairs/loom/loom_package.dart';

class TaskItemModel {
  TaskItemModel({
    required this.boardId,
    required this.taskItemId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.doneDate,
    required this.labelList,
  });

  final String boardId;
  final String taskItemId;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? doneDate;
  final List<ColorLabelModel> labelList;

  TaskItemModel copyWith({
    String? boardId,
    String? taskItemId,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? doneDate,
    List<ColorLabelModel>? labelList,
  }) =>
      TaskItemModel(
        boardId: boardId ?? this.boardId,
        taskItemId: taskItemId ?? this.taskItemId,
        title: title ?? this.title,
        description: description ?? this.description,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        doneDate: doneDate ?? this.doneDate,
        labelList: labelList ?? this.labelList,
      );

  factory TaskItemModel.fromJson(dynamic json) {
    final boardId = json['boardId'];
    final taskItemId = json['taskItemId'];
    final title = json['title'];
    final description = json['description'];
    final startDate = DateTime.parse(json['startDate']);
    final endDate = DateTime.parse(json['endDate']);
    final doneDate = DateTime.parse(json['doneDate']);
    final List<ColorLabelModel> labelList = [];
    for (final item in labelList) {
      final colorLabelInfo = ColorLabelModel.fromJson(item);
      labelList.add(colorLabelInfo);
    }

    final model = TaskItemModel(
      boardId: boardId,
      taskItemId: taskItemId,
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
      doneDate: doneDate,
      labelList: labelList,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['boardId'] = boardId;
    data['taskItemId'] = taskItemId;
    data['title'] = title;
    data['description'] = description;
    data['startDate'] = startDate.toString();
    data['endDate'] = endDate.toString();
    data['doneDate'] = doneDate;

    final targetLabelList = [];
    for (final item in labelList) {
      final colorLabelModel = item.toJson();
      targetLabelList.add(colorLabelModel);
    }
    data['labelList'] = targetLabelList;
    return data;
  }

  @override
  String toString() {
    final targetLinkLabelList = [];
    for (final item in labelList) {
      final colorLabelInfo = item.toJson();
      targetLinkLabelList.add(colorLabelInfo);
    }

    return '''
      TaskItemModel{
        boardId: $boardId,
        taskItemId: $taskItemId,
        title: $title,
        description: $description,
        startDate: ${startDate.toString()},
        endDate: ${endDate.toString()},
        doneDate: ${doneDate.toString()},
        labelList: $targetLinkLabelList,
      }
    ''';
  }
}
