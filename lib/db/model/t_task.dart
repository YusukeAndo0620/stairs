import 'package:drift/drift.dart';
import 't_board.dart';

/// タスク
@TableIndex(name: 'task_id', columns: {#taskId})
class TTask extends Table {
  TextColumn get taskId => text().withLength(min: 1, max: 50)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().withLength(min: 1, max: 500)();
  TextColumn get startDate =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get endDate => text().nullable()();
  TextColumn get dueDate => text()();
  TextColumn get boardId =>
      text().withLength(min: 1, max: 50).references(TBoard, #boardId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {taskId};
}
