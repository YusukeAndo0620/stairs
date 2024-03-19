import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 経歴書 役割
@TableIndex(name: 'resume_role_id', columns: {#id})
class TResumeRole extends Table {
  /// id
  IntColumn get id => integer().autoIncrement()();

  /// コード PM: 1, PL: 2, SM: 3, TL: 4, SL: 5, 開発: 6, テスター: 7
  IntColumn get code => integer().withDefault(const Constant(6))();

  /// 経歴書プロジェクトID
  IntColumn get resumeProjectId => integer().references(TResumeProject, #id)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
