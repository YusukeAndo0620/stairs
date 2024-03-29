import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_tool_dao.g.dart';

@DriftAccessor(tables: [TTool])
class TToolDao extends DatabaseAccessor<StairsDatabase> with _$TToolDaoMixin {
  TToolDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_tool_dao');

  /// プロジェクトで設定されたツール取得
  Future<List<TToolData>> getToolList({
    required String accountId,
  }) async {
    try {
      _logger.d('getToolList 通信開始');
      final query = db.select(db.tTool)
        ..where((tbl) => tbl.accountId.equals(accountId));
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
      _logger.d('toolData: $toolData');
      await db.into(db.tTool).insert(toolData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertTool 通信終了');
    }
  }

  /// ツール 更新
  Future<void> updateTool({
    required TToolCompanion toolData,
  }) async {
    try {
      _logger.d('updateTool 通信開始');
      _logger.d('toolData: $toolData');
      await db.update(db.tTool).replace(toolData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateTool 通信終了');
    }
  }

  /// ツール 削除
  Future<void> deleteTool({
    required String accountId,
    required String toolId,
  }) async {
    try {
      _logger.d('deleteTool 通信開始');
      _logger.d('accountId: $accountId');
      _logger.d('toolId: $toolId');
      final query = db.delete(db.tTool)
        ..where((tbl) =>
            tbl.accountId.equals(accountId) & tbl.toolId.equals(toolId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteTool 通信終了');
    }
  }

  // Tool model to entity
  TToolCompanion convertToolToEntity({
    required String accountId,
    required LabelModel model,
  }) {
    return TToolCompanion(
      toolId: Value(model.id),
      name: Value(model.labelName),
      accountId: Value(accountId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
