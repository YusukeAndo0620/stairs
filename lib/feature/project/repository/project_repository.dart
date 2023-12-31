import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/feature/project/model/project_detail_model.dart';
import 'package:stairs/feature/project/model/project_list_item_model.dart';
import 'package:stairs/loom/loom_package.dart' hide Row;

class ProjectRepository {
  ProjectRepository({required this.db});

  final StairsDatabase db;

  final _logger = stairsLogger(name: 'project_repository');

  /// プロジェクト一覧取得
  Future<List<ProjectListItemModel>?> getProjectList() async {
    try {
      _logger.i('getProjectList 開始');
      final response = await db.tProjectDao.getProjectList();

      _logger.i('取得データ：$response,length: ${response.length}');
      final List<ProjectListItemModel> responseData = [];
      for (final row in response) {
        responseData.add(_convertProjectListToModel(
            projectData: row.readTable(db.tProject),
            colorData: row.readTable(db.mColor)));
      }

      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getProjectList 終了');
    }
  }

  /// プロジェクト詳細取得
  Future<ProjectDetailModel?> getProjectDetail({
    required String projectId,
  }) async {
    try {
      _logger.i('getProjectDetail 開始');

      // 詳細
      final detailResponse =
          await db.tProjectDao.getProjectDetail(projectId: projectId);

      // OS
      final osResponse = await db.tOsInfoDao.getOsList(projectId: projectId);

      // DB
      final dbResponse = await db.tDbDao.getDbList(projectId: projectId);

      // 開発言語
      final devLangResponse =
          await db.tDevLangRelDao.getDevLangList(projectId: projectId);

      // 開発ツール
      final toolResponse = await db.tToolDao.getToolList(projectId: projectId);

      // 開発工程
      final devProgressResponse =
          await db.tDevProgressRelDao.getDevProgressList(projectId: projectId);

      // タグ
      final tagResponse = await db.tTagRelDao.getTagList(projectId: projectId);

      final responseData = _convertProjectDetailToModel(
        projectData: detailResponse.readTable(db.tProject),
        colorData: detailResponse.readTable(db.mColor),
        osData: osResponse,
        dbData: dbResponse,
        mDevLangData: devLangResponse
            .map((e) => e.readTableOrNull(db.mDevLanguage))
            .toList()
            .whereType<MDevLanguageData>()
            .toList(),
        devLangData: devLangResponse
            .map((e) => e.readTableOrNull(db.tDevLanguage))
            .toList()
            .whereType<TDevLanguageData>()
            .toList(),
        devLangRelData: devLangResponse
            .map((e) => e.readTable(db.tDevLanguageRel))
            .toList(),
        toolData: toolResponse,
        devProgressData: devProgressResponse
            .map((e) => e.readTable(db.mDevProgressList))
            .toList(),
        tagData: tagResponse.map((e) => e.readTable(db.tTag)).toList(),
        tagRelData: tagResponse.map((e) => e.readTable(db.tTagRel)).toList(),
        tagColorData: tagResponse.map((e) => e.readTable(db.mColor)).toList(),
      );

      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getProjectDetail 終了');
    }
  }

  /// プロジェクト作成
  Future<void> createProject({required ProjectDetailModel detailModel}) async {
    try {
      _logger.i('createProject 開始');
      _logger.i('projectId: ${detailModel.projectId}');
      final projectData =
          _convertProjectDetailToEntity(detailModel: detailModel);

      final osDataList = detailModel.osList
          .map((item) => db.tOsInfoDao
              .convertOsToEntity(projectId: detailModel.projectId, model: item))
          .toList();

      final dbDataList = detailModel.dbList
          .map((item) => db.tDbDao
              .convertDbToEntity(projectId: detailModel.projectId, model: item))
          .toList();

      final devLangDataList = detailModel.devLanguageList
          .map((item) => db.tDevLangRelDao.convertDevLangRelToEntity(
              projectId: detailModel.projectId, model: item))
          .toList();

      final toolDataList = detailModel.toolList
          .map((item) => db.tToolDao.convertToolToEntity(
              projectId: detailModel.projectId, model: item))
          .toList()
          .whereType<TToolCompanion>()
          .toList();

      final devProgressDataList = detailModel.devProgressList
          .map((item) => db.tDevProgressRelDao.convertDevProgressToEntity(
              projectId: detailModel.projectId, model: item))
          .toList()
          .whereType<TDevProgressRelCompanion>()
          .toList();

      final tagDataList = detailModel.tagList
          .map((item) => db.tTagRelDao.convertTagToEntity(
              projectId: detailModel.projectId, model: item))
          .toList()
          .whereType<TTagRelCompanion>()
          .toList();

      // プロジェクト作成
      await db.tProjectDao.insertProject(projectData: projectData);
      // OS 作成
      for (final item in osDataList) {
        await db.tOsInfoDao.insertOs(osData: item);
      }
      // DB 作成
      for (final item in dbDataList) {
        await db.tDbDao.insertDb(dbData: item);
      }
      // 開発言語紐付け 作成
      for (final item in devLangDataList) {
        await db.tDevLangRelDao.insertDevLanguage(devLangData: item);
      }
      // 開発ツール 作成
      for (final item in toolDataList) {
        await db.tToolDao.insertTool(toolData: item);
      }
      // 開発工程 作成
      for (final item in devProgressDataList) {
        await db.tDevProgressRelDao.insertDevProgress(devProgressData: item);
      }
      // タグ 作成
      for (final item in tagDataList) {
        await db.tTagRelDao.insertTag(tagData: item);
      }
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('createProject 終了');
    }
  }

  /// プロジェクト更新
  Future<void> updateProject({required ProjectDetailModel detailModel}) async {
    try {
      _logger.i('updateProject 開始');
      _logger.i('projectId: ${detailModel.projectId}');
      final projectData =
          _convertProjectDetailToEntity(detailModel: detailModel);

      final osDataList = detailModel.osList
          .map((item) => db.tOsInfoDao
              .convertOsToEntity(projectId: detailModel.projectId, model: item))
          .toList();

      final dbDataList = detailModel.dbList
          .map((item) => db.tDbDao
              .convertDbToEntity(projectId: detailModel.projectId, model: item))
          .toList();

      final devLangDataList = detailModel.devLanguageList
          .map((item) => db.tDevLangRelDao.convertDevLangRelToEntity(
              projectId: detailModel.projectId, model: item))
          .toList();

      final toolDataList = detailModel.toolList
          .map((item) => db.tToolDao.convertToolToEntity(
              projectId: detailModel.projectId, model: item))
          .toList()
          .whereType<TToolCompanion>()
          .toList();

      final devProgressDataList = detailModel.devProgressList
          .map((item) => db.tDevProgressRelDao.convertDevProgressToEntity(
              projectId: detailModel.projectId, model: item))
          .toList()
          .whereType<TDevProgressRelCompanion>()
          .toList();

      final tagDataList = detailModel.tagList
          .map((item) => db.tTagRelDao.convertTagToEntity(
              projectId: detailModel.projectId, model: item))
          .toList()
          .whereType<TTagRelCompanion>()
          .toList();

      // プロジェクト情報 更新
      await db.tProjectDao.updateProject(projectData: projectData);
      // OS 削除
      await db.tOsInfoDao.deleteOsByProjectId(projectId: detailModel.projectId);
      // OS 作成
      for (final item in osDataList) {
        await db.tOsInfoDao.insertOs(osData: item);
      }
      // DB 削除
      await db.tDbDao.deleteDbByProjectId(projectId: detailModel.projectId);
      // DB 作成
      for (final item in dbDataList) {
        await db.tDbDao.insertDb(dbData: item);
      }
      // 開発言語紐付け 削除
      await db.tDevLangRelDao
          .deleteDevLangByProjectId(projectId: detailModel.projectId);
      // 開発言語紐付け 作成
      for (final item in devLangDataList) {
        await db.tDevLangRelDao.insertDevLanguage(devLangData: item);
      }
      // 開発ツール 削除
      await db.tToolDao.deleteToolByProjectId(projectId: detailModel.projectId);
      // 開発ツール 作成
      for (final item in toolDataList) {
        await db.tToolDao.insertTool(toolData: item);
      }
      // 開発工程 削除
      await db.tDevProgressRelDao
          .deleteDevProgressByProjectId(projectId: detailModel.projectId);
      // 開発工程 作成
      for (final item in devProgressDataList) {
        await db.tDevProgressRelDao.insertDevProgress(devProgressData: item);
      }
      // タグ 削除
      await db.tTagRelDao
          .deleteTagByProjectId(projectId: detailModel.projectId);
      // タグ 作成
      for (final item in tagDataList) {
        await db.tTagRelDao.insertTag(tagData: item);
      }
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('updateProject 終了');
    }
  }
}

// プロジェクト一覧 entity to model
ProjectListItemModel _convertProjectListToModel({
  required TProjectData projectData,
  required MColorData colorData,
}) {
  return ProjectListItemModel(
    projectId: projectData.projectId,
    projectName: projectData.name,
    themeColorModel: ColorModel(
      id: colorData.id,
      color: getColorFromCode(code: colorData.colorCodeId),
    ),
  );
}

// プロジェクト詳細 entity to model
ProjectDetailModel _convertProjectDetailToModel({
  required TProjectData projectData,
  required MColorData colorData,
  required List<TOsInfoData> osData,
  required List<TDbData> dbData,
  required List<MDevLanguageData> mDevLangData,
  required List<TDevLanguageData> devLangData,
  required List<TDevLanguageRelData> devLangRelData,
  required List<TToolData> toolData,
  required List<MDevProgressListData> devProgressData,
  required List<TTagData> tagData,
  required List<TTagRelData> tagRelData,
  required List<MColorData> tagColorData,
}) {
  // 開発言語
  final List<LabelWithContent> devLangList = [];

  // タグリスト
  final List<ColorLabelModel> tagList = [];

  for (var i = 0; i < devLangRelData.length; i++) {
    devLangList.add(
      LabelWithContent(
        id: devLangRelData[i].id.toString(),
        labelId: mDevLangData.isNotEmpty
            ? mDevLangData[i].devLangId
            : devLangData[i].devLangId,
        labelName: mDevLangData.isNotEmpty
            ? mDevLangData[i].name
            : devLangData[i].name,
        content: devLangRelData[i].content,
      ),
    );
  }

  for (var i = 0; i < tagRelData.length; i++) {
    tagList.add(
      ColorLabelModel(
        id: tagData[i].id.toString(),
        labelName: tagData[i].name,
        colorModel: ColorModel(
            id: tagColorData[i].id,
            color: getColorFromCode(code: tagColorData[i].colorCodeId)),
      ),
    );
  }

  return ProjectDetailModel(
    projectId: projectData.projectId,
    projectName: projectData.name,
    themeColorModel: ColorModel(
      id: colorData.id,
      color: getColorFromCode(code: colorData.colorCodeId),
    ),
    industry: projectData.industry,
    displayCount: projectData.displayCount,
    startDate: DateTime.parse(projectData.startDate).toLocal(),
    endDate: DateTime.parse(projectData.endDate).toLocal(),
    description: projectData.description,
    osList: osData
        .map((item) => LabelModel(id: item.osId, labelName: item.name))
        .toList(),
    dbList: dbData
        .map((item) => LabelModel(id: item.dbId, labelName: item.name))
        .toList(),
    devLanguageList: devLangList,
    toolList: toolData
        .map((item) => LabelModel(id: item.toolId, labelName: item.name))
        .toList(),
    devProgressList: devProgressData
        .map((item) => LabelModel(id: item.id.toString(), labelName: item.name))
        .toList(),
    devSize: projectData.devSize,
    tagList: tagList,
  );
}

// プロジェクト詳細 model to entity
TProjectCompanion _convertProjectDetailToEntity({
  required ProjectDetailModel detailModel,
}) {
  return TProjectCompanion(
    projectId: Value(detailModel.projectId),
    name: Value(detailModel.projectName),
    colorId: Value(detailModel.themeColorModel.id),
    industry: Value(detailModel.industry),
    displayCount: Value(detailModel.displayCount),
    startDate: Value(detailModel.startDate.toIso8601String()),
    endDate: Value(detailModel.endDate.toIso8601String()),
    description: Value(detailModel.description),
    devSize: Value(detailModel.devSize),
    accountId: const Value('1'),
    updateAt: Value(DateTime.now().toIso8601String()),
  );
}
