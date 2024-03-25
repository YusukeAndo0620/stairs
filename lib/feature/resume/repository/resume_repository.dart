import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/feature/project/enum/project_update_param.dart';
import 'package:stairs/feature/project/model/project_detail_model.dart';
import 'package:stairs/feature/project/repository/project_repository.dart';
import 'package:stairs/feature/resume/model/resume_model.dart';
import 'package:stairs/feature/resume/model/resume_project_model.dart';
import 'package:stairs/feature/resume/model/resume_tag_model.dart';
import 'package:stairs/loom/loom_package.dart';

class ResumeRepository {
  ResumeRepository({required this.db});

  final StairsDatabase db;

  final _logger = stairsLogger(name: 'resume_repository');

  /// 経歴書取得
  Future<ResumeModel?> getResume({
    required String accountId,
  }) async {
    try {
      _logger.i('getResume 開始');

      // アカウント取得
      final accountResponse =
          await db.mAccountDao.getAccountById(accountId: accountId);

      // 国名取得
      final countryCodeResponse = await db.mCountryCodeDao
          .getCountryByCode(countryCode: accountResponse.countryCode);

      // 経歴書 > プロジェクト
      final List<ResumeProjectModel> resumeProjectList = [];

      // 既存プロジェクト取得
      final projectRepository = ProjectRepository(db: db);
      final projectList =
          await projectRepository.getProjectList(accountId: accountId);
      for (final project in projectList!) {
        final projectDetail = await projectRepository.getProjectDetail(
            projectId: project.projectId);
        if (projectDetail == null) {
          continue;
        }
        // プロジェクト単位でタスクに紐づくタグを全て取得
        final tagRelResponse = await db.tTagRelDao
            .getTagWithTaskList(projectId: project.projectId);

        resumeProjectList.add(
          _convertResumeProjectToModel(
            projectId: projectDetail.projectId,
            projectName: projectDetail.projectName,
            industry: projectDetail.industry,
            devMethodType: projectDetail.devMethodType,
            description: projectDetail.description,
            devSize: projectDetail.devSize,
            displayCount: projectDetail.displayCount,
            tableCount: projectDetail.tableCount,
            startDate: projectDetail.startDate,
            endDate: projectDetail.endDate,
            roleList: [],
            devLanguageList: projectDetail.devLanguageList,
            osIdList: projectDetail.osIdList,
            devEnvIdList: [],
            dbIdList: projectDetail.dbIdList,
            mwIdList: projectDetail.mwIdList,
            gitIdList: projectDetail.gitIdList,
            toolIdList: projectDetail.toolIdList,
            devProgressIdList: projectDetail.devProgressIdList,
            tagList: _convertResumeTagModelList(
              tagRelData:
                  tagRelResponse.map((e) => e.readTable(db.tTagRel)).toList(),
              taskTagData:
                  tagRelResponse.map((e) => e.readTable(db.tTaskTag)).toList(),
              taskDevData:
                  tagRelResponse.map((e) => e.readTable(db.tTaskDev)).toList(),
            ),
          ),
        );
      }

      // 経歴書画面で追加されたプロジェクト取得
      final projectResumeResponse = await db.tResumeProjectDao
          .getResumeProject(accountId: accountResponse.accountId);

      for (final resumeProject in projectResumeResponse) {
        // OS
        final resumeOsResponse = await db.tResumeOsRelDao
            .getResumeOsRelList(resumeProjectId: resumeProject.resumeProjectId);

        // DB
        final resumeDbResponse = await db.tResumeDbDao
            .getResumeDbList(resumeProjectId: resumeProject.resumeProjectId);

        // 開発言語
        final resumeDevLangResponse = await db.tResumeDevLangDao
            .getResumeDevLangList(
                resumeProjectId: resumeProject.resumeProjectId);

        // 開発言語モデル生成
        final List<LabelWithContent> devLangLabelList = [];

        // 開発言語一覧(言語名をセットするために使用)
        final devLangList = resumeDevLangResponse
            .map((e) => e.readTable(db.tDevLanguage))
            .toList();
        for (final devLang in resumeDevLangResponse
            .map((e) => e.readTable(db.tResumeDevLang))
            .toList()) {
          devLangLabelList.add(LabelWithContent(
            id: devLang.id.toString(),
            labelId: devLang.devLangId,
            labelName: devLangList
                .firstWhere((element) => element.devLangId == devLang.devLangId)
                .name,
            content: devLang.content,
          ));
        }

        // Git
        final resumeGitResponse = await db.tResumeGitDao
            .getResumeGitList(resumeProjectId: resumeProject.resumeProjectId);

        // ミドルウェア
        final resumeMwResponse = await db.tResumeMwDao
            .getResumeMwList(resumeProjectId: resumeProject.resumeProjectId);

        // 役割
        final resumeRoleResponse = await db.tResumeRoleDao
            .getResumeRoleList(resumeProjectId: resumeProject.resumeProjectId);

        // 開発ツール
        final resumeToolResponse = await db.tResumeToolDao
            .getResumeToolList(resumeProjectId: resumeProject.resumeProjectId);

        // 開発工程
        final resumeDevProgressResponse = await db.tResumeDevProgressDao
            .getResumeDevProgressList(
                resumeProjectId: resumeProject.resumeProjectId);

        // タグ紐付け
        final resumeTagResponse = await db.tResumeTagDao
            .getResumeTagList(resumeProjectId: resumeProject.resumeProjectId);

        // タグモデル生成
        final List<ResumeTagModel> tagList = [];
        for (final tag in resumeTagResponse
            .map((e) => e.readTable(db.tResumeTag))
            .toList()) {
          tagList.add(
            _convertResumeTagModel(
              id: tag.id.toString(),
              labelId: tag.tagId.toString(),
              devLangId: tag.devLangId,
              taskCount: tag.taskCount,
            ),
          );
        }

        resumeProjectList.add(
          _convertResumeProjectToModel(
            projectId: resumeProject.resumeProjectId,
            projectName: resumeProject.name,
            industry: resumeProject.industry,
            devMethodType: getDevMethodType(resumeProject.devMethodCode),
            description: resumeProject.description,
            devSize: resumeProject.devSize,
            displayCount: resumeProject.displayCount,
            tableCount: resumeProject.tableCount,
            startDate: DateTime.parse(resumeProject.startDate).toLocal(),
            endDate: DateTime.parse(resumeProject.startDate).toLocal(),
            roleList:
                resumeRoleResponse.map((e) => getRoleType(e.code)).toList(),
            devLanguageList: devLangLabelList,
            osIdList: resumeOsResponse
                .map((e) => e.readTable(db.tResumeOsRel).osId)
                .toList(),
            devEnvIdList: [],
            dbIdList: resumeDbResponse
                .map((e) => e.readTable(db.tResumeDb).dbId)
                .toList(),
            mwIdList: resumeMwResponse
                .map((e) => e.readTable(db.tResumeMw).mwId)
                .toList(),
            gitIdList: resumeGitResponse
                .map((e) => e.readTable(db.tResumeGit).gitId)
                .toList(),
            toolIdList: resumeToolResponse
                .map((e) => e.readTable(db.tResumeTool).toolId)
                .toList(),
            devProgressIdList: resumeDevProgressResponse
                .map((e) => e
                    .readTable(db.tResumeDevProgressList)
                    .devProgressId
                    .toString())
                .toList(),
            tagList: tagList,
          ),
        );
      }

      return _convertResumeToModel(
          accountData: accountResponse,
          countryCodeData: countryCodeResponse,
          projectResumeData: projectResumeResponse);
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getResume 終了');
    }
  }

  /// 経歴書更新
  Future<void> updateResume(
      {required ProjectDetailModel detailModel,
      required List<ProjectUpdateParam> updateTargetList}) async {
    try {
      _logger.i('updateResume 開始');
      await db.transaction(() async {
        // アカウント取得
        final accountResponse = await db.mAccountDao.getAccount();

        // プロジェクト取得
        final projectResponse = await db.tProjectDao
            .getProjectList(accountId: accountResponse.accountId);

        for (final projectRow in projectResponse) {
          // プロジェクト単位でタスクに紐づくタグを全て取得
          final taskResponse = await db.tTaskDao.getTaskDetailByProjectId(
              projectId: projectRow.readTable(db.tProject).projectId);

          // プロジェクトで使用されている開発言語
          final projectDevLangResponse = await db.tDevLangRelDao.getDevLangList(
              projectId: projectRow.readTable(db.tProject).projectId);
        }
      });
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('updateResume 終了');
    }
  }
}

// 経歴書 entity to model
ResumeModel _convertResumeToModel({
  required MAccountData accountData,
  required MCountryCodeData countryCodeData,
  required List<TResumeProjectData> projectResumeData,
}) {
  return ResumeModel(
    name: accountData.firstName + accountData.lastName,
    sexType: accountData.isMale ? SexType.male : SexType.female,
    countryName: countryCodeData.japaneseName,
    age: (DateTime.now()
                .difference(DateTime.parse(accountData.birthDate).toLocal())
                .inDays /
            365)
        .floor(),
    academicBackground: accountData.academicBackground,
    strongTech: accountData.strongTech,
    strongPoint: accountData.strongPoint,
    qualification: '',
    skillDevLangList: const [],
    dbList: const [],
    skillOsIdList: const [],
    skillMwIdList: const [],
    skillGitIdList: const [],
    skillDevEnvIdList: const [],
    projectList: const [],
  );
}

// 経歴書 プロジェクト情報 model生成
ResumeProjectModel _convertResumeProjectToModel({
  required String projectId,
  required String projectName,
  required String industry,
  required DevMethodType devMethodType,
  required String description,
  required int devSize,
  required int displayCount,
  required int tableCount,
  required DateTime startDate,
  required DateTime endDate,
  required List<RoleType> roleList,
  required List<LabelWithContent> devLanguageList,
  required List<String> osIdList,
  required List<String> devEnvIdList,
  required List<String> dbIdList,
  required List<String> mwIdList,
  required List<String> gitIdList,
  required List<String> toolIdList,
  required List<String> devProgressIdList,
  required List<ResumeTagModel> tagList,
}) {
  return ResumeProjectModel(
    projectId: projectId,
    projectName: projectName,
    industry: industry,
    devMethodType: devMethodType,
    description: description,
    devSize: devSize,
    displayCount: displayCount,
    tableCount: tableCount,
    startDate: startDate,
    endDate: endDate,
    roleList: roleList,
    devLanguageList: devLanguageList,
    osIdList: osIdList,
    devEnvIdList: devEnvIdList,
    dbIdList: dbIdList,
    mwIdList: mwIdList,
    gitIdList: gitIdList,
    toolIdList: toolIdList,
    devProgressIdList: devProgressIdList,
    tagList: tagList,
  );
}

// 経歴書 タグ modelリスト生成
List<ResumeTagModel> _convertResumeTagModelList({
  required List<TTagRelData> tagRelData,
  required List<TTaskTagData> taskTagData,
  required List<TTaskDevData> taskDevData,
}) {
  final List<ResumeTagModel> list = [];
  for (var i = 0; i < tagRelData.length; i++) {
    // タグに紐づくタスクIDリスト
    final targetTaskIdList = taskTagData
        .map((e) => e.tagRelId == tagRelData[i].id ? e.taskId : null)
        .whereType<String>()
        .toList();
    // key: 開発言語ID, value: タスク数
    Map<String, int> taskCountMap = {};
    // 開発言語ごとにタスクの内訳を整理
    for (final taskId in targetTaskIdList) {
      final devLangId = taskDevData
          .firstWhere((element) => element.taskId == taskId)
          .devLangId;

      taskCountMap[devLangId] = taskCountMap.containsKey(devLangId)
          ? taskCountMap[devLangId]! + 1
          : 1;
    }
    for (final entity in taskCountMap.entries) {
      list.add(
        // idは経歴書画面より手動で追加されたプロジェクトのみ使用されるため
        // 既存プロジェクトのものは設定しない
        _convertResumeTagModel(
          id: '',
          labelId: tagRelData[i].tagId.toString(),
          devLangId: entity.key,
          taskCount: entity.value,
        ),
      );
    }
  }
  return list;
}

// 経歴書 タグ model生成
ResumeTagModel _convertResumeTagModel({
  required String id,
  required String labelId,
  required String devLangId,
  required int taskCount,
}) {
  return ResumeTagModel(
    id: id,
    labelId: labelId,
    devLangId: devLangId,
    taskCount: taskCount,
  );
}

// 経歴書 model to entity
TProjectCompanion _convertResumeToEntity({
  required ProjectDetailModel detailModel,
}) {
  return TProjectCompanion(
    projectId: Value(detailModel.projectId),
    name: Value(detailModel.projectName),
    colorId: Value(detailModel.themeColorModel.id),
    industry: Value(detailModel.industry),
    displayCount: Value(detailModel.displayCount),
    tableCount: Value(detailModel.tableCount),
    startDate: Value(detailModel.startDate.toIso8601String()),
    endDate: Value(detailModel.endDate.toIso8601String()),
    description: Value(detailModel.description),
    devSize: Value(detailModel.devSize),
    accountId: const Value('1'),
    updateAt: Value(DateTime.now().toIso8601String()),
  );
}
