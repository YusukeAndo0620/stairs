import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:stairs/loom/loom_package.dart' hide Row;

class TaskRepository {
  TaskRepository({required this.db});

  final StairsDatabase db;

  final _logger = stairsLogger(name: 'task_repository');

  /// タスク追加
  Future<void> addTask({required TaskItemModel taskItemModel}) async {
    _logger.i('addTask 開始');
    try {
      await db.transaction(() async {
        // タスク更新
        final taskData = _convertTaskToEntity(
          boardId: taskItemModel.boardId,
          taskItemId: taskItemModel.taskItemId,
          title: taskItemModel.title,
          description: taskItemModel.description,
          orderNo: taskItemModel.orderNo,
          startDate: taskItemModel.startDate,
          dueDate: taskItemModel.dueDate,
          endDate: taskItemModel.doneDate,
        );
        await db.tTaskDao.insertTask(taskData: taskData);

        // タスクに紐づく開発言語更新
        final taskDevData = _convertTaskDevToEntity(
          taskItemId: taskItemModel.taskItemId,
          devLangId: taskItemModel.devLangId,
        );
        await db.tTaskDevDao.insertTaskDev(taskDevData: taskDevData);

        // タスクに紐づくラベルを更新  insert
        for (final taskTag in taskItemModel.labelList) {
          await db.tTaskTagDao.insertTaskTag(
            taskTagData: _convertTaskTagToEntity(
              taskItemId: taskItemModel.taskItemId,
              tagRelId: int.parse(taskTag.id),
            ),
          );
        }
      });
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('addTask 終了');
    }
  }

  /// タスク更新
  Future<void> updateTask(
      {required TaskItemModel taskItemModel, required bool isUpdateTag}) async {
    _logger.i('updateTask 開始');
    try {
      await db.transaction(() async {
        // タスク更新
        final taskData = _convertTaskToEntity(
          boardId: taskItemModel.boardId,
          taskItemId: taskItemModel.taskItemId,
          title: taskItemModel.title,
          description: taskItemModel.description,
          orderNo: taskItemModel.orderNo,
          startDate: taskItemModel.startDate,
          dueDate: taskItemModel.dueDate,
          endDate: taskItemModel.doneDate,
        );
        await db.tTaskDao.updateTask(taskData: taskData);

        // タスクに紐づく開発言語更新
        final taskDevData = _convertTaskDevToEntity(
          taskItemId: taskItemModel.taskItemId,
          devLangId: taskItemModel.devLangId,
        );
        await db.tTaskDevDao.updateTaskDev(taskDevData: taskDevData);

        // タスクに紐づくラベルを更新 delete and insert
        if (isUpdateTag) {
          await db.tTaskTagDao
              .deleteTaskTagByTaskId(taskId: taskItemModel.taskItemId);
          for (final taskTag in taskItemModel.labelList) {
            await db.tTaskTagDao.insertTaskTag(
              taskTagData: _convertTaskTagToEntity(
                taskItemId: taskItemModel.taskItemId,
                tagRelId: int.parse(taskTag.id),
              ),
            );
          }
        }
      });
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('updateTask 終了');
    }
  }

  /// タスク表示用番号 更新
  Future<void> updateTaskOrderNo(
      {required List<TaskItemModel> taskItemModelList}) async {
    _logger.i('updateTaskOrderNo 開始');
    try {
      await db.transaction(
        () async {
          for (final task in taskItemModelList) {
            // タスク更新
            final taskData = _convertTaskToEntity(
              boardId: task.boardId,
              taskItemId: task.taskItemId,
              title: task.title,
              description: task.description,
              orderNo: task.orderNo,
              startDate: task.startDate,
              dueDate: task.dueDate,
              endDate: task.doneDate,
            );
            await db.tTaskDao.updateTask(taskData: taskData);
          }
        },
      );
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('updateTaskOrderNo 終了');
    }
  }

  // タスク model to entity
  TTaskCompanion _convertTaskToEntity({
    required String boardId,
    required String taskItemId,
    required String title,
    required String description,
    required int orderNo,
    required DateTime startDate,
    required DateTime dueDate,
    DateTime? endDate,
  }) {
    return TTaskCompanion(
      boardId: Value(boardId),
      taskId: Value(taskItemId),
      name: Value(title),
      description: Value(description),
      orderNo: Value(orderNo),
      startDate: Value(startDate.toIso8601String()),
      dueDate: Value(dueDate.toIso8601String()),
      endDate: endDate != null
          ? Value(endDate.toIso8601String())
          : const Value(null),
      updateAt: Value(
        DateTime.now().toIso8601String(),
      ),
    );
  }

  // タスクに紐づく開発言語  to entity
  TTaskDevCompanion _convertTaskDevToEntity({
    required String taskItemId,
    required String devLangId,
  }) {
    return TTaskDevCompanion(
      taskId: Value(taskItemId),
      devLangId: Value(devLangId),
    );
  }

  // タスクに紐づくラベル  to entity
  TTaskTagCompanion _convertTaskTagToEntity({
    required String taskItemId,
    required int tagRelId,
  }) {
    return TTaskTagCompanion(
      taskId: Value(taskItemId),
      tagRelId: Value(tagRelId),
    );
  }
}
