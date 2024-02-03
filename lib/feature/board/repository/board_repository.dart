import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/feature/board/model/board_model.dart';
import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:stairs/loom/loom_package.dart' hide Row;

class BoardRepository {
  BoardRepository({required this.db});

  final StairsDatabase db;

  final _logger = stairsLogger(name: 'board_repository');

  /// ボード一覧取得
  Future<List<BoardModel>> getBoardList({required String projectId}) async {
    try {
      _logger.i('getBoardList 開始');
      final response = await db.tBoardDao.getBoardList(projectId: projectId);

      _logger.i('取得データ：$response, length: ${response.length}');
      final List<BoardModel> responseData = [];
      for (final boardData in response) {
        // taskテーブルの情報
        final taskDataResponse =
            await db.tTaskDao.getTaskDetail(boardId: boardData.boardId);
        // task tagのタグ情報取得
        // {task_tag}, {tag_rel}, {tag}, {color}
        final List<TypedResult> taskTagResponseList = [];
        // task dev
        // {task_dev}, {dev_language}
        final List<TypedResult> taskDevResponseList = [];

        for (final task in taskDataResponse) {
          // タスクに紐づくタグを全て取得
          final tagResponse =
              await db.tTaskTagDao.getTaskTagList(taskId: task.taskId);
          taskTagResponseList.addAll(tagResponse);
          // タスクに紐づく開発言語を取得
          final devResponse =
              await db.tTaskDevDao.getTaskDevList(taskId: task.taskId);
          taskDevResponseList.addAll(devResponse);
        }

        responseData.add(
          _convertBoardEntityToModel(
            boardData: boardData,
            taskData: taskDataResponse,
            taskTagData: taskTagResponseList
                .map((e) => e.readTable(db.tTaskTag))
                .toList(),
            tagData:
                taskTagResponseList.map((e) => e.readTable(db.tTag)).toList(),
            tagColorData:
                taskTagResponseList.map((e) => e.readTable(db.mColor)).toList(),
            devData: taskDevResponseList
                .map((e) => e.readTable(db.tTaskDev))
                .toList(),
            devLangData: taskDevResponseList
                .map((e) => e.readTable(db.tDevLanguage))
                .toList(),
          ),
        );
      }

      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getProjectList 終了');
    }
  }

  /// ボード詳細取得
  Future<BoardModel?> getBoardDetail({
    required String boardId,
  }) async {
    try {
      _logger.i('getBoardDetail 開始');

      // 詳細
      final detailResponse =
          await db.tBoardDao.getBoardDetail(boardId: boardId);
      // taskテーブルの情報
      final taskDataResponse =
          await db.tTaskDao.getTaskDetail(boardId: detailResponse.boardId);
      // task tagのタグ情報取得
      // {task_tag}, {tag_rel}, {tag}, {color}
      final List<TypedResult> taskTagResponseList = [];
      // task dev
      // {task_dev}, {dev_language}
      final List<TypedResult> taskDevResponseList = [];

      for (final task in taskDataResponse) {
        // タスクに紐づくタグを全て取得
        final tagResponse =
            await db.tTaskTagDao.getTaskTagList(taskId: task.taskId);
        taskTagResponseList.addAll(tagResponse);
        // タスクに紐づく開発言語を取得
        final devResponse =
            await db.tTaskDevDao.getTaskDevList(taskId: task.taskId);
        taskDevResponseList.addAll(devResponse);
      }

      return _convertBoardEntityToModel(
        boardData: detailResponse,
        taskData: taskDataResponse,
        taskTagData:
            taskTagResponseList.map((e) => e.readTable(db.tTaskTag)).toList(),
        tagData: taskTagResponseList.map((e) => e.readTable(db.tTag)).toList(),
        tagColorData:
            taskTagResponseList.map((e) => e.readTable(db.mColor)).toList(),
        devData:
            taskDevResponseList.map((e) => e.readTable(db.tTaskDev)).toList(),
        devLangData: taskTagResponseList
            .map((e) => e.readTable(db.tDevLanguage))
            .toList(),
      );
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getBoardDetail 終了');
    }
  }

  /// ボード作成
  Future<void> createBoard({required BoardModel boardModel}) async {
    try {
      _logger.i('createBoard 開始');
      _logger.i('projectId: ${boardModel.projectId}');
      _logger.i('boardId: ${boardModel.boardId}');
      final boardData = _convertBoardModelToEntity(boardModel: boardModel);
      // プロジェクト作成
      await db.tBoardDao.insertBoard(boardData: boardData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('createBoard 終了');
    }
  }

// ボード entity to model
  BoardModel _convertBoardEntityToModel({
    required TBoardData boardData,
    required List<TTaskData> taskData,
    required List<TTaskTagData> taskTagData,
    required List<TTagData> tagData,
    required List<MColorData> tagColorData,
    required List<TTaskDevData> devData,
    required List<TDevLanguageData> devLangData,
  }) {
    // タスクリスト
    final List<TaskItemModel> taskList = [];

    // タグ情報のMap {key: task_id, value: ColorLabelModel(tag)}
    final Map<String, List<ColorLabelModel>> tagMap = {};

    // 開発言語のMap {key: task_id, value: 言語名}
    final Map<String, String> devMap = {};

    for (var i = 0; i < taskTagData.length; i++) {
      // 追加するタグの情報
      final tag = ColorLabelModel(
        id: tagData[i].id.toString(),
        labelName: tagData[i].name,
        isReadOnly: tagData[i].isReadOnly,
        colorModel: ColorModel(
            id: tagColorData[i].id,
            color: getColorFromCode(code: tagColorData[i].colorCodeId)),
      );

      if (tagMap.containsKey(taskTagData[i].taskId)) {
        tagMap[taskTagData[i].taskId]!.add(tag);
      } else {
        tagMap[taskTagData[i].taskId] = [tag];
      }
    }

    // タスクに設定されている開発言語
    for (var i = 0; i < devData.length; i++) {
      devMap[devData[i].taskId] = devLangData[i].name;
    }

    for (var i = 0; i < taskData.length; i++) {
      final taskItem = TaskItemModel(
        boardId: boardData.boardId,
        taskItemId: taskData[i].taskId,
        title: taskData[i].name,
        description: taskData[i].description,
        devLangName: devMap[taskData[i].taskId],
        startDate: DateTime.parse(taskData[i].startDate).toLocal(),
        doneDate: taskData[i].endDate != null
            ? DateTime.parse(taskData[i].endDate!).toLocal()
            : null,
        dueDate: DateTime.parse(taskData[i].dueDate).toLocal(),
        labelList: tagMap[taskData[i].taskId] ?? [],
      );
      taskList.add(taskItem);
    }

    return BoardModel(
        projectId: boardData.projectId,
        boardId: boardData.boardId,
        title: boardData.name,
        taskItemList: taskList);
  }

// プロジェクト詳細 model to entity
  TBoardCompanion _convertBoardModelToEntity({
    required BoardModel boardModel,
  }) {
    return TBoardCompanion(
      projectId: Value(boardModel.projectId),
      boardId: Value(boardModel.boardId),
      name: Value(boardModel.title),
      isCompleted: const Value(false),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
