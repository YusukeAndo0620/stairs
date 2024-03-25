import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/feature/project/enum/project_update_param.dart';
import 'package:stairs/feature/project/model/project_detail_model.dart';
import 'package:stairs/feature/project/model/project_list_item_model.dart';
import 'package:stairs/loom/loom_package.dart';

class ProjectRepository {
  ProjectRepository({required this.db});

  final StairsDatabase db;

  final _logger = stairsLogger(name: 'project_repository');

  /// プロジェクト一覧取得
  Future<List<ProjectListItemModel>?> getProjectList({
    required String accountId,
  }) async {
    try {
      _logger.i('getProjectList 開始');
      final response =
          await db.tProjectDao.getProjectList(accountId: accountId);

      _logger.i('取得データ length: ${response.length}');
      final List<ProjectListItemModel> responseData = [];
      for (final row in response) {
        responseData.add(_convertProjectListToModel(
            projectData: row.readTable(db.tProject),
            colorData: row.readTable(db.mColor)));
      }
      _logger.d('responseData: $responseData');
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
      final osResponse = await db.tOsRelDao.getOsRelList(projectId: projectId);

      // DB
      final dbResponse = await db.tDbRelDao.getDbRelList(projectId: projectId);

      // 開発言語
      final devLangResponse =
          await db.tDevLangRelDao.getDevLangList(projectId: projectId);

      // Git
      final gitResponse =
          await db.tGitRelDao.getGitRelList(projectId: projectId);

      // ミドルウェア
      final mwResponse = await db.tMwRelDao.getMwRelList(projectId: projectId);

      // 開発ツール
      final toolResponse =
          await db.tToolRelDao.getToolRelList(projectId: projectId);

      // 開発工程
      final devProgressResponse =
          await db.tDevProgressRelDao.getDevProgressList(projectId: projectId);

      // タグ紐付け
      final tagResponse = await db.tTagRelDao.getTagList(projectId: projectId);

      final responseData = _convertProjectDetailToModel(
        projectData: detailResponse.readTable(db.tProject),
        colorData: detailResponse.readTable(db.mColor),
        osData: osResponse
            .map((e) => e.readTableOrNull(db.tOsRel))
            .whereType<TOsRelData>()
            .toList(),
        dbRelData: dbResponse
            .map((e) => e.readTableOrNull(db.tDbRel))
            .whereType<TDbRelData>()
            .toList(),
        devLangData: devLangResponse
            .map((e) => e.readTableOrNull(db.tDevLanguage))
            .whereType<TDevLanguageData>()
            .toList(),
        devLangRelData: devLangResponse
            .map((e) => e.readTable(db.tDevLanguageRel))
            .toList(),
        gitRelData: gitResponse.map((e) => e.readTable(db.tGitRel)).toList(),
        mwRelData: mwResponse.map((e) => e.readTable(db.tMwRel)).toList(),
        toolRelData: toolResponse.map((e) => e.readTable(db.tToolRel)).toList(),
        devProgressRelData: devProgressResponse,
        tagData: tagResponse.map((e) => e.readTable(db.tTag)).toList(),
        tagRelData: tagResponse.map((e) => e.readTable(db.tTagRel)).toList(),
        tagColorData: tagResponse.map((e) => e.readTable(db.mColor)).toList(),
      );

      _logger.d(
          'projectId: ${responseData.projectId}, projectName: ${responseData.projectName}');
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

      final osRelDataList = detailModel.osIdList
          .map((osId) => db.tOsRelDao.convertOsRelToEntity(
              projectId: detailModel.projectId, osId: osId))
          .toList();

      final dbRelDataList = detailModel.dbIdList
          .map((dbId) => db.tDbRelDao.convertDbRelToEntity(
              projectId: detailModel.projectId, dbId: dbId))
          .toList();

      final devLangDataList = detailModel.devLanguageList
          .map((item) => db.tDevLangRelDao.convertDevLangRelToEntity(
              projectId: detailModel.projectId, model: item))
          .toList();

      final gitRelDataList = detailModel.gitIdList
          .map((gitId) => db.tGitRelDao.convertGitRelToEntity(
              projectId: detailModel.projectId, gitId: gitId))
          .toList()
          .whereType<TGitRelCompanion>()
          .toList();

      final mwRelDataList = detailModel.mwIdList
          .map((mwId) => db.tMwRelDao.convertMwRelToEntity(
              projectId: detailModel.projectId, mwId: mwId))
          .toList()
          .whereType<TMwRelCompanion>()
          .toList();

      final toolRelDataList = detailModel.toolIdList
          .map((toolId) => db.tToolRelDao.convertToolRelToEntity(
              projectId: detailModel.projectId, toolId: toolId))
          .toList()
          .whereType<TToolRelCompanion>()
          .toList();

      final devProgressDataList = detailModel.devProgressIdList
          .map((id) => db.tDevProgressRelDao.convertDevProgressToEntity(
              projectId: detailModel.projectId,
              devProgressId: int.tryParse(id) ?? 0))
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
      for (final item in osRelDataList) {
        await db.tOsRelDao.insertOsRel(osRelData: item);
      }
      // DB紐付け 作成
      for (final item in dbRelDataList) {
        await db.tDbRelDao.insertDbRel(dbRelData: item);
      }
      // 開発言語紐付け 作成
      for (final item in devLangDataList) {
        await db.tDevLangRelDao.insertDevLanguage(devLangData: item);
      }
      // Git 作成
      for (final item in gitRelDataList) {
        await db.tGitRelDao.insertGitRel(gitRelData: item);
      }
      // ミドルウェア 作成
      for (final item in mwRelDataList) {
        await db.tMwRelDao.insertMwRel(mwRelData: item);
      }
      // 開発ツール 作成
      for (final item in toolRelDataList) {
        await db.tToolRelDao.insertToolRel(toolRelData: item);
      }
      // 開発工程 作成
      for (final item in devProgressDataList) {
        await db.tDevProgressRelDao.insertDevProgress(devProgressData: item);
      }
      // タグ紐付け 作成
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
  Future<void> updateProject(
      {required ProjectDetailModel detailModel,
      required List<ProjectUpdateParam> updateTargetList}) async {
    try {
      _logger.i('updateProject 開始');
      _logger.i('projectId: ${detailModel.projectId}');
      await db.transaction(() async {
        for (final param in updateTargetList.toSet().toList()) {
          switch (param) {
            // プロジェクト情報
            case ProjectUpdateParam.project:
              _logger.d('プロジェクト情報 更新');
              final projectData =
                  _convertProjectDetailToEntity(detailModel: detailModel);
              await db.tProjectDao.updateProject(projectData: projectData);
            // OS
            case ProjectUpdateParam.os:
              _logger.d('OS 更新');
              final osRelDataList = detailModel.osIdList
                  .map((osId) => db.tOsRelDao.convertOsRelToEntity(
                      projectId: detailModel.projectId, osId: osId))
                  .toList();
              // OS 削除
              await db.tOsRelDao
                  .deleteOsRelByProjectId(projectId: detailModel.projectId);
              // OS 作成
              for (final item in osRelDataList) {
                await db.tOsRelDao.insertOsRel(osRelData: item);
              }
            // DB
            case ProjectUpdateParam.db:
              _logger.d('DB 更新');
              final dbRelDataList = detailModel.dbIdList
                  .map((dbId) => db.tDbRelDao.convertDbRelToEntity(
                      projectId: detailModel.projectId, dbId: dbId))
                  .toList();
              // DB 削除
              await db.tDbRelDao
                  .deleteDbRelByProjectId(projectId: detailModel.projectId);
              // DB 作成
              for (final item in dbRelDataList) {
                await db.tDbRelDao.insertDbRel(dbRelData: item);
              }
            // 開発言語紐付け
            case ProjectUpdateParam.devLangRel:
              _logger.d('開発言語 更新');
              final devLangDataList = detailModel.devLanguageList
                  .map((item) => db.tDevLangRelDao.convertDevLangRelToEntity(
                      projectId: detailModel.projectId, model: item))
                  .toList();
              // 開発言語紐付け 削除
              await db.tDevLangRelDao
                  .deleteDevLangByProjectId(projectId: detailModel.projectId);
              // 開発言語紐付け 作成
              for (final item in devLangDataList) {
                await db.tDevLangRelDao.insertDevLanguage(devLangData: item);
              }
            // Git
            case ProjectUpdateParam.git:
              _logger.d('Git 更新');
              final gitRelDataList = detailModel.gitIdList
                  .map((gitId) => db.tGitRelDao.convertGitRelToEntity(
                      projectId: detailModel.projectId, gitId: gitId))
                  .toList()
                  .whereType<TGitRelCompanion>()
                  .toList();
              // Git 削除
              await db.tGitRelDao
                  .deleteGitRelByProjectId(projectId: detailModel.projectId);
              // Git 作成
              for (final item in gitRelDataList) {
                await db.tGitRelDao.insertGitRel(gitRelData: item);
              }
            // ミドルウェア
            case ProjectUpdateParam.mw:
              _logger.d('ミドルウェア 更新');
              final mwRelDataList = detailModel.mwIdList
                  .map((mwId) => db.tMwRelDao.convertMwRelToEntity(
                      projectId: detailModel.projectId, mwId: mwId))
                  .toList()
                  .whereType<TMwRelCompanion>()
                  .toList();
              // ミドルウェア 削除
              await db.tMwRelDao
                  .deleteMwRelByProjectId(projectId: detailModel.projectId);
              // ミドルウェア 作成
              for (final item in mwRelDataList) {
                await db.tMwRelDao.insertMwRel(mwRelData: item);
              }
            // 開発ツール
            case ProjectUpdateParam.tool:
              _logger.d('開発ツール 更新');
              final toolRelDataList = detailModel.toolIdList
                  .map((toolId) => db.tToolRelDao.convertToolRelToEntity(
                      projectId: detailModel.projectId, toolId: toolId))
                  .whereType<TToolRelCompanion>()
                  .toList();
              // 開発ツール 削除
              await db.tToolRelDao
                  .deleteToolRelByProjectId(projectId: detailModel.projectId);
              // 開発ツール 作成
              for (final item in toolRelDataList) {
                await db.tToolRelDao.insertToolRel(toolRelData: item);
              }
            // 開発工程(delete & insert)
            case ProjectUpdateParam.devProgress:
              _logger.d('開発工程 更新');
              final devProgressDataList = detailModel.devProgressIdList
                  .map((id) => db.tDevProgressRelDao.convertDevProgressToEntity(
                      projectId: detailModel.projectId,
                      devProgressId: int.tryParse(id) ?? 0))
                  .whereType<TDevProgressRelCompanion>()
                  .toList();
              // 開発工程 削除
              await db.tDevProgressRelDao.deleteDevProgressByProjectId(
                  projectId: detailModel.projectId);
              // 開発工程 作成
              for (final item in devProgressDataList) {
                await db.tDevProgressRelDao
                    .insertDevProgress(devProgressData: item);
              }
            // タグ
            case ProjectUpdateParam.tag:
              _logger.d('タグ 更新');
              final tagDataList = detailModel.tagList
                  .map((item) => db.tTagRelDao.convertTagToEntity(
                      id: int.tryParse(item.id),
                      projectId: detailModel.projectId,
                      model: item))
                  .whereType<TTagRelCompanion>()
                  .toList();
              // プロジェクトで登録されているタグ紐付け情報取得
              final currentTagList = await db.tTagRelDao
                  .getTagList(projectId: detailModel.projectId);
              // プロジェクトで登録されているタグ紐付けIDのリスト
              final idList = currentTagList
                  .map((e) => e.readTable(db.tTagRel).id)
                  .toList();
              // 更新対象のタグ紐付けIDのリスト
              final targetIdList = tagDataList.map((e) => e.id.value).toList();
              // 削除対象のタグ紐付けIDリスト
              final deleteIdList = idList
                  .map((e) => !targetIdList.contains(e) ? e : null)
                  .whereType<int>()
                  .toList();

              // タグ紐付け 更新
              for (final item in tagDataList) {
                // すでに登録済みのタグは更新
                if (idList.contains(item.id.value)) {
                  await db.tTagRelDao.updateTag(tagData: item);
                  // 削除対象のため削除
                } else if (deleteIdList.contains(item.id.value)) {
                  // タグ紐付け 削除
                  await db.tTagRelDao.deleteTagByKey(id: item.id.value);
                  // 追加
                } else {
                  // タグ紐付け 作成
                  await db.tTagRelDao.insertTag(tagData: item);
                }
              }
          }
        }
      });
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
  required List<TOsRelData> osData,
  required List<TDbRelData> dbRelData,
  required List<TDevLanguageData> devLangData,
  required List<TDevLanguageRelData> devLangRelData,
  required List<TGitRelData> gitRelData,
  required List<TMwRelData> mwRelData,
  required List<TToolRelData> toolRelData,
  required List<TDevProgressRelData> devProgressRelData,
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
    // idはTagRelのidとする
    tagList.add(
      ColorLabelModel(
        id: tagRelData[i].id.toString(),
        labelName: tagData[i].name,
        isReadOnly: tagData[i].isReadOnly,
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
    devMethodType: getDevMethodType(projectData.devMethodType),
    description: projectData.description,
    devSize: projectData.devSize,
    displayCount: projectData.displayCount,
    tableCount: projectData.tableCount,
    startDate: DateTime.parse(projectData.startDate).toLocal(),
    endDate: DateTime.parse(projectData.endDate).toLocal(),
    osIdList: osData.map((item) => item.osId).toList(),
    dbIdList: dbRelData.map((item) => item.dbId).toList(),
    devLanguageList: devLangList,
    gitIdList: gitRelData.map((item) => item.gitId).toList(),
    mwIdList: mwRelData.map((item) => item.mwId).toList(),
    toolIdList: toolRelData.map((item) => item.toolId).toList(),
    devProgressIdList: devProgressRelData
        .map((item) => item.devProgressId.toString())
        .toList(),
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
    devMethodType: Value(detailModel.devMethodType.typeValue),
    description: Value(detailModel.description),
    devSize: Value(detailModel.devSize),
    displayCount: Value(detailModel.displayCount),
    tableCount: Value(detailModel.tableCount),
    startDate: Value(detailModel.startDate.toIso8601String()),
    endDate: Value(detailModel.endDate.toIso8601String()),
    accountId: const Value('1'),
    updateAt: Value(DateTime.now().toIso8601String()),
  );
}
