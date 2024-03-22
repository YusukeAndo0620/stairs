import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_resume_role_dao.g.dart';

@DriftAccessor(tables: [TResumeRole])
class TResumeRoleDao extends DatabaseAccessor<StairsDatabase>
    with _$TResumeRoleDaoMixin {
  TResumeRoleDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_resume_role_dao');

  /// 経歴書で設定された役割取得
  Future<List<TResumeRoleData>> getResumeRoleList({
    required String resumeProjectId,
  }) async {
    try {
      _logger.d('getResumeRoleList 通信開始');
      final query = db.select(db.tResumeRole)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      final response = await query.get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getResumeRoleList 通信終了');
    }
  }

  /// 経歴書 役割 追加
  Future<void> insertResumeRole({
    required TResumeRoleCompanion resumeRoleData,
  }) async {
    try {
      _logger.d('insertResumeRole 通信開始');
      _logger.d('resumeRoleData: $resumeRoleData');
      await db.into(db.tResumeRole).insert(resumeRoleData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertResumeRole 通信終了');
    }
  }

  ///経歴書 役割 更新
  Future<void> updateResumeRole({
    required TResumeRoleCompanion resumeRoleData,
  }) async {
    try {
      _logger.d('updateResumeRole 通信開始');
      _logger.d('resumeRoleData: $resumeRoleData');
      await db.update(db.tResumeRole).replace(resumeRoleData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateResumeRole 通信終了');
    }
  }

  /// 経歴書 役割 resumeProjectId一致のもの全て削除
  Future<void> deleteResumeRoleByProjectId(
      {required String resumeProjectId}) async {
    try {
      _logger.d('deleteResumeRoleByProjectId 通信開始');
      _logger.d('resumeProjectId: $resumeProjectId');
      final query = db.delete(db.tResumeRole)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeRoleByProjectId 通信終了');
    }
  }

  // 経歴書 役割 model to entity
  TResumeRoleCompanion convertResumeRoleToEntity({
    required String resumeProjectId,
    required int code,
  }) {
    return TResumeRoleCompanion(
      code: Value(code),
      resumeProjectId: Value(resumeProjectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
