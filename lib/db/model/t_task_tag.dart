import 'package:drift/drift.dart';
import 't_task.dart';
import 't_tag_rel.dart';

/// タスクタグ
@TableIndex(name: 'task_tag_id', columns: {#id})
class TTaskTag extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskId =>
      text().withLength(min: 1, max: 50).references(TTask, #taskId)();
  TextColumn get tagId =>
      text().withLength(min: 1, max: 50).references(TTagRel, #id)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
