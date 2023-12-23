import 'package:stairs/db/database.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:collection/collection.dart';

class CommonRepository {
  CommonRepository({required this.db});

  final StairsDatabase db;
  final _logger = stairsLogger(name: 'common_repository');

  /// カラー一覧取得
  Future<List<ColorModel>?> getColorList() async {
    try {
      _logger.i('getColorList 通信開始');
      final response = await db.select(db.mColor).get();
      _logger.i('取得データ：$response');
      final responseData = _convertMColorToModel(colorData: response);

      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getColorList 通信終了');
    }
  }

  /// プログラミング言語一覧取得
  Future<List<LabelModel>?> getDevLanguageList() async {
    try {
      _logger.i('getDevLanguageList 通信開始');
      final mDevLangList = await db.mDevLangDao.getDevLangList();
      final tDevLangList = await db.tDevLangDao.getDevLangList(accountId: "1");
      List<LabelModel> responseData = [];
      for (final item in mDevLangList) {
        responseData.add(LabelModel(id: item.devLangId, labelName: item.name));
      }
      for (final item in tDevLangList) {
        responseData.add(LabelModel(id: item.devLangId, labelName: item.name));
      }
      responseData.sortBy((element) => element.labelName);
      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getDevLanguageList 通信終了');
    }
  }

  /// 開発工程一覧取得
  Future<List<LabelModel>?> getDevProgressList() async {
    try {
      _logger.i('getDevProgressList 通信開始');
      final response = await db.select(db.mDevProgressList).get();
      _logger.i('取得データ：$response');
      final responseData =
          _convertMDevProgressToModel(devProgressList: response);

      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getDevProgressList 通信終了');
    }
  }
}

List<ColorModel> _convertMColorToModel({required List<MColorData> colorData}) {
  return colorData
      .map((item) => ColorModel(
          id: item.id, color: getColorFromCode(code: item.colorCodeId)))
      .toList();
}

List<LabelModel> _convertMDevProgressToModel(
    {required List<MDevProgressListData> devProgressList}) {
  return devProgressList
      .map((item) => LabelModel(id: item.id.toString(), labelName: item.name))
      .toList();
}
