import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';
import '../database.dart';
import 'package:stairs/loom/loom_package.dart';

part 'm_account_dao.g.dart';

@DriftAccessor(tables: [MAccount])
class MAccountDao extends DatabaseAccessor<StairsDatabase>
    with _$MAccountDaoMixin {
  MAccountDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 'm_account_dao');

  /// アカウント情報取得
  Future<MAccountData> getAccount() async {
    try {
      _logger.d('getAccount 通信開始');
      final response = db.select(db.mAccount).getSingle();

      _logger.d('取得データ：$response');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getAccount 通信終了');
    }
  }
}
