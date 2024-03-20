import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// OS紐付け
@TableIndex(name: 'os_rel_id', columns: {#id})
class TOsRel extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get projectId => text().references(TProject, #projectId)();
  TextColumn get osId => text().references(TOsInfo, #osId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
