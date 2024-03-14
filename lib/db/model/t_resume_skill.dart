import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// 経歴書スキル
@TableIndex(name: 'resume_skill_id', columns: {#id})
class TResumeSkill extends Table {
  /// id
  IntColumn get id => integer().autoIncrement()();

  /// カラムのコード番号
  IntColumn get columnCode => integer()();

  /// 表示順
  IntColumn get orderNo => integer()();

  /// 内容
  TextColumn get content => text().withLength(min: 1, max: 100)();

  /// 編集内容
  TextColumn get editContent =>
      text().withDefault(const Constant('')).withLength(min: 0, max: 100)();

  /// サブ内容 年数や取得年次など
  TextColumn get subContent => text().withLength(min: 1, max: 30)();

  /// 編集サブ内容
  TextColumn get editSubContent =>
      text().withDefault(const Constant('')).withLength(min: 0, max: 30)();

  TextColumn get accountId =>
      text().withLength(min: 1, max: 50).references(MAccount, #accountId)();
  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
