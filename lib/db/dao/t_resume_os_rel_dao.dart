import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_resume_os_rel_dao.g.dart';

@DriftAccessor(tables: [TResumeOsRel])
class TResumeOsRelDao extends DatabaseAccessor<StairsDatabase>
    with _$TResumeOsRelDaoMixin {
  TResumeOsRelDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_resume_os_rel_dao');

  /// 経歴書で設定されたOS紐付け取得
  Future<List<TypedResult>> getResumeOsRelList({
    required String resumeProjectId,
  }) async {
    try {
      _logger.d('getResumeOsRelList 通信開始');
      final query = db.select(db.tResumeOsRel)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      final response = await query.join([
        innerJoin(
          db.tOsInfo,
          db.tResumeOsRel.osId.equalsExp(db.tOsInfo.osId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getResumeOsRelList 通信終了');
    }
  }

  /// 経歴書 OS紐付け 追加
  Future<void> insertResumeOsRel({
    required TResumeOsRelCompanion resumeProjectOsRelData,
  }) async {
    try {
      _logger.d('insertResumeOsRel 通信開始');
      _logger.d('resumeProjectOsRelData: $resumeProjectOsRelData');
      await db.into(db.tResumeOsRel).insert(resumeProjectOsRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertResumeOsRel 通信終了');
    }
  }

  /// 経歴書 OS紐付け 更新
  Future<void> updateResumeOsRel({
    required TResumeOsRelCompanion resumeProjectOsRelData,
  }) async {
    try {
      _logger.d('updateResumeOsRel 通信開始');
      _logger.d('resumeProjectOsRelData: $resumeProjectOsRelData');
      await db.update(db.tResumeOsRel).replace(resumeProjectOsRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateResumeOsRel 通信終了');
    }
  }

  /// 経歴書 OS紐付け resumeProjectId一致のもの全て削除
  Future<void> deleteResumeOsByProjectId(
      {required String resumeProjectId}) async {
    try {
      _logger.d('deleteResumeOsByProjectId 通信開始');
      _logger.d('resumeProjectId: $resumeProjectId');
      final query = db.delete(db.tResumeOsRel)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeOsByProjectId 通信終了');
    }
  }

  /// 経歴書 OS紐付け osIdのもの全て削除
  Future<void> deleteResumeOsByOsId({required String osId}) async {
    try {
      _logger.d('deleteResumeOsByOsId 通信開始');
      _logger.d('osId: $osId');
      final query = db.delete(db.tResumeOsRel)
        ..where((tbl) => tbl.osId.equals(osId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeOsByOsId 通信終了');
    }
  }

  // 経歴書 OS紐付け model to entity
  TResumeOsRelCompanion convertResumeOsRelToEntity({
    required String resumeProjectId,
    required String osId,
  }) {
    return TResumeOsRelCompanion(
      osId: Value(osId),
      resumeProjectId: Value(resumeProjectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
