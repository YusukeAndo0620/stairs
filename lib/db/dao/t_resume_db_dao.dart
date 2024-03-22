import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_resume_db_dao.g.dart';

@DriftAccessor(tables: [TResumeDb])
class TResumeDbDao extends DatabaseAccessor<StairsDatabase>
    with _$TResumeDbDaoMixin {
  TResumeDbDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_resume_db_dao');

  /// 経歴書で設定されたDb紐付け取得
  Future<List<TypedResult>> getResumeDbList({
    required String resumeProjectId,
  }) async {
    try {
      _logger.d('getResumeDbList 通信開始');
      final query = db.select(db.tResumeDb)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      final response = await query.join([
        innerJoin(
          db.tDb,
          db.tResumeDb.dbId.equalsExp(db.tDb.dbId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getResumeDbList 通信終了');
    }
  }

  /// 経歴書 Db紐付け 追加
  Future<void> insertResumeDb({
    required TResumeDbCompanion resumeDbData,
  }) async {
    try {
      _logger.d('insertResumeDb 通信開始');
      _logger.d('resumeDbData: $resumeDbData');
      await db.into(db.tResumeDb).insert(resumeDbData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertResumeDb 通信終了');
    }
  }

  ///経歴書  Db紐付け 更新
  Future<void> updateResumeDb({
    required TResumeDbCompanion resumeDbData,
  }) async {
    try {
      _logger.d('updateResumeDb 通信開始');
      _logger.d('resumeDbData: $resumeDbData');
      await db.update(db.tResumeDb).replace(resumeDbData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateResumeDb 通信終了');
    }
  }

  /// 経歴書 Db紐付け resumeProjectId一致のもの全て削除
  Future<void> deleteResumeDbByProjectId(
      {required String resumeProjectId}) async {
    try {
      _logger.d('deleteResumeDbByProjectId 通信開始');
      _logger.d('resumeProjectId: $resumeProjectId');
      final query = db.delete(db.tResumeDb)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeDbByProjectId 通信終了');
    }
  }

  /// 経歴書 Db紐付け dbIdのもの全て削除
  Future<void> deleteResumeDbByDbId({required String dbId}) async {
    try {
      _logger.d('deleteResumeDbByDbId 通信開始');
      _logger.d('dbId: $dbId');
      final query = db.delete(db.tResumeDb)
        ..where((tbl) => tbl.dbId.equals(dbId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeDbByDbId 通信終了');
    }
  }

  // 経歴書 Db紐付け model to entity
  TResumeDbCompanion convertResumeDbToEntity({
    required String resumeProjectId,
    required String dbId,
  }) {
    return TResumeDbCompanion(
      dbId: Value(dbId),
      resumeProjectId: Value(resumeProjectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
