import 'package:stairs/loom/loom_package.dart';

class TaskItemModel {
  TaskItemModel({
    required this.boardId,
    required this.taskItemId,
    required this.title,
    required this.description,
    required this.devLangId,
    required this.startDate,
    required this.dueDate,
    this.doneDate,
    required this.labelList,
  });

  final String boardId;
  final String taskItemId;
  final String title;
  final String description;
  final String devLangId;
  final DateTime startDate;
  final DateTime dueDate;
  final DateTime? doneDate;
  final List<ColorLabelModel> labelList;

  TaskItemModel copyWith({
    String? boardId,
    String? taskItemId,
    String? title,
    String? description,
    String? devLangId,
    DateTime? startDate,
    DateTime? dueDate,
    DateTime? doneDate,
    List<ColorLabelModel>? labelList,
  }) =>
      TaskItemModel(
        boardId: boardId ?? this.boardId,
        taskItemId: taskItemId ?? this.taskItemId,
        title: title ?? this.title,
        description: description ?? this.description,
        devLangId: devLangId ?? this.devLangId,
        startDate: startDate ?? this.startDate,
        dueDate: dueDate ?? this.dueDate,
        doneDate: doneDate ?? this.doneDate,
        labelList: labelList ?? this.labelList,
      );

  factory TaskItemModel.fromJson(dynamic json) {
    final boardId = json['boardId'];
    final taskItemId = json['task_item_id'];
    final title = json['title'];
    final description = json['description'];
    final devLangId = json['dev_lang_id'];
    final startDate = DateTime.parse(json['start_date']);
    final dueDate = DateTime.parse(json['done_date']);
    final doneDate = DateTime.parse(json['end_date']);
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
      devLangId: devLangId,
      startDate: startDate,
      dueDate: dueDate,
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
    data['dev_lang_id'] = devLangId;
    data['start_date'] = startDate.toIso8601String();
    data['end_date'] = dueDate.toIso8601String();
    data['done_date'] = doneDate!.toIso8601String();
    data['label_list'] = labelList.map((e) => e.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return '''
      TaskItemModel{
        board_id: $boardId,
        task_item_id: $taskItemId,
        title: $title,
        description: $description,
        dev_lang_id: $devLangId,
        start_date: ${startDate.toString()},
        due_date: ${dueDate.toString()},
        done_date: ${doneDate.toString()},
        label_list: ${labelList.map((e) => e.toJson()).toList()},
      }
    ''';
  }
}
