import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 経歴書 タグ
@TableIndex(name: 'resume_tag_id', columns: {#id})
class TResumeTag extends Table {
  /// id
  IntColumn get id => integer().autoIncrement()();

  /// タスク数
  IntColumn get taskCount => integer()();

  /// 経歴書プロジェクトID
  TextColumn get resumeProjectId =>
      text().references(TResumeProject, #resumeProjectId)();

  /// タグID
  IntColumn get tagId => integer().references(TTag, #id)();
  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
