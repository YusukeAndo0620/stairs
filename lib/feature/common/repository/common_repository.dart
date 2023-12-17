import 'package:stairs/db/database.dart';
import 'package:stairs/loom/loom_package.dart';

class CommonRepository {
  CommonRepository({required this.database});

  final StairsDatabase database;
  final _logger = stairsLogger(name: 'common_repository');

  /// カラー一覧取得
  Future<List<ColorModel>?> getColorList() async {
    try {
      _logger.i('getColorList 通信開始');
      final response = await database.select(database.mColor).get();
      _logger.i('取得データ：$response');
      final targetData = _convertMColorToModel(colorData: response);

      return targetData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getColorList 通信終了');
    }
  }

  /// 開発工程一覧取得
  Future<List<LabelModel>?> getDevProgressList() async {
    try {
      _logger.i('getDevProgressList 通信開始');
      final response = await database.select(database.mDevProgressList).get();
      _logger.i('取得データ：$response');
      final targetData = _convertMDevProgressToModel(devProgressList: response);

      return targetData;
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
