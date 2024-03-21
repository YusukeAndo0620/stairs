import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_mw_dao.g.dart';

@DriftAccessor(tables: [TMw])
class TMwDao extends DatabaseAccessor<StairsDatabase> with _$TMwDaoMixin {
  TMwDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_mw_dao');

  /// プロジェクトで設定されたMW取得
  Future<List<TMwData>> getMwList({
    required String accountId,
  }) async {
    try {
      _logger.d('getMwList 通信開始');
      final query = db.select(db.tMw)
        ..where((tbl) => tbl.accountId.equals(accountId));
      final response = await query.get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getMwList 通信終了');
    }
  }

  /// MW 追加
  Future<void> insertMw({
    required TMwCompanion mwData,
  }) async {
    try {
      _logger.d('insertMw 通信開始');
      _logger.d('mwData: $mwData');
      await db.into(db.tMw).insert(mwData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertMw 通信終了');
    }
  }

  /// MW 更新
  Future<void> updateMw({
    required TMwCompanion mwData,
  }) async {
    try {
      _logger.d('updateMw 通信開始');
      _logger.d('mwData: $mwData');
      await db.update(db.tMw).replace(mwData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateMw 通信終了');
    }
  }

  /// MW 削除
  Future<void> deleteMw({
    required String accountId,
    required String mwId,
  }) async {
    try {
      _logger.d('deleteMw 通信開始');
      _logger.d('accountId: $accountId');
      _logger.d('mwId: $mwId');
      final query = db.delete(db.tMw)
        ..where(
            (tbl) => tbl.accountId.equals(accountId) & tbl.mwId.equals(mwId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteMw 通信終了');
    }
  }

  // MW model to entity
  TMwCompanion convertMwToEntity({
    required String accountId,
    required LabelModel model,
  }) {
    return TMwCompanion(
      mwId: Value(model.id),
      name: Value(model.labelName),
      accountId: Value(accountId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
