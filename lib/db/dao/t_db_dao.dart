import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_db_dao.g.dart';

@DriftAccessor(tables: [TDb])
class TDbDao extends DatabaseAccessor<StairsDatabase> with _$TDbDaoMixin {
  TDbDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_db_dao');

  /// プロジェクトで設定されたDB取得
  Future<List<TDbData>> getDbList({
    required String projectId,
  }) async {
    try {
      _logger.d('getDbList 通信開始');
      final query = db.select(db.tDb)
        ..where((tbl) => tbl.projectId.equals(projectId));
      final response = await query.get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getDbList 通信終了');
    }
  }

  /// DB 追加
  Future<void> insertDb({
    required TDbCompanion dbData,
  }) async {
    try {
      _logger.d('insertDb 通信開始');
      _logger.d('dbData: $dbData');
      await db.into(db.tDb).insert(dbData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertDb 通信終了');
    }
  }

  /// DB 更新
  Future<void> updateDb({
    required TDbCompanion dbData,
  }) async {
    try {
      _logger.d('updateDb 通信開始');
      _logger.d('dbData: $dbData');
      await db.update(db.tDb).replace(dbData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateDb 通信終了');
    }
  }

  /// DB 削除
  Future<void> deleteDbByProjectId({
    required String projectId,
  }) async {
    try {
      _logger.d('deleteDbByProjectId 通信開始');
      _logger.d('projectId: $projectId');
      final query = db.delete(db.tDb)
        ..where((tbl) => tbl.projectId.equals(projectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteDbByProjectId 通信終了');
    }
  }

  // DB model to entity
  TDbCompanion convertDbToEntity({
    required String projectId,
    required LabelModel model,
  }) {
    return TDbCompanion(
      dbId: Value(model.id),
      name: Value(model.labelName),
      projectId: Value(projectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
