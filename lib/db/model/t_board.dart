import 'package:drift/drift.dart';
import 't_project.dart';

/// プロジェクト
@TableIndex(name: 'board_id', columns: {#boardId})
class TBoard extends Table {
  TextColumn get boardId => text().withLength(min: 1, max: 50)();
  TextColumn get name => text().withLength(min: 1, max: 30)();
  IntColumn get orderNo => integer()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  TextColumn get projectId =>
      text().withLength(min: 1, max: 50).references(TProject, #projectId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {boardId};
}
