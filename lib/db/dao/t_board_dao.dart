import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/stairs_logger.dart';

part 't_board_dao.g.dart';

@DriftAccessor(tables: [TBoard])
class TBoardDao extends DatabaseAccessor<StairsDatabase> with _$TBoardDaoMixin {
  TBoardDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_board_dao');

  /// ボード一覧取得
  Future<List<TBoardData>> getBoardList({required String projectId}) async {
    try {
      _logger.d('getBoardList 通信開始');
      final listQuery = db.select(db.tBoard)
        ..where((tbl) => tbl.projectId.equals(projectId));
      final response = await listQuery.get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getBoardList 通信終了');
    }
  }

  /// ボード詳細取得
  Future<TBoardData> getBoardDetail({
    required String boardId,
  }) async {
    try {
      _logger.d('getBoardDetail 通信開始');
      // 詳細取得クエリ
      final detailQuery = db.select(db.tBoard)
        ..where((tbl) => tbl.boardId.equals(boardId));
      // 詳細
      final response = await detailQuery.getSingle();

      _logger.d('取得データ：$response');

      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getBoardDetail 通信終了');
    }
  }

  /// ボード 追加
  Future<void> insertBoard({
    required TBoardCompanion boardData,
  }) async {
    try {
      _logger.d('insertBoard 通信開始');
      _logger.d('boardData:  $boardData');
      await db.into(db.tBoard).insert(boardData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertBoard 通信終了');
    }
  }

  /// ボード 更新
  Future<void> updateBoard({
    required TBoardCompanion boardData,
  }) async {
    try {
      _logger.d('updateBoard 通信開始');
      _logger.d('boardData:  $boardData');
      await db.update(db.tBoard).replace(boardData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateBoard 通信終了');
    }
  }

  /// ボード 削除
  Future<void> deleteBoardById({
    required String boardId,
  }) async {
    try {
      _logger.d('deleteBoardById 通信開始');
      _logger.d('boardId: $boardId');
      final query = db.delete(db.tBoard)
        ..where((tbl) => tbl.boardId.equals(boardId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteBoardById 通信終了');
    }
  }
}
