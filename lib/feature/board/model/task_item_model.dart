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
    final boardId = json['board_id'];
    final taskItemId = json['task_item_id'];
    final title = json['title'];
    final description = json['description'];
    final startDate = json['start_date'];
    final endDate = json['end_date'];
    final doneDate = json['done_date'];
    final labelList = json['label_list'];

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
    data['board_id'] = boardId;
    data['task_item_id'] = taskItemId;
    data['title'] = title;
    data['description'] = description;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['done_date'] = doneDate;
    data['label_list'] = labelList.map((e) => e.toJson()).toList();

    return data;
  }

  @override
  String toString() {
    return '''
      TaskItemModel{
        board_id: $boardId,
        task_item_id: $taskItemId,
      }
    ''';
  }
}
