import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/stairs_logger.dart';

part 't_tool_dao.g.dart';

@DriftAccessor(tables: [TTool])
class TToolDao extends DatabaseAccessor<StairsDatabase> with _$TToolDaoMixin {
  TToolDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_tool_dao');

  /// プロジェクトで設定されたツール取得
  Future<List<TToolData>> getToolList({
    required String projectId,
  }) async {
    try {
      _logger.d('getToolList 通信開始');
      final query = db.select(db.tTool)
        ..where((tbl) => tbl.projectId.equals(projectId));
      final response = await query.get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getToolList 通信終了');
    }
  }
}
