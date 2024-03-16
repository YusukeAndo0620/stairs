import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/db/db_package.dart';
import 'package:stairs/loom/loom_package.dart';

part 'm_country_code_dao.g.dart';

@DriftAccessor(tables: [MCountryCode])
class MCountryCodeDao extends DatabaseAccessor<StairsDatabase>
    with _$MCountryCodeDaoMixin {
  MCountryCodeDao(StairsDatabase db) : super(db);

  final _logger = stairsLogger(name: 'm_country_code_dao');

  /// 国情報一覧取得
  Future<List<MCountryCodeData>> getCountryList() async {
    try {
      _logger.d('getCountryCodeList 通信開始');
      final response = await db.select(db.mCountryCode).get();

      _logger.d('取得データ length ${response.length}');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getCountryCodeList 通信終了');
    }
  }

  /// 国情報一覧取得
  Future<MCountryCodeData> getCountryByCode({
    required int countryCode,
  }) async {
    try {
      _logger.d('getCountryByCode 通信開始');
      _logger.d('countryCode: $countryCode');
      final query = db.select(db.mCountryCode)
        ..where((tbl) => tbl.code.equals(countryCode));

      final response = await query.getSingle();
      _logger.d('取得した国名: ${response.japaneseName}');
      return response;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.d('getCountryByCode 通信終了');
    }
  }
}
