import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_os_info_dao.g.dart';

@DriftAccessor(tables: [TOsInfo])
class TOsInfoDao extends DatabaseAccessor<StairsDatabase>
    with _$TOsInfoDaoMixin {
  TOsInfoDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_os_info_dao');

  /// プロジェクトで設定されたOS取得
  Future<List<TOsInfoData>> getOsList({
    required String projectId,
  }) async {
    try {
      _logger.d('getOsList 通信開始');
      _logger.d('projectId: $projectId');
      final query = db.select(db.tOsInfo)
        ..where((tbl) => tbl.projectId.equals(projectId));
      final response = await query.get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getOsList 通信終了');
    }
  }

  /// OS 追加
  Future<void> insertOs({
    required TOsInfoCompanion osData,
  }) async {
    try {
      _logger.d('insertOs 通信開始');
      _logger.d('osData: $osData');
      await db.into(db.tOsInfo).insert(osData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertOs 通信終了');
    }
  }

  /// OS 更新
  Future<void> updateOs({
    required TOsInfoCompanion osData,
  }) async {
    try {
      _logger.d('updateOs 通信開始');
      _logger.d('osData: $osData');
      await db.update(db.tOsInfo).replace(osData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateOs 通信終了');
    }
  }

  /// OS 削除
  Future<void> deleteOsByProjectId({
    required String projectId,
  }) async {
    try {
      _logger.d('deleteOsByProjectId 通信開始');
      _logger.d('projectId: $projectId');
      final query = db.delete(db.tOsInfo)
        ..where((tbl) => tbl.projectId.equals(projectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteOsByProjectId 通信終了');
    }
  }

  // OS model to entity
  TOsInfoCompanion convertOsToEntity({
    required String projectId,
    required LabelModel model,
  }) {
    return TOsInfoCompanion(
      osId: Value(model.id),
      name: Value(model.labelName),
      projectId: Value(projectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
