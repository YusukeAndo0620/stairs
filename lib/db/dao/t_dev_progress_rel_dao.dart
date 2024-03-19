import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_dev_progress_rel_dao.g.dart';

@DriftAccessor(tables: [TDevProgressRel])
class TDevProgressRelDao extends DatabaseAccessor<StairsDatabase>
    with _$TDevProgressRelDaoMixin {
  TDevProgressRelDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_dev_progress_rel_dao');

  /// プロジェクトで設定され開発工程取得
  Future<List<TDevProgressRelData>> getDevProgressList({
    required String projectId,
  }) async {
    try {
      _logger.d('getDevProgressList 通信開始');
      final query = db.select(db.tDevProgressRel)
        ..where((tbl) => tbl.projectId.equals(projectId));

      final response = await query.get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getDevProgressList 通信終了');
    }
  }

  /// 開発工程 追加
  Future<void> insertDevProgress({
    required TDevProgressRelCompanion devProgressData,
  }) async {
    try {
      _logger.d('insertDevProgress 通信開始');
      _logger.d('devProgressData: $devProgressData');
      await db.into(db.tDevProgressRel).insert(devProgressData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertDevProgress 通信終了');
    }
  }

  /// 開発工程 削除
  Future<void> deleteDevProgressByProjectId({
    required String projectId,
  }) async {
    try {
      _logger.d('deleteDevProgressByProjectId 通信開始');
      _logger.d('projectId: $projectId');
      final query = db.delete(db.tDevProgressRel)
        ..where((tbl) => tbl.projectId.equals(projectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteDevProgressByProjectId 通信終了');
    }
  }

  // Dev progress model to entity
  TDevProgressRelCompanion? convertDevProgressToEntity({
    required String projectId,
    required int devProgressId,
  }) {
    return TDevProgressRelCompanion(
      devProgressId: Value(devProgressId),
      projectId: Value(projectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
