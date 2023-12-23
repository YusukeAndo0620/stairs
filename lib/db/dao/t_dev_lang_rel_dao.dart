import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/stairs_logger.dart';

part 't_dev_lang_rel_dao.g.dart';

@DriftAccessor(tables: [TDevLanguageRel])
class TDevLangRelDao extends DatabaseAccessor<StairsDatabase>
    with _$TDevLangRelDaoMixin {
  TDevLangRelDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_dev_lang_rel_dao');

  /// プロジェクトで設定され開発言語取得
  Future<List<TypedResult>> getDevLangList({
    required String projectId,
  }) async {
    try {
      _logger.d('getDevLangList 通信開始');
      final query = db.select(db.tDevLanguageRel)
        ..where((tbl) => tbl.projectId.equals(projectId));

      final response = await query.join([
        innerJoin(
          db.tDevLanguage,
          db.tDevLanguage.devLangId.equalsExp(db.tDevLanguageRel.devLangId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getDevLangList 通信終了');
    }
  }

  /// 開発言語紐付け 追加
  Future<void> insertDevLanguage({
    required TDevLanguageRelCompanion devLangData,
  }) async {
    try {
      _logger.d('insertDevLanguage 通信開始');
      _logger.d('devLangData:  $devLangData');
      await db.into(db.tDevLanguageRel).insert(devLangData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertDevLanguage 通信終了');
    }
  }

  /// 開発言語紐付け 削除
  Future<void> deleteDevLangByProjectId({required String projectId}) async {
    try {
      _logger.d('deleteDevLangByProjectId 通信開始');
      _logger.d('projectId: $projectId');
      final query = db.delete(db.tDevLanguageRel)
        ..where((tbl) => tbl.projectId.equals(projectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteDevLangByProjectId 通信終了');
    }
  }
}
