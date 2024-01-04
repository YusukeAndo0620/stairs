import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/stairs_logger.dart';

part 't_task_dao.g.dart';

@DriftAccessor(tables: [TTask])
class TTaskDao extends DatabaseAccessor<StairsDatabase> with _$TTaskDaoMixin {
  TTaskDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_task_dao');

  /// ボード詳細取得
  Future<List<TypedResult>> getTaskDetail({
    required String boardId,
  }) async {
    try {
      _logger.d('getTaskDetail 通信開始');
      // 詳細取得クエリ
      final detailQuery = db.select(db.tTask)
        ..where((tbl) => tbl.boardId.equals(boardId));
      // 詳細
      final response = await detailQuery.join(
        [
          leftOuterJoin(
            db.tTaskTag,
            db.tTask.taskId.equalsExp(db.tTaskTag.taskId),
          ),
          leftOuterJoin(
            db.tTaskDev,
            db.tTask.taskId.equalsExp(db.tTaskDev.taskId),
          ),
        ],
      ).get();

      _logger.d('取得データ：$response');

      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getTaskDetail 通信終了');
    }
  }

  /// タスク 追加
  Future<void> insertTask({
    required TTaskCompanion taskData,
  }) async {
    try {
      _logger.d('insertTask 通信開始');
      _logger.d('taskData: $taskData');
      await db.into(db.tTask).insert(taskData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertTask 通信終了');
    }
  }

  /// タスク 更新
  Future<void> updateTask({
    required TTaskCompanion taskData,
  }) async {
    try {
      _logger.d('updateTask 通信開始');
      _logger.d('taskData:  $taskData');
      await db.update(db.tTask).replace(taskData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateTask 通信終了');
    }
  }

  /// タスク 削除
  Future<void> deleteTaskById({
    required String taskId,
  }) async {
    try {
      _logger.d('deleteTaskById 通信開始');
      _logger.d('taskId: $taskId');
      final query = db.delete(db.tTask)
        ..where((tbl) => tbl.taskId.equals(taskId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteTaskById 通信終了');
    }
  }
}
