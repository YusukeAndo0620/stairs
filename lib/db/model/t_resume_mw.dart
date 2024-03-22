import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 経歴書 ミドルウェア紐付け
@TableIndex(name: 'resume_mw_id', columns: {#id})
class TResumeMw extends Table {
  /// id
  IntColumn get id => integer().autoIncrement()();

  /// MwのID
  TextColumn get mwId => text().references(TMw, #mwId)();

  /// 経歴書プロジェクトID
  TextColumn get resumeProjectId =>
      text().references(TResumeProject, #resumeProjectId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
