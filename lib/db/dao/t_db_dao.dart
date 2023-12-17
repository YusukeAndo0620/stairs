import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/stairs_logger.dart';

part 't_db_dao.g.dart';

@DriftAccessor(tables: [TDb])
class TDbDao extends DatabaseAccessor<StairsDatabase> with _$TDbDaoMixin {
  TDbDao(StairsDatabase db) : super(db);
  final _logger = stairsLogger(name: 't_db_dao');

  /// プロジェクトで設定されたDB取得
  Future<List<TDbData>> getDbList({
    required String projectId,
  }) async {
    try {
      _logger.d('getDbList 通信開始');
      final query = db.select(db.tDb)
        ..where((tbl) => tbl.projectId.equals(projectId));
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
}
