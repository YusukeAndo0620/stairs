import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 経歴書 開発工程紐付け
@TableIndex(name: 'resume_dev_progress_id', columns: {#id})
class TResumeDevProgressList extends Table {
  /// id
  IntColumn get id => integer().autoIncrement()();

  /// DevProgressListのID
  IntColumn get devProgressId => integer().references(MDevProgressList, #id)();

  /// 経歴書プロジェクトID
  TextColumn get resumeProjectId =>
      text().references(TResumeProject, #resumeProjectId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
