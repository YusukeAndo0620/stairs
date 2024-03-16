import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_resume_project_dao.g.dart';

@DriftAccessor(tables: [TResumeProject])
class TResumeProjectDao extends DatabaseAccessor<StairsDatabase>
    with _$TResumeProjectDaoMixin {
  TResumeProjectDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_resume_project_dao');

  /// 経歴書 プロジェクト取得
  Future<List<TResumeProjectData>> getResumeProject({
    required String accountId,
  }) async {
    try {
      _logger.d('getResumeProject 通信開始');
      final query = db.select(db.tResumeProject)
        ..where((tbl) => tbl.accountId.equals(accountId))
        ..orderBy([
          (u) => OrderingTerm(expression: u.columnCode),
          (u) => OrderingTerm(expression: u.orderNo)
        ]);

      final response = await query.get();
      _logger.d('取得データ length ${response.length}');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getResumeProject 通信終了');
    }
  }

  /// 経歴書 プロジェクト 追加
  Future<void> insertResumeProject({
    required TResumeProjectCompanion resumeProjectData,
  }) async {
    try {
      _logger.d('insertResumeProject 通信開始');
      await db.into(db.tResumeProject).insert(resumeProjectData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertResumeProject 通信終了');
    }
  }

  /// 経歴書 プロジェクト 更新
  Future<void> updateResumeSkill({
    required TResumeProjectCompanion resumeProjectData,
  }) async {
    try {
      _logger.d('updateResumeSkill 通信開始');
      await db.update(db.tResumeProject).replace(resumeProjectData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateResumeSkill 通信終了');
    }
  }
}
