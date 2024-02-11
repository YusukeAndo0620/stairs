import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_task_tag_dao.g.dart';

@DriftAccessor(tables: [TTaskTag])
class TTaskTagDao extends DatabaseAccessor<StairsDatabase>
    with _$TTaskTagDaoMixin {
  TTaskTagDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_task_tag_dao');

  /// タスクで使用されているタグを取得
  /// return {task_tag}, {tag_rel}, {tag}, {color}
  Future<List<TypedResult>> getTaskTagList({
    required String taskId,
  }) async {
    try {
      _logger.d('getTaskTagList 通信開始');
      final query = db.select(db.tTaskTag)
        ..where((tbl) => tbl.taskId.equals(taskId));

      final response = await query.join([
        // tag_rel
        innerJoin(
          db.tTagRel,
          db.tTagRel.id.equalsExp(db.tTaskTag.tagRelId),
        ),
        // tag
        innerJoin(
          db.tTag,
          db.tTag.id.equalsExp(db.tTagRel.tagId),
        ),
        // カラー
        innerJoin(
          db.mColor,
          db.mColor.id.equalsExp(db.tTag.colorId),
        ),
      ]).get();

      _logger.d('取得データ：$response');
      _logger.d('length: ${response.length}');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getTaskTagList 通信終了');
    }
  }

  /// プロジェクトごとのタスクで使用されているタグを取得（projectId）
  /// return {task_tag}, {board}, {task}, {tag_rel}, {tag}, {color}
  Future<List<TypedResult>> getTaskTagListByProjectId({
    required String projectId,
  }) async {
    try {
      _logger.d('getTaskTagListByProjectId 通信開始');
      final query = db.select(db.tTaskTag);

      final response = await query.join([
        // board
        innerJoin(
            db.tBoard,
            db.tBoard.projectId.equals(projectId) &
                db.tBoard.boardId.equalsExp(db.tTask.boardId)),
        // task
        leftOuterJoin(db.tTask, db.tTask.taskId.equalsExp(db.tTaskTag.taskId)),
        // tag_rel
        leftOuterJoin(
          db.tTagRel,
          db.tTagRel.id.equalsExp(db.tTaskTag.tagRelId) &
              db.tTagRel.projectId.equals(projectId),
        ),
        // tag
        innerJoin(
          db.tTag,
          db.tTag.id.equalsExp(db.tTagRel.tagId),
        ),
        // カラー
        innerJoin(
          db.mColor,
          db.mColor.id.equalsExp(db.tTag.colorId),
        ),
      ]).get();

      _logger.d('取得データ：$response');
      _logger.d('length: ${response.length}');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getTaskTagListByProjectId 通信終了');
    }
  }

  /// タスクタグ 追加
  Future<void> insertTaskTag({
    required TTaskTagCompanion taskTagData,
  }) async {
    try {
      _logger.d('insertTaskTag 通信開始');
      _logger.d('taskTagData:  $taskTagData');
      await db.into(db.tTaskTag).insert(taskTagData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertTaskTag 通信終了');
    }
  }

  /// タスクタグ taskIdで削除
  Future<void> deleteTaskTagByTaskId({
    required String taskId,
  }) async {
    try {
      _logger.d('deleteTaskTagByTaskId 通信開始');
      _logger.d('taskId: $taskId');
      final query = db.delete(db.tTaskTag)
        ..where((tbl) => tbl.taskId.equals(taskId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteTaskTagByTaskId 通信終了');
    }
  }

  /// タスクタグ tagRelIdで削除
  Future<void> deleteTaskTagByTagRelId({
    required int tagRelId,
  }) async {
    try {
      _logger.d('deleteTaskTagByTagRelId 通信開始');
      _logger.d('tagRelId: $tagRelId');
      final query = db.delete(db.tTaskTag)
        ..where((tbl) => tbl.tagRelId.equals(tagRelId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteTaskTagByTagRelId 通信終了');
    }
  }
}
