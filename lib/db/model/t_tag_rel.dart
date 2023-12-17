import 'package:drift/drift.dart';
import 't_tag.dart';
import 'm_color.dart';
import 't_project.dart';

/// タグ紐付け プロジェクト内のタスクで選択肢となるタグ
@TableIndex(name: 'tag_rel_id', columns: {#id})
class TTagRel extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get colorId => integer().references(MColor, #id)();
  TextColumn get projectId =>
      text().withLength(min: 1, max: 50).references(TProject, #projectId)();
  IntColumn get tagId => integer().references(TTag, #id)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
