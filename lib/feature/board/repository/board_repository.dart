import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/feature/board/model/board_model.dart';
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
      for (final row in response) {
        final boardData = row.readTable(db.tBoard);
        // task, task tag, task dev
        final taskDataResponse =
            await db.tTaskDao.getTaskDetail(boardId: boardData.boardId);
        final List<TypedResult> tagResponseList = [];

        // タスクに紐づくタグを全て取得
        for (final tagRow in taskDataResponse) {
          final tagResponse = await db.tTagRelDao.getTagWithTagId(
              projectId: boardData.boardId,
              tagId: tagRow.readTable(db.tTaskTag).tagId);
          tagResponseList.add(tagResponse);
        }

        responseData.add(
          _convertBoardEntityToModel(
            boardData: row.readTable(db.tBoard),
            tagData: tagResponseList.map((e) => e.readTable(db.tTag)).toList(),
            tagRelData:
                tagResponseList.map((e) => e.readTable(db.tTagRel)).toList(),
            colorData:
                tagResponseList.map((e) => e.readTable(db.mColor)).toList(),
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
      final response = await db.tBoardDao.getBoardDetail(boardId: boardId);
      if (response.isEmpty) return null;
      final detailResponse = response[0].readTable(db.tBoard);
      // task, task tag, task dev
      final taskDataResponse =
          await db.tTaskDao.getTaskDetail(boardId: detailResponse.boardId);

      // tag rel, tag, color
      final List<TypedResult> tagResponseList = [];
      // タスクに紐づくタグを全て取得
      for (final tagRow in taskDataResponse) {
        final tagResponse = await db.tTagRelDao.getTagWithTagId(
            projectId: detailResponse.boardId,
            tagId: tagRow.readTable(db.tTaskTag).tagId);
        tagResponseList.add(tagResponse);
      }
      return _convertBoardEntityToModel(
        boardData: detailResponse,
        tagData: tagResponseList.map((e) => e.readTable(db.tTag)).toList(),
        tagRelData:
            tagResponseList.map((e) => e.readTable(db.tTagRel)).toList(),
        colorData: tagResponseList.map((e) => e.readTable(db.mColor)).toList(),
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
    required List<TTagData> tagData,
    required List<TTagRelData> tagRelData,
    required List<MColorData> colorData,
  }) {
    // タグリスト
    final List<ColorLabelModel> tagList = [];
    for (var i = 0; i < tagRelData.length; i++) {
      tagList.add(
        ColorLabelModel(
          id: tagData[i].id.toString(),
          labelName: tagData[i].name,
          isReadOnly: tagData[i].isReadOnly,
          colorModel: ColorModel(
              id: colorData[i].id,
              color: getColorFromCode(code: colorData[i].colorCodeId)),
        ),
      );
    }

    return BoardModel(
        projectId: boardData.projectId,
        boardId: boardData.boardId,
        title: boardData.name,
        taskItemList: []);
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
