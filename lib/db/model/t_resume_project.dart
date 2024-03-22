import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 経歴書スキル
@TableIndex(name: 'resume_project_id', columns: {#resumeProjectId})
class TResumeProject extends Table {
  /// 経歴書プロジェクトID
  TextColumn get resumeProjectId => text().withLength(min: 1, max: 50)();

  /// タイトル名
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// 説明・概要
  TextColumn get description => text().withLength(min: 0, max: 500)();

  /// 業種
  TextColumn get industry => text().withLength(min: 0, max: 100)();

  /// 開発手法
  IntColumn get devMethodCode => integer().withDefault(const Constant(0))();

  /// 画面数
  IntColumn get displayCount => integer()();

  /// テーブル数
  IntColumn get tableCount => integer()();

  /// 開始日
  TextColumn get startDate =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  /// 終了日
  TextColumn get endDate =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  /// 開発人数
  IntColumn get devSize => integer()();

  TextColumn get accountId =>
      text().withLength(min: 1, max: 50).references(MAccount, #accountId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {resumeProjectId};
}
