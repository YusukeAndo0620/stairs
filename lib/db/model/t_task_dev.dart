import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// タスク開発言語紐付け
@TableIndex(name: 'task_dev_id', columns: {#id})
class TTaskDev extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskId =>
      text().withLength(min: 1, max: 50).references(TTask, #taskId)();
  TextColumn get devLangId =>
      text().withLength(min: 0, max: 50).references(TDevLanguage, #devLangId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
