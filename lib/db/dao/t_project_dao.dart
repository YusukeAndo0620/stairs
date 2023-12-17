import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/stairs_logger.dart';

part 't_project_dao.g.dart';

@DriftAccessor(tables: [TProject])
class TProjectDao extends DatabaseAccessor<StairsDatabase>
    with _$TProjectDaoMixin {
  TProjectDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_project_dao');

  /// プロジェクト一覧取得
  Future<List<TypedResult>> getProjectList() async {
    try {
      _logger.d('getProjectList 通信開始');
      final response = await db.select(db.tProject).join(
        [
          innerJoin(db.mColor, db.mColor.id.equalsExp(db.tProject.colorId)),
        ],
      ).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getProjectList 通信終了');
    }
  }

  /// プロジェクト詳細取得
  Future<TypedResult> getProjectDetail({
    required String projectId,
  }) async {
    try {
      _logger.d('getProjectDetail 通信開始');
      // 詳細取得クエリ
      final detailQuery = db.select(db.tProject)
        ..where((tbl) => tbl.projectId.equals(projectId));
      // 詳細
      final response = await detailQuery.join(
        [
          // カラー
          innerJoin(
            db.mColor,
            db.mColor.id.equalsExp(db.tProject.colorId),
          ),
        ],
      ).getSingle();

      _logger.d('取得データ：$response');

      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getProjectDetail 通信終了');
    }
  }
}
