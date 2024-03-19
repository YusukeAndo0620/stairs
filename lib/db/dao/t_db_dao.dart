import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_db_dao.g.dart';

@DriftAccessor(tables: [TDb])
class TDbDao extends DatabaseAccessor<StairsDatabase> with _$TDbDaoMixin {
  TDbDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_db_dao');

  /// アカウントで設定されたDB取得
  Future<List<TDbData>> getDbList({
    required String accountId,
  }) async {
    try {
      _logger.d('getDbList 通信開始');
      final query = db.select(db.tDb)
        ..where((tbl) => tbl.accountId.equals(accountId));
      final response = await query.get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getDbList 通信終了');
    }
  }

  /// DB 追加
  Future<void> insertDb({
    required TDbCompanion dbData,
  }) async {
    try {
      _logger.d('insertDb 通信開始');
      _logger.d('dbData: $dbData');
      await db.into(db.tDb).insert(dbData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertDb 通信終了');
    }
  }

  /// DB 更新
  Future<void> updateDb({
    required TDbCompanion dbData,
  }) async {
    try {
      _logger.d('updateDb 通信開始');
      _logger.d('dbData: $dbData');
      await db.update(db.tDb).replace(dbData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateDb 通信終了');
    }
  }

  /// DB 削除
  Future<void> deleteDb({
    required String accountId,
    required String dbId,
  }) async {
    try {
      _logger.d('deleteDb 通信開始');
      _logger.d('dbId: $dbId');
      final query = db.delete(db.tDb)
        ..where(
            (tbl) => tbl.dbId.equals(dbId) & tbl.accountId.equals(accountId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteDb 通信終了');
    }
  }

  // DB model to entity
  TDbCompanion convertDbToEntity({
    required String accountId,
    required LabelModel model,
  }) {
    return TDbCompanion(
      dbId: Value(model.id),
      name: Value(model.labelName),
      accountId: Value(accountId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
