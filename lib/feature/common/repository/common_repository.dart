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
      final responseData = _convertAccountToModel(accountData: response);

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
      final responseData = _convertColorToModel(colorData: response);

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

  /// DB 一覧取得
  Future<List<LabelModel>?> getDbList({required String accountId}) async {
    try {
      _logger.i('getDbList 通信開始');
      final response = await db.tDbDao.getDbList(accountId: accountId);
      _logger.i('取得数：${response.length}件');
      final responseData = _convertDbToModel(dbList: response);

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
          _convertDbToEntity(accountId: accountId, labelModel: labelModel);
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
          _convertDbToEntity(accountId: accountId, labelModel: labelModel);
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

  /// Git 一覧取得
  Future<List<LabelModel>?> getGitList({required String accountId}) async {
    try {
      _logger.i('getGitList 通信開始');
      final response = await db.tGitDao.getGitList(accountId: accountId);
      _logger.i('取得数：${response.length}件');
      final responseData = _convertGitToModel(gitList: response);

      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getGitList 通信終了');
    }
  }

  /// Git 追加
  Future<void> createGit(
      {required String accountId, required LabelModel labelModel}) async {
    try {
      _logger.i('createGit 通信開始');
      final gitData =
          _convertGitToEntity(accountId: accountId, labelModel: labelModel);
      await db.tGitDao.insertGit(gitData: gitData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('createGit 通信終了');
    }
  }

  /// Git 更新
  Future<void> updateGit(
      {required String accountId, required LabelModel labelModel}) async {
    try {
      _logger.i('updateGit 通信開始');
      final gitData =
          _convertGitToEntity(accountId: accountId, labelModel: labelModel);
      await db.tGitDao.updateGit(gitData: gitData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('updateGit 通信終了');
    }
  }

  /// Git 削除
  Future<void> deleteGit(
      {required String accountId, required String gitId}) async {
    try {
      _logger.i('deleteGit 通信開始');
      await db.tGitDao.deleteGit(accountId: accountId, gitId: gitId);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('deleteGit 通信終了');
    }
  }

  /// Mw 一覧取得
  Future<List<LabelModel>?> getMwList({required String accountId}) async {
    try {
      _logger.i('getMwList 通信開始');
      final response = await db.tMwDao.getMwList(accountId: accountId);
      _logger.i('取得数：${response.length}件');
      final responseData = _convertMwToModel(mwList: response);

      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getMwList 通信終了');
    }
  }

  /// Mw 追加
  Future<void> createMw(
      {required String accountId, required LabelModel labelModel}) async {
    try {
      _logger.i('createMw 通信開始');
      final mwData =
          _convertMwToEntity(accountId: accountId, labelModel: labelModel);
      await db.tMwDao.insertMw(mwData: mwData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('createMw 通信終了');
    }
  }

  /// Mw 更新
  Future<void> updateMw(
      {required String accountId, required LabelModel labelModel}) async {
    try {
      _logger.i('updateMw 通信開始');
      final mwData =
          _convertMwToEntity(accountId: accountId, labelModel: labelModel);
      await db.tMwDao.updateMw(mwData: mwData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('updateMw 通信終了');
    }
  }

  /// Mw 削除
  Future<void> deleteMw(
      {required String accountId, required String mwId}) async {
    try {
      _logger.i('deleteMw 通信開始');
      await db.tMwDao.deleteMw(accountId: accountId, mwId: mwId);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('deleteMw 通信終了');
    }
  }

  /// Tool 一覧取得
  Future<List<LabelModel>?> getToolList({required String accountId}) async {
    try {
      _logger.i('getToolList 通信開始');
      final response = await db.tToolDao.getToolList(accountId: accountId);
      _logger.i('取得数：${response.length}件');
      final responseData = _convertToolToModel(toolList: response);

      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getToolList 通信終了');
    }
  }

  /// Tool 追加
  Future<void> createTool(
      {required String accountId, required LabelModel labelModel}) async {
    try {
      _logger.i('createTool 通信開始');
      final toolData =
          _convertToolToEntity(accountId: accountId, labelModel: labelModel);
      await db.tToolDao.insertTool(toolData: toolData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('createTool 通信終了');
    }
  }

  /// Tool 更新
  Future<void> updateTool(
      {required String accountId, required LabelModel labelModel}) async {
    try {
      _logger.i('updateTool 通信開始');
      final toolData =
          _convertToolToEntity(accountId: accountId, labelModel: labelModel);
      await db.tToolDao.updateTool(toolData: toolData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('updateTool 通信終了');
    }
  }

  /// Tool 削除
  Future<void> deleteTool(
      {required String accountId, required String toolId}) async {
    try {
      _logger.i('deleteTool 通信開始');
      await db.tToolDao.deleteTool(accountId: accountId, toolId: toolId);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('deleteTool 通信終了');
    }
  }

  /// OS 一覧取得
  Future<List<LabelModel>?> getOsList({required String accountId}) async {
    try {
      _logger.i('getOsList 通信開始');
      final response = await db.tOsInfoDao.getOsList(accountId: accountId);
      _logger.i('取得数：${response.length}件');
      final responseData = _convertOsToModel(osList: response);

      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getOsList 通信終了');
    }
  }

  /// OS 追加
  Future<void> createOs(
      {required String accountId, required LabelModel labelModel}) async {
    try {
      _logger.i('createOs 通信開始');
      final osData =
          _convertOsToEntity(accountId: accountId, labelModel: labelModel);
      await db.tOsInfoDao.insertOs(osData: osData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('createOs 通信終了');
    }
  }

  /// OS 更新
  Future<void> updateOs(
      {required String accountId, required LabelModel labelModel}) async {
    try {
      _logger.i('updateOs 通信開始');
      final osData =
          _convertOsToEntity(accountId: accountId, labelModel: labelModel);
      await db.tOsInfoDao.updateOs(osData: osData);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('updateOs 通信終了');
    }
  }

  /// OS 削除
  Future<void> deleteOs(
      {required String accountId, required String osId}) async {
    try {
      _logger.i('deleteOs 通信開始');
      await db.tOsInfoDao.deleteOs(accountId: accountId, osId: osId);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('deleteOs 通信終了');
    }
  }

  /// 開発工程一覧取得
  Future<List<LabelModel>?> getDevProgressList() async {
    try {
      _logger.i('getDevProgressList 通信開始');
      final response = await db.select(db.mDevProgressList).get();
      _logger.i('取得数：${response.length}件');
      final responseData =
          _convertDevProgressToModel(devProgressList: response);

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
      final responseData = _convertTagToModel(
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
AccountModel _convertAccountToModel({required MAccountData accountData}) {
  return AccountModel(
      accountId: accountData.accountId,
      address: accountData.address,
      planType: getPlanType(accountData.planType));
}

/// color to model
List<ColorModel> _convertColorToModel({required List<MColorData> colorData}) {
  return colorData
      .map((item) => ColorModel(
          id: item.id, color: getColorFromCode(code: item.colorCodeId)))
      .toList();
}

/// DB to model
List<LabelModel> _convertDbToModel({required List<TDbData> dbList}) {
  return dbList
      .map((item) => LabelModel(id: item.dbId, labelName: item.name))
      .toList();
}

/// DB to entity
TDbCompanion _convertDbToEntity({
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

/// Git to model
List<LabelModel> _convertGitToModel({required List<TGitData> gitList}) {
  return gitList
      .map((item) => LabelModel(id: item.gitId, labelName: item.name))
      .toList();
}

/// Git to entity
TGitCompanion _convertGitToEntity({
  required String accountId,
  required LabelModel labelModel,
}) {
  return TGitCompanion(
    gitId: Value(labelModel.id),
    name: Value(
      labelModel.labelName,
    ),
    accountId: Value(accountId),
    updateAt: Value(DateTime.now().toIso8601String()),
  );
}

/// Mw to model
List<LabelModel> _convertMwToModel({required List<TMwData> mwList}) {
  return mwList
      .map((item) => LabelModel(id: item.mwId, labelName: item.name))
      .toList();
}

/// Mw to entity
TMwCompanion _convertMwToEntity({
  required String accountId,
  required LabelModel labelModel,
}) {
  return TMwCompanion(
    mwId: Value(labelModel.id),
    name: Value(
      labelModel.labelName,
    ),
    accountId: Value(accountId),
    updateAt: Value(DateTime.now().toIso8601String()),
  );
}

/// Tool to model
List<LabelModel> _convertToolToModel({required List<TToolData> toolList}) {
  return toolList
      .map((item) => LabelModel(id: item.toolId, labelName: item.name))
      .toList();
}

/// Tool to entity
TToolCompanion _convertToolToEntity({
  required String accountId,
  required LabelModel labelModel,
}) {
  return TToolCompanion(
    toolId: Value(labelModel.id),
    name: Value(
      labelModel.labelName,
    ),
    accountId: Value(accountId),
    updateAt: Value(DateTime.now().toIso8601String()),
  );
}

/// OS to model
List<LabelModel> _convertOsToModel({required List<TOsInfoData> osList}) {
  return osList
      .map((item) => LabelModel(id: item.osId, labelName: item.name))
      .toList();
}

/// OS to entity
TOsInfoCompanion _convertOsToEntity({
  required String accountId,
  required LabelModel labelModel,
}) {
  return TOsInfoCompanion(
    osId: Value(labelModel.id),
    name: Value(
      labelModel.labelName,
    ),
    accountId: Value(accountId),
    updateAt: Value(DateTime.now().toIso8601String()),
  );
}

/// dev progress to model
List<LabelModel> _convertDevProgressToModel(
    {required List<MDevProgressListData> devProgressList}) {
  return devProgressList
      .map((item) => LabelModel(id: item.id.toString(), labelName: item.name))
      .toList();
}

List<ColorLabelModel> _convertTagToModel({
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
