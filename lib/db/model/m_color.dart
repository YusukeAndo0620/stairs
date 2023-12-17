import 'package:drift/drift.dart';

/// カラー
@TableIndex(name: 'color_id', columns: {#id})
class MColor extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get colorCodeId => text().withLength(min: 1, max: 50)();

  TextColumn get createAt =>
      text().clientDefault(() =>DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
