import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_resume_mw_dao.g.dart';

@DriftAccessor(tables: [TResumeMw])
class TResumeMwDao extends DatabaseAccessor<StairsDatabase>
    with _$TResumeMwDaoMixin {
  TResumeMwDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_resume_mw_dao');

  /// 経歴書で設定されたMw紐付け取得
  Future<List<TypedResult>> getResumeMwList({
    required String resumeProjectId,
  }) async {
    try {
      _logger.d('getResumeMwList 通信開始');
      final query = db.select(db.tResumeMw)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      final response = await query.join([
        innerJoin(
          db.tMw,
          db.tResumeMw.mwId.equalsExp(db.tMw.mwId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getResumeMwList 通信終了');
    }
  }

  /// 経歴書 Mw紐付け 追加
  Future<void> insertResumeMw({
    required TResumeMwCompanion resumeMwData,
  }) async {
    try {
      _logger.d('insertResumeMw 通信開始');
      _logger.d('resumeMwData: $resumeMwData');
      await db.into(db.tResumeMw).insert(resumeMwData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertResumeMw 通信終了');
    }
  }

  ///経歴書  Mw紐付け 更新
  Future<void> updateResumeMw({
    required TResumeMwCompanion resumeMwData,
  }) async {
    try {
      _logger.d('updateResumeMw 通信開始');
      _logger.d('resumeMwData: $resumeMwData');
      await db.update(db.tResumeMw).replace(resumeMwData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateResumeMw 通信終了');
    }
  }

  /// 経歴書 Mw紐付け resumeProjectId一致のもの全て削除
  Future<void> deleteResumeMwByProjectId(
      {required String resumeProjectId}) async {
    try {
      _logger.d('deleteResumeMwByProjectId 通信開始');
      _logger.d('resumeProjectId: $resumeProjectId');
      final query = db.delete(db.tResumeMw)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeMwByProjectId 通信終了');
    }
  }

  /// 経歴書 Mw紐付け mwIdのもの全て削除
  Future<void> deleteResumeMwByMwId({required String mwId}) async {
    try {
      _logger.d('deleteResumeMwByMwId 通信開始');
      _logger.d('mwId: $mwId');
      final query = db.delete(db.tResumeMw)
        ..where((tbl) => tbl.mwId.equals(mwId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeMwByMwId 通信終了');
    }
  }

  // 経歴書 Mw紐付け model to entity
  TResumeMwCompanion convertResumeMwToEntity({
    required String resumeProjectId,
    required String mwId,
  }) {
    return TResumeMwCompanion(
      mwId: Value(mwId),
      resumeProjectId: Value(resumeProjectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
