import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 't_git_dao.g.dart';

@DriftAccessor(tables: [TGit])
class TGitDao extends DatabaseAccessor<StairsDatabase> with _$TGitDaoMixin {
  TGitDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_git_dao');

  /// プロジェクトで設定されたGit取得
  Future<List<TGitData>> getGitList({
    required String accountId,
  }) async {
    try {
      _logger.d('getGitList 通信開始');
      final query = db.select(db.tGit)
        ..where((tbl) => tbl.accountId.equals(accountId));
      final response = await query.get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getGitList 通信終了');
    }
  }

  /// Git 追加
  Future<void> insertGit({
    required TGitCompanion gitData,
  }) async {
    try {
      _logger.d('insertGit 通信開始');
      _logger.d('gitData: $gitData');
      await db.into(db.tGit).insert(gitData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('insertGit 通信終了');
    }
  }

  /// Git 更新
  Future<void> updateGit({
    required TGitCompanion gitData,
  }) async {
    try {
      _logger.d('updateGit 通信開始');
      _logger.d('gitData: $gitData');
      await db.update(db.tGit).replace(gitData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('updateGit 通信終了');
    }
  }

  /// Git 削除
  Future<void> deleteGit({
    required String accountId,
    required String gitId,
  }) async {
    try {
      _logger.d('deleteGit 通信開始');
      _logger.d('accountId: $accountId');
      _logger.d('gitId: $gitId');
      final query = db.delete(db.tGit)
        ..where((tbl) =>
            tbl.accountId.equals(accountId) & tbl.gitId.equals(gitId));
      await query.go();
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('deleteGit 通信終了');
    }
  }

  // Git model to entity
  TGitCompanion convertGitToEntity({
    required String accountId,
    required LabelModel model,
  }) {
    return TGitCompanion(
      gitId: Value(model.id),
      name: Value(model.labelName),
      accountId: Value(accountId),
      updateAt: Value(DateTime.now().toIso8601String()),
    );
  }
}
