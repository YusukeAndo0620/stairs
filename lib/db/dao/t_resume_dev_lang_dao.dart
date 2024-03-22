import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_resume_dev_lang_dao.g.dart';

@DriftAccessor(tables: [TResumeDevLang])
class TResumeDevLangDao extends DatabaseAccessor<StairsDatabase>
    with _$TResumeDevLangDaoMixin {
  TResumeDevLangDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_resume_dev_lang_dao');

  /// 経歴書で設定された開発言語紐付け取得
  Future<List<TypedResult>> getResumeDevLangList({
    required String resumeProjectId,
  }) async {
    try {
      _logger.d('getResumeDevLangList 通信開始');
      final query = db.select(db.tResumeDevLang)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      final response = await query.join([
        innerJoin(
          db.tDevLanguage,
          db.tResumeDevLang.devLangId.equalsExp(db.tDevLanguage.devLangId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getResumeDevLangList 通信終了');
    }
  }

  /// 経歴書 開発言語紐付け 追加
  Future<void> insertResumeDevLang({
    required TResumeDevLangCompanion resumeDevLangRelData,
  }) async {
    try {
      _logger.d('insertResumeDevLang 通信開始');
      _logger.d('resumeDevLangRelData: $resumeDevLangRelData');
      await db.into(db.tResumeDevLang).insert(resumeDevLangRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertResumeDevLang 通信終了');
    }
  }

  ///経歴書 開発言語紐付け 更新
  Future<void> updateResumeDevLang({
    required TResumeDevLangCompanion resumeDevLangRelData,
  }) async {
    try {
      _logger.d('updateResumeDevLang 通信開始');
      _logger.d('resumeDevLangRelData: $resumeDevLangRelData');
      await db.update(db.tResumeDevLang).replace(resumeDevLangRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateResumeDevLang 通信終了');
    }
  }

  /// 経歴書 開発言語紐付け resumeProjectId一致のもの全て削除
  Future<void> deleteResumeDevLangByProjectId(
      {required String resumeProjectId}) async {
    try {
      _logger.d('deleteResumeDevLangByProjectId 通信開始');
      _logger.d('resumeProjectId: $resumeProjectId');
      final query = db.delete(db.tResumeDevLang)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeDevLangByProjectId 通信終了');
    }
  }

  /// 経歴書 開発言語紐付け devLangIdのもの全て削除
  Future<void> deleteResumeDevLangByDevLangId(
      {required String devLangId}) async {
    try {
      _logger.d('deleteResumeDevLangByDevLangId 通信開始');
      _logger.d('devLangId: $devLangId');
      final query = db.delete(db.tResumeDevLang)
        ..where((tbl) => tbl.devLangId.equals(devLangId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeDevLangByDevLangId 通信終了');
    }
  }

  // 経歴書 開発言語紐付け model to entity
  TResumeDevLangCompanion convertResumeDevLangToEntity({
    required String resumeProjectId,
    required String content,
    required String devLangId,
  }) {
    return TResumeDevLangCompanion(
      devLangId: Value(devLangId),
      content: Value(content),
      resumeProjectId: Value(resumeProjectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
