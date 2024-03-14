import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_resume_skill_dao.g.dart';

@DriftAccessor(tables: [TResumeSkill])
class TResumeSkillDao extends DatabaseAccessor<StairsDatabase>
    with _$TResumeSkillDaoMixin {
  TResumeSkillDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_resume_skill_dao');

  /// 経歴書 スキル取得
  Future<List<TResumeSkillData>> getResumeSkill({
    required String accountId,
  }) async {
    try {
      _logger.d('getResumeSkill 通信開始');
      final query = db.select(db.tResumeSkill)
        ..where((tbl) => tbl.accountId.equals(accountId));

      final response = await query.get();
      _logger.d('取得データ length ${response.length}');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getResumeSkill 通信終了');
    }
  }

  /// 経歴書 スキル 追加
  Future<void> insertResumeSkill({
    required TResumeSkillCompanion resumeSkillData,
  }) async {
    try {
      _logger.d('insertResumeSkill 通信開始');
      await db.into(db.tResumeSkill).insert(resumeSkillData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertResumeSkill 通信終了');
    }
  }

  /// 経歴書 スキル 更新
  Future<void> updateResumeSkill({
    required TResumeSkillCompanion resumeSkillData,
  }) async {
    try {
      _logger.d('updateResumeSkill 通信開始');
      await db.update(db.tResumeSkill).replace(resumeSkillData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateResumeSkill 通信終了');
    }
  }
}
