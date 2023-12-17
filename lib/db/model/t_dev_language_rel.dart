import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 開発言語紐付け
@TableIndex(name: 'dev_lang_rel_id', columns: {#id})
class TDevLanguageRel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text().withLength(min: 1, max: 50)();
  TextColumn get projectId =>
      text().withLength(min: 1, max: 50).references(TProject, #projectId)();
  TextColumn get devLangId =>
      text().withLength(min: 1, max: 50).references(TDevLanguage, #devLangId)();
  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
