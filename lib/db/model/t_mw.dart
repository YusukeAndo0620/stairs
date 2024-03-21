import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// ミドルウェア
@TableIndex(name: 'mw_id', columns: {#mwId})
class TMw extends Table {
  TextColumn get mwId => text().withLength(min: 1, max: 50)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get accountId => text().references(MAccount, #accountId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {mwId};
}
