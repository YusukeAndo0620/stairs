import 'package:drift/drift.dart';

/// 開発工程マスタ
@TableIndex(name: 'dev_progress_id', columns: {#id})
class MDevProgressList extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 30)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
