import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_tool_rel_dao.g.dart';

@DriftAccessor(tables: [TToolRel])
class TToolRelDao extends DatabaseAccessor<StairsDatabase>
    with _$TToolRelDaoMixin {
  TToolRelDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_tool_rel_dao');

  /// プロジェクトで設定されたTool紐付け取得
  Future<List<TypedResult>> getToolRelList({
    required String projectId,
  }) async {
    try {
      _logger.d('getToolRelList 通信開始');
      final query = db.select(db.tToolRel)
        ..where((tbl) => tbl.projectId.equals(projectId));
      final response = await query.join([
        innerJoin(
          db.tTool,
          db.tToolRel.toolId.equalsExp(db.tTool.toolId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getToolRelList 通信終了');
    }
  }

  /// Tool紐付け 追加
  Future<void> insertToolRel({
    required TToolRelCompanion toolRelData,
  }) async {
    try {
      _logger.d('insertToolRel 通信開始');
      _logger.d('toolRelData: $toolRelData');
      await db.into(db.tToolRel).insert(toolRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertToolRel 通信終了');
    }
  }

  /// Tool紐付け 更新
  Future<void> updateToolRel({
    required TToolRelCompanion toolRelData,
  }) async {
    try {
      _logger.d('updateToolRel 通信開始');
      _logger.d('toolRelData: $toolRelData');
      await db.update(db.tToolRel).replace(toolRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateToolRel 通信終了');
    }
  }

  /// Tool紐付け 削除
  Future<void> deleteToolRel({required int id}) async {
    try {
      _logger.d('deleteToolRel 通信開始');
      _logger.d('id: $id');
      final query = db.delete(db.tToolRel)..where((tbl) => tbl.id.equals(id));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteToolRel 通信終了');
    }
  }

  /// Tool紐付け projectId一致のもの全て削除
  Future<void> deleteToolRelByProjectId({required String projectId}) async {
    try {
      _logger.d('deleteToolRelByProjectId 通信開始');
      _logger.d('projectId: $projectId');
      final query = db.delete(db.tToolRel)
        ..where((tbl) => tbl.projectId.equals(projectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteToolRelByProjectId 通信終了');
    }
  }

  /// Tool紐付け toolIdのもの全て削除
  Future<void> deleteToolRelByToolId({required String toolId}) async {
    try {
      _logger.d('deleteToolRelByToolId 通信開始');
      _logger.d('toolId: $toolId');
      final query = db.delete(db.tToolRel)
        ..where((tbl) => tbl.toolId.equals(toolId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteToolRelByToolId 通信終了');
    }
  }

  // Tool紐付け model to entity
  TToolRelCompanion convertToolRelToEntity({
    required String projectId,
    required String toolId,
  }) {
    return TToolRelCompanion(
      toolId: Value(toolId),
      projectId: Value(projectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
