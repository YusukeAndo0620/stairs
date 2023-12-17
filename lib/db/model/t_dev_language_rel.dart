import 'package:drift/drift.dart';
import 't_project.dart';

/// 開発言語紐付け
@TableIndex(name: 'dev_lang_rel_id', columns: {#id})
class TDevLanguageRel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get projectId =>
      text().withLength(min: 1, max: 50).references(TProject, #projectId)();
  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
