import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// Git
@TableIndex(name: 'git_id', columns: {#gitId})
class TGit extends Table {
  TextColumn get gitId => text().withLength(min: 1, max: 50)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get accountId => text().references(MAccount, #accountId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {gitId};
}
