import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// DB
@TableIndex(name: 'db_id', columns: {#dbId})
class TDb extends Table {
  TextColumn get dbId => text().withLength(min: 1, max: 50)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get accountId => text().references(MAccount, #accountId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {dbId};
}
