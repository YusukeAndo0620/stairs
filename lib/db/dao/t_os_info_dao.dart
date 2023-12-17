import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';

import 'package:stairs/loom/stairs_logger.dart';

part 't_os_info_dao.g.dart';

@DriftAccessor(tables: [TOsInfo])
class TOsInfoDao extends DatabaseAccessor<StairsDatabase>
    with _$TOsInfoDaoMixin {
  TOsInfoDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_os_info_dao');

  /// プロジェクトで設定されたOS取得
  Future<List<TOsInfoData>> getOsList({
    required String projectId,
  }) async {
    try {
      _logger.d('getOsList 通信開始');
      final query = db.select(db.tOsInfo)
        ..where((tbl) => tbl.projectId.equals(projectId));
      final response = await query.get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getOsList 通信終了');
    }
  }
}
