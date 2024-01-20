import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_tag_dao.g.dart';

@DriftAccessor(tables: [TDevLanguage])
class TTagDao extends DatabaseAccessor<StairsDatabase> with _$TTagDaoMixin {
  TTagDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_tag_dao');

  /// 全てのタグ取得
  Future<List<TypedResult>> getTagList({
    required String accountId,
  }) async {
    try {
      _logger.d('getTagList 通信開始');
      final query = db.select(db.tTag)
        ..where((tbl) => tbl.accountId.equals(accountId));

      final response = await query.join([
        // カラー
        innerJoin(
          db.mColor,
          db.mColor.id.equalsExp(db.tTag.colorId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getTagList 通信終了');
    }
  }

  /// デフォルトのタグ取得
  Future<List<TypedResult>> getDefaultTagList({
    required String accountId,
  }) async {
    try {
      _logger.d('getTagList 通信開始');
      final query = db.select(db.tTag)
        ..where((tbl) => tbl.accountId.equals(accountId) & tbl.isReadOnly);

      final response = await query.join([
        // カラー
        innerJoin(
          db.mColor,
          db.mColor.id.equalsExp(db.tTag.colorId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getTagList 通信終了');
    }
  }

  /// タグ 追加
  Future<void> insertTag({
    required TTagCompanion tagData,
  }) async {
    try {
      _logger.d('insertTag 通信開始');
      _logger.d('tagData:  $tagData');
      await db.into(db.tTag).insert(tagData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertTag 通信終了');
    }
  }

  /// タグ 削除
  Future<void> deleteTagByAccountId({
    required String accountId,
  }) async {
    try {
      _logger.d('deleteTagByAccountId 通信開始');
      _logger.d('accountId: $accountId');
      final query = db.delete(db.tTag)
        ..where((tbl) =>
            tbl.accountId.equals(accountId) & tbl.isReadOnly.equals(false));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteTagByAccountId 通信終了');
    }
  }

  // Tag model to entity
  TTagCompanion convertTagToEntity({
    required String accountId,
    required ColorLabelModel model,
  }) {
    return TTagCompanion(
      name: Value(model.labelName),
      colorId: Value(model.colorModel.id),
      isReadOnly: const Value(false),
      accountId: Value(accountId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
