import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 経歴書 DB紐付け
@TableIndex(name: 'resume_db_id', columns: {#id})
class TResumeDb extends Table {
  /// id
  IntColumn get id => integer().autoIncrement()();

  /// DbのID
  TextColumn get dbId => text().references(TDb, #dbId)();

  /// 経歴書プロジェクトID
  TextColumn get resumeProjectId =>
      text().references(TResumeProject, #resumeProjectId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
