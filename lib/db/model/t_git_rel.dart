import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';

/// Git紐付け
@TableIndex(name: 'git_rel_id', columns: {#id})
class TGitRel extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get projectId => text().references(TProject, #projectId)();
  TextColumn get gitId => text().references(TGit, #gitId)();

  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}
