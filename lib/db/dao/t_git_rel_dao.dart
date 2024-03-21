import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_git_rel_dao.g.dart';

@DriftAccessor(tables: [TGitRel])
class TGitRelDao extends DatabaseAccessor<StairsDatabase>
    with _$TGitRelDaoMixin {
  TGitRelDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_git_rel_dao');

  /// プロジェクトで設定されたGit紐付け取得
  Future<List<TypedResult>> getGitRelList({
    required String projectId,
  }) async {
    try {
      _logger.d('getGitRelList 通信開始');
      final query = db.select(db.tGitRel)
        ..where((tbl) => tbl.projectId.equals(projectId));
      final response = await query.join([
        innerJoin(
          db.tGit,
          db.tGitRel.gitId.equalsExp(db.tGit.gitId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getGitRelList 通信終了');
    }
  }

  /// Git紐付け 追加
  Future<void> insertGitRel({
    required TGitRelCompanion gitRelData,
  }) async {
    try {
      _logger.d('insertGitRel 通信開始');
      _logger.d('gitRelData: $gitRelData');
      await db.into(db.tGitRel).insert(gitRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertGitRel 通信終了');
    }
  }

  /// Git紐付け 更新
  Future<void> updateGitRel({
    required TGitRelCompanion gitRelData,
  }) async {
    try {
      _logger.d('updateGitRel 通信開始');
      _logger.d('gitRelData: $gitRelData');
      await db.update(db.tGitRel).replace(gitRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateGitRel 通信終了');
    }
  }

  /// Git紐付け 削除
  Future<void> deleteGitRel({required int id}) async {
    try {
      _logger.d('deleteGitRel 通信開始');
      _logger.d('id: $id');
      final query = db.delete(db.tGitRel)..where((tbl) => tbl.id.equals(id));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteGitRel 通信終了');
    }
  }

  /// Git紐付け projectId一致のもの全て削除
  Future<void> deleteGitRelByProjectId({required String projectId}) async {
    try {
      _logger.d('deleteGitRelByProjectId 通信開始');
      _logger.d('projectId: $projectId');
      final query = db.delete(db.tGitRel)
        ..where((tbl) => tbl.projectId.equals(projectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteGitRelByProjectId 通信終了');
    }
  }

  /// Git紐付け gitIdのもの全て削除
  Future<void> deleteGitRelByGitId({required String gitId}) async {
    try {
      _logger.d('deleteGitRelByGitId 通信開始');
      _logger.d('gitId: $gitId');
      final query = db.delete(db.tGitRel)
        ..where((tbl) => tbl.gitId.equals(gitId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteGitRelByGitId 通信終了');
    }
  }

  // Git紐付け model to entity
  TGitRelCompanion convertGitRelToEntity({
    required String projectId,
    required String gitId,
  }) {
    return TGitRelCompanion(
      gitId: Value(gitId),
      projectId: Value(projectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
