import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// プロジェクト 役割
@TableIndex(name: 'project_role_id', columns: {#id})
class TProjectRole extends Table {
  /// id
  IntColumn get id => integer().autoIncrement()();

  /// コード PM: 1, PL: 2, SM: 3, TL: 4, SL: 5, 開発: 6, テスター: 7
  IntColumn get code => integer().withDefault(const Constant(6))();

  /// 経歴書プロジェクトID
  TextColumn get projectId => text().references(TProject, #projectId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
