import 'package:drift/drift.dart';
import 't_project.dart';

/// ツール
@TableIndex(name: 'tool_id', columns: {#toolId})
class TTool extends Table {
  TextColumn get toolId => text().withLength(min: 1, max: 50)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get projectId =>
      text().withLength(min: 1, max: 50).references(TProject, #projectId)();

  DateTimeColumn get createAt =>
      dateTime().clientDefault(() => DateTime.now().toLocal())();
  DateTimeColumn get updateAt =>
      dateTime().clientDefault(() => DateTime.now().toLocal())();

  @override
  Set<Column> get primaryKey => {toolId};
}
