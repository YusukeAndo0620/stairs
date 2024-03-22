import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 経歴書 OS紐付け
@TableIndex(name: 'resume_os_rel_id', columns: {#id})
class TResumeOsRel extends Table {
  /// id
  IntColumn get id => integer().autoIncrement()();

  /// OSのID
  TextColumn get osId => text().references(TOsInfo, #osId)();

  /// 経歴書プロジェクトID
  TextColumn get resumeProjectId =>
      text().references(TResumeProject, #resumeProjectId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
