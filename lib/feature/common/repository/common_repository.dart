import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:collection/collection.dart';

class CommonRepository {
  CommonRepository({required this.db});

  final StairsDatabase db;
  final _logger = stairsLogger(name: 'common_repository');

  /// アカウント取得
  Future<AccountModel?> getAccount() async {
    try {
      _logger.i('getAccount 通信開始');
      final response = await db.mAccountDao.getAccount();
      _logger.i('取得データ：$response');
      final responseData = _convertMAccountToModel(accountData: response);

      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getAccount 通信終了');
    }
  }

  /// カラー一覧取得
  Future<List<ColorModel>?> getColorList() async {
    try {
      _logger.i('getColorList 通信開始');
      final response = await db.select(db.mColor).get();
      _logger.i('取得数：${response.length}件');
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
  Future<List<LabelModel>?> getDevLanguageList(
      {required String accountId}) async {
    try {
      _logger.i('getDevLanguageList 通信開始');
      final tDevLangList =
          await db.tDevLangDao.getDevLangList(accountId: accountId);
      _logger.i('取得数：${tDevLangList.length}件');
      List<LabelModel> responseData = [];
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

  /// DB一覧取得
  Future<List<LabelModel>?> getDbList({required String accountId}) async {
    try {
      _logger.i('getDbList 通信開始');
      final response = await db.tDbDao.getDbList(accountId: accountId);
      _logger.i('取得数：${response.length}件');
      final responseData = _convertTDbToModel(dbList: response);

      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getDbList 通信終了');
    }
  }

  /// DB 追加
  Future<void> createDb(
      {required String accountId, required LabelModel labelModel}) async {
    try {
      _logger.i('createDb 通信開始');
      final dbData =
          _convertTDbToEntity(accountId: accountId, labelModel: labelModel);
      await db.tDbDao.insertDb(dbData: dbData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('createDb 通信終了');
    }
  }

  /// DB 更新
  Future<void> updateDb(
      {required String accountId, required LabelModel labelModel}) async {
    try {
      _logger.i('updateDb 通信開始');
      final dbData =
          _convertTDbToEntity(accountId: accountId, labelModel: labelModel);
      await db.tDbDao.updateDb(dbData: dbData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('updateDb 通信終了');
    }
  }

  /// DB 削除
  Future<void> deleteDb(
      {required String accountId, required String dbId}) async {
    try {
      _logger.i('deleteDb 通信開始');
      await db.tDbDao.deleteDb(accountId: accountId, dbId: dbId);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('deleteDb 通信終了');
    }
  }

  /// 開発工程一覧取得
  Future<List<LabelModel>?> getDevProgressList() async {
    try {
      _logger.i('getDevProgressList 通信開始');
      final response = await db.select(db.mDevProgressList).get();
      _logger.i('取得数：${response.length}件');
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

  /// デフォルトタグ一覧取得
  Future<List<ColorLabelModel>?> getDefaultTagList(
      {required String accountId}) async {
    try {
      _logger.i('getDefaultTagList 通信開始');
      final response = await db.tTagDao.getDefaultTagList(accountId: accountId);
      _logger.i('取得数：${response.length}件');
      final responseData = _convertTTagToModel(
        tagList: response.map((e) => e.readTable(db.tTag)).toList(),
        tagColorData: response.map((e) => e.readTable(db.mColor)).toList(),
      );

      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getDefaultTagList 通信終了');
    }
  }
}

/// account to model
AccountModel _convertMAccountToModel({required MAccountData accountData}) {
  return AccountModel(
      accountId: accountData.accountId,
      address: accountData.address,
      planType: getPlanType(accountData.planType));
}

/// color to model
List<ColorModel> _convertMColorToModel({required List<MColorData> colorData}) {
  return colorData
      .map((item) => ColorModel(
          id: item.id, color: getColorFromCode(code: item.colorCodeId)))
      .toList();
}

/// db to model
List<LabelModel> _convertTDbToModel({required List<TDbData> dbList}) {
  return dbList
      .map((item) => LabelModel(id: item.dbId, labelName: item.name))
      .toList();
}

/// db to entity
TDbCompanion _convertTDbToEntity({
  required String accountId,
  required LabelModel labelModel,
}) {
  return TDbCompanion(
    dbId: Value(labelModel.id),
    name: Value(
      labelModel.labelName,
    ),
    accountId: Value(accountId),
    updateAt: Value(DateTime.now().toIso8601String()),
  );
}

/// dev progress to model
List<LabelModel> _convertMDevProgressToModel(
    {required List<MDevProgressListData> devProgressList}) {
  return devProgressList
      .map((item) => LabelModel(id: item.id.toString(), labelName: item.name))
      .toList();
}

List<ColorLabelModel> _convertTTagToModel({
  required List<TTagData> tagList,
  required List<MColorData> tagColorData,
}) {
  // タグリスト
  final List<ColorLabelModel> targetTagList = [];
  for (var i = 0; i < tagList.length; i++) {
    targetTagList.add(
      ColorLabelModel(
        id: tagList[i].id.toString(),
        labelName: tagList[i].name,
        isReadOnly: tagList[i].isReadOnly,
        colorModel: ColorModel(
            id: tagColorData[i].id,
            color: getColorFromCode(code: tagColorData[i].colorCodeId)),
      ),
    );
  }
  return targetTagList;
}
