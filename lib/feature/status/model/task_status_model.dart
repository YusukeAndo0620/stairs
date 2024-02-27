import 'package:stairs/loom/loom_package.dart';

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

  /// 期日を越えているタスクかどうか
  bool isOverDuDate({
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    // タスク開始日が対象日付の間にない場合チェックしない
    if (!isDateBetweenRange(
        start: firstDate, end: lastDate, target: startDate)) {
      return false;
    }
    if (doneDate != null) {
      // 完了日が期日を越えている
      return doneDate!.isAfter(dueDate);
    } else {
      // 期日が現在日時を越えている
      return DateTime.now().isAfter(dueDate);
    }
  }

  /// 期日前に完了したタスクかどうか
  bool isBeforeDuDate({
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    // タスク開始日が対象日付の間にない場合チェックしない
    if (!isDateBetweenRange(
        start: firstDate, end: lastDate, target: startDate)) {
      return false;
    }
    // 期日前に完了
    return doneDate != null && doneDate!.isBefore(dueDate);
  }
}
