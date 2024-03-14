import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// アカウント
@TableIndex(name: 'account_id', columns: {#accountId})
class MAccount extends Table {
  TextColumn get accountId => text().withLength(min: 1, max: 50)();

  /// 姓
  TextColumn get firstName => text().withLength(min: 1, max: 50)();

  /// 名
  TextColumn get lastName => text().withLength(min: 1, max: 50)();

  /// 男性かどうか
  BoolColumn get isMale => boolean().withDefault(const Constant(true))();

  /// 生年月日
  TextColumn get birthDate => text().withLength(min: 1, max: 8)();

  /// メールアドレス
  TextColumn get address => text().withLength(min: 1, max: 50)();

  /// 国コード
  IntColumn get countryCode => integer()
      .references(MCountryCode, #code)
      .withDefault(const Constant(83))();

  /// 学歴
  TextColumn get academicBackground => text().withLength(min: 0, max: 50)();

  /// 得意技術
  TextColumn get strongTech => text().withLength(min: 0, max: 100)();

  /// 自己PR
  TextColumn get strongPoint => text().withLength(min: 0, max: 300)();

  /// プラン種別
  IntColumn get planType => integer().withDefault(const Constant(0))();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {accountId};
}
