import 'package:flutter/services.dart';
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
      _logger.i('getProjectList 通信開始');
      final response = await db.tProjectDao.getProjectList();

      _logger.i('取得データ：$response,length: ${response.length}');
      final List<ProjectListItemModel> responseData = [];
      for (final row in response) {
        responseData.add(_convertTProjectToListModel(
            projectData: row.readTable(db.tProject),
            colorData: row.readTable(db.mColor)));
      }

      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getProjectList 通信終了');
    }
  }

  /// プロジェクト詳細取得
  Future<ProjectDetailModel?> getProjectDetail({
    required String projectId,
  }) async {
    try {
      _logger.i('getProjectDetail 通信開始');

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

      final responseData = _convertTProjectToDetailModel(
        projectData: detailResponse.readTable(db.tProject),
        colorData: detailResponse.readTable(db.mColor),
        osData: osResponse,
        dbData: dbResponse,
        devLangData:
            devLangResponse.map((e) => e.readTable(db.tDevLanguage)).toList(),
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
      _logger.i('getProjectDetail 通信終了');
    }
  }

  /// プログラミング言語一覧取得
  Future<List<LabelModel>?> getDevLanguageList() async {
    try {
      _logger.i('getDevLanguageList 通信開始');
      final response = await db.tDevLangDao.getDevLangList(accountId: "1");
      List<LabelModel> responseData = [];
      for (final item in response) {
        responseData.add(LabelModel(id: item.devLangId, labelName: item.name));
      }
      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getDevLanguageList 通信終了');
    }
  }
}

ProjectListItemModel _convertTProjectToListModel({
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

ProjectDetailModel _convertTProjectToDetailModel({
  required TProjectData projectData,
  required MColorData colorData,
  required List<TOsInfoData> osData,
  required List<TDbData> dbData,
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
        labelId: devLangData[i].devLangId,
        labelName: devLangData[i].name,
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
