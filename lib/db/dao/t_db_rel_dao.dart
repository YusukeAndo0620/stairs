import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_db_rel_dao.g.dart';

@DriftAccessor(tables: [TDbRel])
class TDbRelDao extends DatabaseAccessor<StairsDatabase> with _$TDbRelDaoMixin {
  TDbRelDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_db_rel_dao');

  /// プロジェクトで設定されたDB紐付け取得
  Future<List<TypedResult>> getDbRelList({
    required String projectId,
  }) async {
    try {
      _logger.d('getDbRelList 通信開始');
      final query = db.select(db.tDbRel)
        ..where((tbl) => tbl.projectId.equals(projectId));
      final response = await query.join([
        innerJoin(
          db.tDb,
          db.tDbRel.dbId.equalsExp(db.tDb.dbId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getDbRelList 通信終了');
    }
  }

  /// DB紐付け 追加
  Future<void> insertDbRel({
    required TDbRelCompanion dbRelData,
  }) async {
    try {
      _logger.d('insertDbRel 通信開始');
      _logger.d('dbRelData: $dbRelData');
      await db.into(db.tDbRel).insert(dbRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertDbRel 通信終了');
    }
  }

  /// DB紐付け 更新
  Future<void> updateDbRel({
    required TDbRelCompanion dbRelData,
  }) async {
    try {
      _logger.d('updateDbRel 通信開始');
      _logger.d('dbRelData: $dbRelData');
      await db.update(db.tDbRel).replace(dbRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateDbRel 通信終了');
    }
  }

  /// DB紐付け 削除
  Future<void> deleteDbRel({required int id}) async {
    try {
      _logger.d('deleteDbRel 通信開始');
      _logger.d('id: $id');
      final query = db.delete(db.tDbRel)..where((tbl) => tbl.id.equals(id));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteDbRel 通信終了');
    }
  }

  /// DB紐付け projectId一致のもの全て削除
  Future<void> deleteDbRelByProjectId({required String projectId}) async {
    try {
      _logger.d('deleteDbRelByProjectId 通信開始');
      _logger.d('projectId: $projectId');
      final query = db.delete(db.tDbRel)
        ..where((tbl) => tbl.projectId.equals(projectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteDbRelByProjectId 通信終了');
    }
  }

  /// DB紐付け DbIdのもの全て削除
  Future<void> deleteDbRelByDbId({required String dbId}) async {
    try {
      _logger.d('deleteDbRelByDbId 通信開始');
      _logger.d('dbId: $dbId');
      final query = db.delete(db.tDbRel)..where((tbl) => tbl.dbId.equals(dbId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteDbRelByDbId 通信終了');
    }
  }

  // DB紐付け model to entity
  TDbRelCompanion convertDbRelToEntity({
    required String projectId,
    required String dbId,
  }) {
    return TDbRelCompanion(
      dbId: Value(dbId),
      projectId: Value(projectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
