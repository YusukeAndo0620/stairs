import 'package:drift/drift.dart';
import 'm_account.dart';
import 'm_color.dart';

/// タグ 全てのプロジェクトでタグ選択する際の選択肢
@TableIndex(name: 'tag_id', columns: {#id})
class TTag extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get colorId => integer().references(MColor, #id)();
  BoolColumn get isReadOnly => boolean().withDefault(const Constant(false))();
  TextColumn get accountId =>
      text().withLength(min: 1, max: 50).references(MAccount, #accountId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
