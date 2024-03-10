import 'package:drift/drift.dart';
import 'm_color.dart';
import 'm_account.dart';

/// プロジェクト
@TableIndex(name: 'project_id', columns: {#projectId})
class TProject extends Table {
  TextColumn get projectId => text().withLength(min: 1, max: 50)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get colorId => integer().references(MColor, #id)();
  TextColumn get industry => text().withLength(min: 0, max: 100)();
  IntColumn get displayCount => integer()();
  IntColumn get tableCount => integer()();
  TextColumn get startDate =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get endDate =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get description => text().withLength(min: 0, max: 500)();
  IntColumn get devSize => integer()();

  TextColumn get accountId =>
      text().withLength(min: 1, max: 50).references(MAccount, #accountId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {projectId};
}
