import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// ツール紐付け
@TableIndex(name: 'tool_rel_id', columns: {#id})
class TToolRel extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get projectId => text().references(TProject, #projectId)();
  TextColumn get toolId => text().references(TTool, #toolId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
