import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/stairs_logger.dart';

part 't_task_dao.g.dart';

@DriftAccessor(tables: [TTask])
class TTaskDao extends DatabaseAccessor<StairsDatabase> with _$TTaskDaoMixin {
  TTaskDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_task_dao');

  /// タスク取得
  /// return {task}
  Future<List<TTaskData>> getTaskDetail({
    required String boardId,
  }) async {
    try {
      _logger.d('getTaskDetail 通信開始');
      // 詳細取得クエリ
      final detailQuery = db.select(db.tTask)
        ..where((tbl) => tbl.boardId.equals(boardId));
      // 詳細
      final response = await detailQuery.get();

      _logger.d('取得データ：$response');

      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getTaskDetail 通信終了');
    }
  }

  /// タスク取得（projectIdで全て取得）
  /// return {task}, {board}, {task_tag}, {tag_rel}, {tag}, {color}, {task_dev}, {dev_language}
  Future<List<TypedResult>> getTaskDetailByProjectId({
    required String projectId,
  }) async {
    try {
      _logger.d('getTaskDetailByProjectId 通信開始');
      final query = db.select(db.tTask);
      final response = await query.join(
        [
          // board
          innerJoin(
              db.tBoard,
              db.tBoard.projectId.equals(projectId) &
                  db.tBoard.boardId.equalsExp(db.tTask.boardId)),
          // task_tag
          leftOuterJoin(
            db.tTaskTag,
            db.tTaskTag.taskId.equalsExp(db.tTask.taskId),
          ),
          // tag_rel
          leftOuterJoin(
            db.tTagRel,
            db.tTagRel.id.equalsExp(db.tTaskTag.tagRelId),
          ),
          // tag
          leftOuterJoin(
            db.tTag,
            db.tTag.id.equalsExp(db.tTagRel.tagId),
          ),
          // カラー
          leftOuterJoin(
            db.mColor,
            db.mColor.id.equalsExp(db.tTag.colorId),
          ),
          // task_dev
          innerJoin(
            db.tTaskDev,
            db.tTaskDev.taskId.equalsExp(db.tTask.taskId),
          ),
          // dev_language
          leftOuterJoin(
            db.tDevLanguage,
            db.tDevLanguage.devLangId.equalsExp(db.tTaskDev.devLangId),
          ),
        ],
      ).get();

      _logger.d('取得データ：$response');

      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getTaskDetailByProjectId 通信終了');
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
      _logger.d('taskData: $taskData');
      await db.update(db.tTask).replace(taskData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateTask 通信終了');
    }
  }

  /// タスク taskIdで削除
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

  /// タスク boardIdで削除
  Future<void> deleteTaskByBoardId({
    required String boardId,
  }) async {
    try {
      _logger.d('deleteTaskByBoardId 通信開始');
      _logger.d('boardId: $boardId');
      final query = db.delete(db.tTask)
        ..where((tbl) => tbl.boardId.equals(boardId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteTaskByBoardId 通信終了');
    }
  }
}
