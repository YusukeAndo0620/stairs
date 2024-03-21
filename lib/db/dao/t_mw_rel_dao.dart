import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_mw_rel_dao.g.dart';

@DriftAccessor(tables: [TMwRel])
class TMwRelDao extends DatabaseAccessor<StairsDatabase> with _$TMwRelDaoMixin {
  TMwRelDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_mw_rel_dao');

  /// プロジェクトで設定されたMW紐付け取得
  Future<List<TypedResult>> getMwRelList({
    required String projectId,
  }) async {
    try {
      _logger.d('getMwRelList 通信開始');
      final query = db.select(db.tMwRel)
        ..where((tbl) => tbl.projectId.equals(projectId));
      final response = await query.join([
        innerJoin(
          db.tMw,
          db.tMwRel.mwId.equalsExp(db.tMw.mwId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getMwRelList 通信終了');
    }
  }

  /// MW紐付け 追加
  Future<void> insertMwRel({
    required TMwRelCompanion mwRelData,
  }) async {
    try {
      _logger.d('insertMwRel 通信開始');
      _logger.d('mwRelData: $mwRelData');
      await db.into(db.tMwRel).insert(mwRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertMwRel 通信終了');
    }
  }

  /// MW紐付け 更新
  Future<void> updateMwRel({
    required TMwRelCompanion mwRelData,
  }) async {
    try {
      _logger.d('updateMwRel 通信開始');
      _logger.d('mwRelData: $mwRelData');
      await db.update(db.tMwRel).replace(mwRelData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateMwRel 通信終了');
    }
  }

  /// MW紐付け 削除
  Future<void> deleteMwRel({required int id}) async {
    try {
      _logger.d('deleteMwRel 通信開始');
      _logger.d('id: $id');
      final query = db.delete(db.tMwRel)..where((tbl) => tbl.id.equals(id));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteMwRel 通信終了');
    }
  }

  /// MW紐付け projectId一致のもの全て削除
  Future<void> deleteMwRelByProjectId({required String projectId}) async {
    try {
      _logger.d('deleteMwRelByProjectId 通信開始');
      _logger.d('projectId: $projectId');
      final query = db.delete(db.tMwRel)
        ..where((tbl) => tbl.projectId.equals(projectId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteMwRelByProjectId 通信終了');
    }
  }

  /// MW紐付け mwIdのもの全て削除
  Future<void> deleteMwRelByMwId({required String mwId}) async {
    try {
      _logger.d('deleteMwRelByMwId 通信開始');
      _logger.d('mwId: $mwId');
      final query = db.delete(db.tMwRel)..where((tbl) => tbl.mwId.equals(mwId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteMwRelByMwId 通信終了');
    }
  }

  // MW紐付け model to entity
  TMwRelCompanion convertMwRelToEntity({
    required String projectId,
    required String mwId,
  }) {
    return TMwRelCompanion(
      mwId: Value(mwId),
      projectId: Value(projectId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
