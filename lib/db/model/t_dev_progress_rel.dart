import 'package:drift/drift.dart';
import 't_project.dart';
import 'm_dev_progress_list.dart';

/// 開発工程マスタ
@TableIndex(name: 'dev_progress_rel_id', columns: {#id})
class TDevProgressRel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get projectId =>
      text().withLength(min: 1, max: 50).references(TProject, #projectId)();
  IntColumn get devProgressId => integer().references(MDevProgressList, #id)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
