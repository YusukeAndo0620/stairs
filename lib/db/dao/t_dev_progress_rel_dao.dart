import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/stairs_logger.dart';

part 't_dev_progress_rel_dao.g.dart';

@DriftAccessor(tables: [TDevProgressRel])
class TDevProgressRelDao extends DatabaseAccessor<StairsDatabase>
    with _$TDevProgressRelDaoMixin {
  TDevProgressRelDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_dev_progress_rel_dao');

  /// プロジェクトで設定され開発工程取得
  Future<List<TypedResult>> getDevProgressList({
    required String projectId,
  }) async {
    try {
      _logger.d('getDevProgressList 通信開始');
      final query = db.select(db.tDevProgressRel)
        ..where((tbl) => tbl.projectId.equals(projectId));

      final response = await query.join([
        innerJoin(
          db.mDevProgressList,
          db.mDevProgressList.id.equalsExp(db.tDevProgressRel.devProgressId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getDevProgressList 通信終了');
    }
  }
}
