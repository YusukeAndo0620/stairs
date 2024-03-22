import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 経歴書 開発言語
@TableIndex(name: 'resume_dev_lang_id', columns: {#id})
class TResumeDevLang extends Table {
  /// id
  IntColumn get id => integer().autoIncrement()();

  /// 開発言語ID
  TextColumn get devLangId => text().references(TDevLanguage, #devLangId)();

  /// バージョンなど
  TextColumn get content =>
      text().withLength(min: 0, max: 50).clientDefault(() => '')();

  /// 経歴書プロジェクトID
  TextColumn get resumeProjectId =>
      text().references(TResumeProject, #resumeProjectId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
