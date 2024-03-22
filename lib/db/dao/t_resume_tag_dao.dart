import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_resume_tag_dao.g.dart';

@DriftAccessor(tables: [TResumeTag])
class TResumeTagDao extends DatabaseAccessor<StairsDatabase>
    with _$TResumeTagDaoMixin {
  TResumeTagDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_resume_tag_dao');

  /// 経歴書で設定されたタグ付け取得
  Future<List<TypedResult>> getResumeTagList({
    required String resumeProjectId,
  }) async {
    try {
      _logger.d('getResumeTagList 通信開始');
      final query = db.select(db.tResumeTag)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      final response = await query.join([
        innerJoin(
          db.tTag,
          db.tResumeTag.tagId.equalsExp(db.tTag.id),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getResumeTagList 通信終了');
    }
  }

  /// 経歴書 タグ付け 追加
  Future<void> insertResumeTag({
    required TResumeTagCompanion resumeTagRelData,
  }) async {
    try {
      _logger.d('insertResumeTag 通信開始');
      _logger.d('resumeTagRelData: $resumeTagRelData');
      await db.into(db.tResumeTag).insert(resumeTagRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertResumeTag 通信終了');
    }
  }

  ///経歴書 タグ付け 更新
  Future<void> updateResumeTag({
    required TResumeTagCompanion resumeTagRelData,
  }) async {
    try {
      _logger.d('updateResumeTag 通信開始');
      _logger.d('resumeTagRelData: $resumeTagRelData');
      await db.update(db.tResumeTag).replace(resumeTagRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateResumeTag 通信終了');
    }
  }

  /// 経歴書 タグ付け resumeProjectId一致のもの全て削除
  Future<void> deleteResumeTagByProjectId(
      {required String resumeProjectId}) async {
    try {
      _logger.d('deleteResumeTagByProjectId 通信開始');
      _logger.d('resumeProjectId: $resumeProjectId');
      final query = db.delete(db.tResumeTag)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeTagByProjectId 通信終了');
    }
  }

  /// 経歴書 タグ付け tagIdのもの全て削除
  Future<void> deleteResumeTagByTagId({required int tagId}) async {
    try {
      _logger.d('deleteResumeTagByTagId 通信開始');
      _logger.d('tagId: $tagId');
      final query = db.delete(db.tResumeTag)
        ..where((tbl) => tbl.tagId.equals(tagId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeTagByTagId 通信終了');
    }
  }

  // 経歴書 タグ付け model to entity
  TResumeTagCompanion convertResumeTagToEntity({
    required String resumeProjectId,
    required int taskCount,
    required String content,
    required int tagId,
  }) {
    return TResumeTagCompanion(
      taskCount: Value(taskCount),
      tagId: Value(tagId),
      resumeProjectId: Value(resumeProjectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
