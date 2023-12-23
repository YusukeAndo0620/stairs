import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/stairs_logger.dart';

part 't_dev_lang_dao.g.dart';

@DriftAccessor(tables: [TDevLanguage])
class TDevLangDao extends DatabaseAccessor<StairsDatabase>
    with _$TDevLangDaoMixin {
  TDevLangDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_dev_lang_dao');

  /// 開発言語取得
  Future<List<TDevLanguageData>> getDevLangList({
    required String accountId,
  }) async {
    try {
      _logger.d('getDevLangList 通信開始');
      final query = db.select(db.tDevLanguage)
        ..where((tbl) => tbl.accountId.equals(accountId));
      final response = await query.get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getDevLangList 通信終了');
    }
  }

  /// 開発言語 追加
  Future<void> insertDevLanguage({
    required TDevLanguageCompanion devLangData,
  }) async {
    try {
      _logger.d('insertDevLanguage 通信開始');
      _logger.d('devLangData:  $devLangData');
      await db.into(db.tDevLanguage).insert(devLangData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertDevLanguage 通信終了');
    }
  }

  /// 開発言語 削除
  Future<void> deleteDevLangByAccountId({
    required String accountId,
  }) async {
    try {
      _logger.d('deleteDevLangByAccountId 通信開始');
      _logger.d('accountId: $accountId');
      final query = db.delete(db.tDevLanguage)
        ..where((tbl) => tbl.accountId.equals(accountId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteDevLangByAccountId 通信終了');
    }
  }
}
