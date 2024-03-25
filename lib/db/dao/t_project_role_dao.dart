import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_project_role_dao.g.dart';

@DriftAccessor(tables: [TProjectRole])
class TProjectRoleDao extends DatabaseAccessor<StairsDatabase>
    with _$TProjectRoleDaoMixin {
  TProjectRoleDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_project_role_dao');

  /// プロジェクトで設定された役割取得
  Future<List<TProjectRoleData>> getProjectRoleList({
    required String projectId,
  }) async {
    try {
      _logger.d('getProjectRoleList 通信開始');
      final query = db.select(db.tProjectRole)
        ..where((tbl) => tbl.projectId.equals(projectId));
      final response = await query.get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getProjectRoleList 通信終了');
    }
  }

  /// プロジェクト 役割 追加
  Future<void> insertProjectRole({
    required TProjectRoleCompanion resumeRoleData,
  }) async {
    try {
      _logger.d('insertProjectRole 通信開始');
      _logger.d('resumeRoleData: $resumeRoleData');
      await db.into(db.tProjectRole).insert(resumeRoleData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertProjectRole 通信終了');
    }
  }

  ///プロジェクト 役割 更新
  Future<void> updateProjectRole({
    required TProjectRoleCompanion resumeRoleData,
  }) async {
    try {
      _logger.d('updateProjectRole 通信開始');
      _logger.d('resumeRoleData: $resumeRoleData');
      await db.update(db.tProjectRole).replace(resumeRoleData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateProjectRole 通信終了');
    }
  }

  /// プロジェクト 役割 projectId一致のもの全て削除
  Future<void> deleteProjectRoleByProjectId({required String projectId}) async {
    try {
      _logger.d('deleteProjectRoleByProjectId 通信開始');
      _logger.d('projectId: $projectId');
      final query = db.delete(db.tProjectRole)
        ..where((tbl) => tbl.projectId.equals(projectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteProjectRoleByProjectId 通信終了');
    }
  }

  // プロジェクト 役割 model to entity
  TProjectRoleCompanion convertProjectRoleToEntity({
    required String projectId,
    required int code,
  }) {
    return TProjectRoleCompanion(
      code: Value(code),
      projectId: Value(projectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
