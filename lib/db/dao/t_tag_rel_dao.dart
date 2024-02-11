import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_tag_rel_dao.g.dart';

@DriftAccessor(tables: [TDevLanguageRel])
class TTagRelDao extends DatabaseAccessor<StairsDatabase>
    with _$TTagRelDaoMixin {
  TTagRelDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_tag_rel_dao');

  /// プロジェクトで設定されタグ取得
  Future<List<TypedResult>> getTagList({
    required String projectId,
  }) async {
    try {
      _logger.d('getTagList 通信開始');
      final query = db.select(db.tTagRel)
        ..where((tbl) => tbl.projectId.equals(projectId));

      final response = await query.join([
        innerJoin(
          db.tTag,
          db.tTagRel.tagId.equalsExp(db.tTag.id),
        ),
        // カラー
        innerJoin(
          db.mColor,
          db.mColor.id.equalsExp(db.tTagRel.colorId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      _logger.d('length: ${response.length}');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getTagList 通信終了');
    }
  }

  Future<TypedResult> getTagWithTagRelId({
    required int tagRelId,
  }) async {
    try {
      _logger.d('getTagList 通信開始');
      final query = db.select(db.tTagRel)
        ..where((tbl) => tbl.id.equals(tagRelId));

      final response = await query.join([
        innerJoin(
          db.tTag,
          db.tTagRel.tagId.equalsExp(db.tTag.id),
        ),
        // カラー
        innerJoin(
          db.mColor,
          db.mColor.id.equalsExp(db.tTag.colorId),
        ),
      ]).getSingle();
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
    required TTagRelCompanion tagData,
  }) async {
    try {
      _logger.d('insertTag 通信開始');
      _logger.d('tagData:  $tagData');
      await db.into(db.tTagRel).insert(tagData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertTag 通信終了');
    }
  }

  /// タグ 更新
  Future<void> updateTag({
    required TTagRelCompanion tagData,
  }) async {
    try {
      _logger.d('updateTag 通信開始');
      _logger.d('tagData: $tagData');
      await db.update(db.tTagRel).replace(tagData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateTag 通信終了');
    }
  }

  /// タグ 削除
  Future<void> deleteTagByKey({
    required int id,
  }) async {
    try {
      _logger.d('deleteTagByKey 通信開始');
      _logger.d('id: $id');
      final query = db.delete(db.tTagRel)..where((tbl) => tbl.id.equals(id));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteTagByKey 通信終了');
    }
  }

  /// タグ 削除（projectId)
  Future<void> deleteTagByProjectId({
    required String projectId,
  }) async {
    try {
      _logger.d('deleteTagByProjectId 通信開始');
      _logger.d('projectId: $projectId');
      final query = db.delete(db.tTagRel)
        ..where((tbl) => tbl.projectId.equals(projectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteTagByProjectId 通信終了');
    }
  }

  // Tag rel model to entity
  TTagRelCompanion? convertTagToEntity({
    int? id,
    required String projectId,
    required ColorLabelModel model,
  }) {
    if (int.tryParse(model.id) == null) {
      _logger.e('ColorLabelModelのidが数値ではありません。id: ${model.id}');
      return null;
    }
    return TTagRelCompanion(
      id: id != null ? Value(id) : const Value.absent(),
      colorId: Value(model.colorModel.id),
      projectId: Value(projectId),
      tagId: Value(int.parse(model.id)),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
