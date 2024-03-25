import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_resume_dev_progress_dao.g.dart';

@DriftAccessor(tables: [TResumeDevProgressList])
class TResumeDevProgressDao extends DatabaseAccessor<StairsDatabase>
    with _$TResumeDevProgressDaoMixin {
  TResumeDevProgressDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_resume_dev_progress_dao');

  /// 経歴書で設定された開発工程紐付け取得
  Future<List<TypedResult>> getResumeDevProgressList({
    required String resumeProjectId,
  }) async {
    try {
      _logger.d('getResumeDevProgressList 通信開始');
      final query = db.select(db.tResumeDevProgressList)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      final response = await query.join([
        innerJoin(
          db.mDevProgressList,
          db.mDevProgressList.id
              .equalsExp(db.tResumeDevProgressList.devProgressId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getResumeDevProgressList 通信終了');
    }
  }

  /// 経歴書 開発工程紐付け 追加
  Future<void> insertResumeDevProgress({
    required TResumeDevProgressListCompanion resumeGitData,
  }) async {
    try {
      _logger.d('insertResumeDevProgress 通信開始');
      _logger.d('resumeGitData: $resumeGitData');
      await db.into(db.tResumeDevProgressList).insert(resumeGitData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertResumeDevProgress 通信終了');
    }
  }

  ///経歴書  開発工程紐付け 更新
  Future<void> updateResumeDevProgress({
    required TResumeDevProgressListCompanion resumeGitData,
  }) async {
    try {
      _logger.d('updateResumeDevProgress 通信開始');
      _logger.d('resumeGitData: $resumeGitData');
      await db.update(db.tResumeDevProgressList).replace(resumeGitData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateResumeDevProgress 通信終了');
    }
  }

  /// 経歴書 開発工程紐付け resumeProjectId一致のもの全て削除
  Future<void> deleteResumeDevProgressByProjectId(
      {required String resumeProjectId}) async {
    try {
      _logger.d('deleteResumeDevProgressByProjectId 通信開始');
      _logger.d('resumeProjectId: $resumeProjectId');
      final query = db.delete(db.tResumeDevProgressList)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeDevProgressByProjectId 通信終了');
    }
  }

  /// 経歴書 開発工程紐付け devProgressIdのもの全て削除
  Future<void> deleteResumeDevProgressByDevProgressId(
      {required int devProgressId}) async {
    try {
      _logger.d('deleteResumeDevProgressByGitId 通信開始');
      _logger.d('devProgressId: $devProgressId');
      final query = db.delete(db.tResumeDevProgressList)
        ..where((tbl) => tbl.devProgressId.equals(devProgressId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeDevProgressByGitId 通信終了');
    }
  }

  // 経歴書 開発工程紐付け model to entity
  TResumeDevProgressListCompanion convertResumeDevProgressToEntity({
    required String resumeProjectId,
    required int devProgressId,
  }) {
    return TResumeDevProgressListCompanion(
      devProgressId: Value(devProgressId),
      resumeProjectId: Value(resumeProjectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
