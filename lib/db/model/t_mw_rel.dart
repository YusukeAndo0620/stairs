import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// ミドルウェア紐付け
@TableIndex(name: 'mw_rel_id', columns: {#id})
class TMwRel extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get projectId => text().references(TProject, #projectId)();
  TextColumn get mwId => text().references(TMw, #mwId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
