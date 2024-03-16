import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 経歴書スキル
@TableIndex(name: 'resume_project_id', columns: {#id})
class TResumeProject extends Table {
  /// id
  IntColumn get id => integer().autoIncrement()();

  /// プロジェクトID
  TextColumn get projectId => text().withLength(min: 0, max: 100)();

  /// カラムのコード番号
  IntColumn get columnCode => integer()();

  /// 表示順
  IntColumn get orderNo => integer()();

  /// ユニークID（ラベルIDなど）
  TextColumn get uniqueId => text().withLength(min: 0, max: 100)();

  /// 内容
  TextColumn get content => text().withLength(min: 1, max: 100)();

  TextColumn get accountId =>
      text().withLength(min: 1, max: 50).references(MAccount, #accountId)();

  /// 編集内容
  TextColumn get editContent =>
      text().withDefault(const Constant('')).withLength(min: 0, max: 100)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
