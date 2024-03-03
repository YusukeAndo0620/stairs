import 'package:drift/drift.dart';
import 'm_account.dart';

/// 開発言語 ユーザが追加した言語、フレームワーク
@TableIndex(name: 't_dev_lang_id', columns: {#devLangId})
class TDevLanguage extends Table {
  TextColumn get devLangId => text().withLength(min: 1, max: 50)();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  BoolColumn get isReadOnly => boolean().withDefault(const Constant(false))();
  BoolColumn get isFramework => boolean().withDefault(const Constant(false))();
  TextColumn get accountId =>
      text().withLength(min: 1, max: 50).references(MAccount, #accountId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {devLangId};
}
