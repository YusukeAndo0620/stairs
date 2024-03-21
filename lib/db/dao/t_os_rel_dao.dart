import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_os_rel_dao.g.dart';

@DriftAccessor(tables: [TOsRel])
class TOsRelDao extends DatabaseAccessor<StairsDatabase> with _$TOsRelDaoMixin {
  TOsRelDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_os_rel_dao');

  /// プロジェクトで設定されたOS紐付け取得
  Future<List<TypedResult>> getOsRelList({
    required String projectId,
  }) async {
    try {
      _logger.d('getOsRelList 通信開始');
      final query = db.select(db.tOsRel)
        ..where((tbl) => tbl.projectId.equals(projectId));
      final response = await query.join([
        innerJoin(
          db.tOsInfo,
          db.tOsRel.osId.equalsExp(db.tOsInfo.osId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getOsRelList 通信終了');
    }
  }

  /// OS紐付け 追加
  Future<void> insertOsRel({
    required TOsRelCompanion osRelData,
  }) async {
    try {
      _logger.d('insertOsRel 通信開始');
      _logger.d('osRelData: $osRelData');
      await db.into(db.tOsRel).insert(osRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertOsRel 通信終了');
    }
  }

  /// OS紐付け 更新
  Future<void> updateOsRel({
    required TOsRelCompanion osRelData,
  }) async {
    try {
      _logger.d('updateOsRel 通信開始');
      _logger.d('osRelData: $osRelData');
      await db.update(db.tOsRel).replace(osRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateOsRel 通信終了');
    }
  }

  /// OS紐付け 削除
  Future<void> deleteOsRel({required int id}) async {
    try {
      _logger.d('deleteOsRel 通信開始');
      _logger.d('id: $id');
      final query = db.delete(db.tOsRel)..where((tbl) => tbl.id.equals(id));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteOsRel 通信終了');
    }
  }

  /// OS紐付け projectId一致のもの全て削除
  Future<void> deleteOsRelByProjectId({required String projectId}) async {
    try {
      _logger.d('deleteOsRelByProjectId 通信開始');
      _logger.d('projectId: $projectId');
      final query = db.delete(db.tOsRel)
        ..where((tbl) => tbl.projectId.equals(projectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteOsRelByProjectId 通信終了');
    }
  }

  /// OS紐付け osIdのもの全て削除
  Future<void> deleteOsRelByOsId({required String osId}) async {
    try {
      _logger.d('deleteOsRelByOsId 通信開始');
      _logger.d('osId: $osId');
      final query = db.delete(db.tOsRel)..where((tbl) => tbl.osId.equals(osId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteOsRelByOsId 通信終了');
    }
  }

  // OS紐付け model to entity
  TOsRelCompanion convertOsRelToEntity({
    required String projectId,
    required String osId,
  }) {
    return TOsRelCompanion(
      osId: Value(osId),
      projectId: Value(projectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
