import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 経歴書 Tool紐付け
@TableIndex(name: 'resume_tool_id', columns: {#id})
class TResumeTool extends Table {
  /// id
  IntColumn get id => integer().autoIncrement()();

  /// ToolのID
  TextColumn get toolId => text().references(TTool, #toolId)();

  /// 経歴書プロジェクトID
  TextColumn get resumeProjectId =>
      text().references(TResumeProject, #resumeProjectId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
