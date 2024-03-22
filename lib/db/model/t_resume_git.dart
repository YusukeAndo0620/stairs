import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 経歴書 Git紐付け
@TableIndex(name: 'resume_git_id', columns: {#id})
class TResumeGit extends Table {
  /// id
  IntColumn get id => integer().autoIncrement()();

  /// GitのID
  TextColumn get gitId => text().references(TGit, #gitId)();

  /// 経歴書プロジェクトID
  TextColumn get resumeProjectId =>
      text().references(TResumeProject, #resumeProjectId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
