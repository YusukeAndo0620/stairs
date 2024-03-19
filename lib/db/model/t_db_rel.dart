import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// DB紐付け
@TableIndex(name: 'db_rel_id', columns: {#id})
class TDbRel extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get projectId => text().references(TProject, #projectId)();
  TextColumn get dbId => text().references(TDb, #dbId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
