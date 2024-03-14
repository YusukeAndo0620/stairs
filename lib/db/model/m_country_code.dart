import 'package:drift/drift.dart';

/// 国コード
@TableIndex(name: 'code', columns: {#code})
class MCountryCode extends Table {
  /// 国コード
  IntColumn get code => integer()();

  /// 国名
  TextColumn get name => text().withLength(min: 1, max: 50)();

  /// 国名（日本語）
  TextColumn get japaneseName => text().withLength(min: 1, max: 50)();

  /// 主要国かどうか
  BoolColumn get isMajor => boolean().withDefault(const Constant(false))();
  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  @override
  Set<Column> get primaryKey => {code};
}
