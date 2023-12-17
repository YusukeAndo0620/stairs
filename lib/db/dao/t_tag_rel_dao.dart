import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/stairs_logger.dart';

part 't_tag_rel_dao.g.dart';

@DriftAccessor(tables: [TDevLanguageRel])
class TTagRelDao extends DatabaseAccessor<StairsDatabase>
    with _$TTagRelDaoMixin {
  TTagRelDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 't_tag_rel_dao');

  /// プロジェクトで設定されタグ取得
  Future<List<TypedResult>> getTagList({
    required String projectId,
  }) async {
    try {
      _logger.d('getTagList 通信開始');
      final query = db.select(db.tTagRel)
        ..where((tbl) => tbl.projectId.equals(projectId));

      final response = await query.join([
        innerJoin(
          db.tTag,
          db.tTagRel.tagId.equalsExp(db.tTag.id),
        ),
        // カラー
        innerJoin(
          db.mColor,
          db.mColor.id.equalsExp(db.tTag.colorId),
        ),
      ]).get();
      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getTagList 通信終了');
    }
  }
}
