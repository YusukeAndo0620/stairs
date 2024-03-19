import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 経歴書 役割
@TableIndex(name: 'resume_dev_lang_rel_id', columns: {#id})
class TResumeDevLangRel extends Table {
  /// id
  IntColumn get id => integer().autoIncrement()();

  /// 開発言語ID
  TextColumn get devLangId =>
      text().withLength(min: 1, max: 50).references(TDevLanguage, #devLangId)();

  /// 経歴書プロジェクトID
  IntColumn get resumeProjectId => integer().references(TResumeProject, #id)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
