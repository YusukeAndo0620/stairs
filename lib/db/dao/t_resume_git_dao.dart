import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_resume_git_dao.g.dart';

@DriftAccessor(tables: [TResumeGit])
class TResumeGitDao extends DatabaseAccessor<StairsDatabase>
    with _$TResumeGitDaoMixin {
  TResumeGitDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_resume_git_dao');

  /// 経歴書で設定されたGit紐付け取得
  Future<List<TypedResult>> getResumeGitList({
    required String resumeProjectId,
  }) async {
    try {
      _logger.d('getResumeGitList 通信開始');
      final query = db.select(db.tResumeGit)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      final response = await query.join([
        innerJoin(
          db.tGit,
          db.tResumeGit.gitId.equalsExp(db.tGit.gitId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getResumeGitList 通信終了');
    }
  }

  /// 経歴書 Git紐付け 追加
  Future<void> insertResumeGit({
    required TResumeGitCompanion resumeGitData,
  }) async {
    try {
      _logger.d('insertResumeGit 通信開始');
      _logger.d('resumeGitData: $resumeGitData');
      await db.into(db.tResumeGit).insert(resumeGitData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertResumeGit 通信終了');
    }
  }

  ///経歴書  Git紐付け 更新
  Future<void> updateResumeGit({
    required TResumeGitCompanion resumeGitData,
  }) async {
    try {
      _logger.d('updateResumeGit 通信開始');
      _logger.d('resumeGitData: $resumeGitData');
      await db.update(db.tResumeGit).replace(resumeGitData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateResumeGit 通信終了');
    }
  }

  /// 経歴書 Git紐付け resumeProjectId一致のもの全て削除
  Future<void> deleteResumeGitByProjectId(
      {required String resumeProjectId}) async {
    try {
      _logger.d('deleteResumeGitByProjectId 通信開始');
      _logger.d('resumeProjectId: $resumeProjectId');
      final query = db.delete(db.tResumeGit)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeGitByProjectId 通信終了');
    }
  }

  /// 経歴書 Git紐付け gitIdのもの全て削除
  Future<void> deleteResumeGitByGitId({required String gitId}) async {
    try {
      _logger.d('deleteResumeGitByGitId 通信開始');
      _logger.d('gitId: $gitId');
      final query = db.delete(db.tResumeGit)
        ..where((tbl) => tbl.gitId.equals(gitId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeGitByGitId 通信終了');
    }
  }

  // 経歴書 Git紐付け model to entity
  TResumeGitCompanion convertResumeGitToEntity({
    required String resumeProjectId,
    required String gitId,
  }) {
    return TResumeGitCompanion(
      gitId: Value(gitId),
      resumeProjectId: Value(resumeProjectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
