class TaskStatusModel {
  TaskStatusModel({
    required this.taskItemId,
    required this.devLangId,
    required this.startDate,
    required this.dueDate,
    this.doneDate,
  });
  final String taskItemId;
  final String devLangId;
  final DateTime startDate;
  final DateTime dueDate;
  final DateTime? doneDate;

  TaskStatusModel copyWith({
    String? taskItemId,
    String? devLangId,
    DateTime? startDate,
    DateTime? dueDate,
    DateTime? doneDate,
  }) =>
      TaskStatusModel(
        taskItemId: taskItemId ?? this.taskItemId,
        devLangId: devLangId ?? this.devLangId,
        startDate: startDate ?? this.startDate,
        dueDate: dueDate ?? this.dueDate,
        doneDate: doneDate ?? this.doneDate,
      );
  factory TaskStatusModel.fromJson(dynamic json) {
    final taskItemId = json['task_item_idd'];
    final devLangId = json['dev_lang_id'];
    final startDate = DateTime.parse(json['start_date']);
    final dueDate = DateTime.parse(json['due_date']);
    final doneDate = DateTime.parse(json['done_date']);

    final model = TaskStatusModel(
      taskItemId: taskItemId,
      devLangId: devLangId,
      startDate: startDate,
      dueDate: dueDate,
      doneDate: doneDate,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['task_item_idd'] = taskItemId;
    data['dev_lang_id'] = devLangId;
    data['start_date'] = startDate.toIso8601String();
    data['due_date'] = dueDate.toIso8601String();
    data['done_date'] = doneDate!.toIso8601String();

    return data;
  }

  @override
  String toString() {
    return '''

      TaskStatusModel {
        task_item_id: $taskItemId, 
        dev_lang_id: $devLangId, 
        start_date: ${startDate.toString()},
        due_date: ${dueDate.toString()},
        done_date: ${doneDate.toString()},
      }''';
  }
}
