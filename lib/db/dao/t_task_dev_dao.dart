import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_task_dev_dao.g.dart';

@DriftAccessor(tables: [TTaskDev])
class TTaskDevDao extends DatabaseAccessor<StairsDatabase>
    with _$TTaskDevDaoMixin {
  TTaskDevDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_task_dev_dao');

  /// タスクで使用されている開発言語を取得
  /// return {task_dev}, {dev_language}
  Future<List<TypedResult>> getTaskDevList({
    required String taskId,
  }) async {
    try {
      _logger.d('getTaskDevList 通信開始');
      final query = db.select(db.tTaskDev)
        ..where((tbl) => tbl.taskId.equals(taskId));

      final response = await query.join([
        // dev_language
        innerJoin(
          db.tDevLanguage,
          db.tDevLanguage.devLangId.equalsExp(db.tTaskDev.devLangId),
        ),
      ]).get();

      _logger.d('取得データ：$response');
      _logger.d('length: ${response.length}');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getTaskDevList 通信終了');
    }
  }

  /// タスク開発言語 追加
  Future<void> insertTaskDev({
    required TTaskDevCompanion taskDevData,
  }) async {
    try {
      _logger.d('insertTaskDev 通信開始');
      _logger.d('taskDevData:  $taskDevData');
      await db.into(db.tTaskDev).insert(taskDevData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertTaskDev 通信終了');
    }
  }

  /// タスク開発言語 taskIdで削除
  Future<void> deleteTaskDevByTaskId({
    required String taskId,
  }) async {
    try {
      _logger.d('deleteTaskDevByTaskId 通信開始');
      _logger.d('taskId: $taskId');
      final query = db.delete(db.tTaskDev)
        ..where((tbl) => tbl.taskId.equals(taskId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteTaskDevByTaskId 通信終了');
    }
  }
}
