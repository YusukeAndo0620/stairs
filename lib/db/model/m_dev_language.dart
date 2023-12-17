import 'package:drift/drift.dart';

/// 開発言語マスタ 固定データ
@TableIndex(name: 'dev_lang_id', columns: {#devLangId})
class MDevLanguage extends Table {
  TextColumn get devLangId => text().withLength(min: 1, max: 50)();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  BoolColumn get isReadOnly => boolean().withDefault(const Constant(true))();
  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {devLangId};
}
