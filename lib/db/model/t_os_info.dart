import 'package:drift/drift.dart';
import 't_project.dart';

/// OS
@TableIndex(name: 'os_id', columns: {#osId})
class TOsInfo extends Table {
  TextColumn get osId => text().withLength(min: 1, max: 50)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get projectId =>
      text().withLength(min: 1, max: 50).references(TProject, #projectId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {osId};
}
