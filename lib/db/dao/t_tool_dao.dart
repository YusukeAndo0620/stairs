import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/stairs_logger.dart';

part 't_tool_dao.g.dart';

@DriftAccessor(tables: [TTool])
class TToolDao extends DatabaseAccessor<StairsDatabase> with _$TToolDaoMixin {
  TToolDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_tool_dao');

  /// プロジェクトで設定されたツール取得
  Future<List<TToolData>> getToolList({
    required String projectId,
  }) async {
    try {
      _logger.d('getToolList 通信開始');
      final query = db.select(db.tTool)
        ..where((tbl) => tbl.projectId.equals(projectId));
      final response = await query.get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getToolList 通信終了');
    }
  }

  /// ツール 追加
  Future<void> insertTool({
    required TToolCompanion toolData,
  }) async {
    try {
      _logger.d('insertTool 通信開始');
      _logger.d('toolData:  $toolData');
      await db.into(db.tTool).insert(toolData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertTool 通信終了');
    }
  }

  /// ツール 削除
  Future<void> deleteToolByProjectId({
    required String projectId,
  }) async {
    try {
      _logger.d('deleteToolByProjectId 通信開始');
      _logger.d('projectId: $projectId');
      final query = db.delete(db.tTool)
        ..where((tbl) => tbl.projectId.equals(projectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteToolByProjectId 通信終了');
    }
  }
}
