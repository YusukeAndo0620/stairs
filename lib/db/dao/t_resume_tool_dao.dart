import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_resume_tool_dao.g.dart';

@DriftAccessor(tables: [TResumeTool])
class TResumeToolDao extends DatabaseAccessor<StairsDatabase>
    with _$TResumeToolDaoMixin {
  TResumeToolDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_resume_tool_dao');

  /// 経歴書で設定されたTool紐付け取得
  Future<List<TypedResult>> getResumeToolList({
    required String resumeProjectId,
  }) async {
    try {
      _logger.d('getResumeToolList 通信開始');
      final query = db.select(db.tResumeTool)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      final response = await query.join([
        innerJoin(
          db.tTool,
          db.tResumeTool.toolId.equalsExp(db.tTool.toolId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getResumeToolList 通信終了');
    }
  }

  /// 経歴書 Tool紐付け 追加
  Future<void> insertResumeTool({
    required TResumeToolCompanion resumeToolData,
  }) async {
    try {
      _logger.d('insertResumeTool 通信開始');
      _logger.d('resumeToolData: $resumeToolData');
      await db.into(db.tResumeTool).insert(resumeToolData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertResumeTool 通信終了');
    }
  }

  ///経歴書  Tool紐付け 更新
  Future<void> updateResumeTool({
    required TResumeToolCompanion resumeToolData,
  }) async {
    try {
      _logger.d('updateResumeTool 通信開始');
      _logger.d('resumeToolData: $resumeToolData');
      await db.update(db.tResumeTool).replace(resumeToolData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateResumeTool 通信終了');
    }
  }

  /// 経歴書 Tool紐付け resumeProjectId一致のもの全て削除
  Future<void> deleteResumeToolByProjectId(
      {required String resumeProjectId}) async {
    try {
      _logger.d('deleteResumeToolByProjectId 通信開始');
      _logger.d('resumeProjectId: $resumeProjectId');
      final query = db.delete(db.tResumeTool)
        ..where((tbl) => tbl.resumeProjectId.equals(resumeProjectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeToolByProjectId 通信終了');
    }
  }

  /// 経歴書 Tool紐付け toolIdのもの全て削除
  Future<void> deleteResumeToolByToolId({required String toolId}) async {
    try {
      _logger.d('deleteResumeToolByToolId 通信開始');
      _logger.d('toolId: $toolId');
      final query = db.delete(db.tResumeTool)
        ..where((tbl) => tbl.toolId.equals(toolId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteResumeToolByToolId 通信終了');
    }
  }

  // 経歴書 Tool紐付け model to entity
  TResumeToolCompanion convertResumeToolToEntity({
    required String resumeProjectId,
    required String toolId,
  }) {
    return TResumeToolCompanion(
      toolId: Value(toolId),
      resumeProjectId: Value(resumeProjectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
