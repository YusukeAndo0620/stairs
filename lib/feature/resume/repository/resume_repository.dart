import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/feature/project/enum/project_update_param.dart';
import 'package:stairs/feature/project/model/project_detail_model.dart';
import 'package:stairs/feature/resume/enum/project_column_type.dart';
import 'package:stairs/feature/resume/enum/skill_column_type.dart';
import 'package:stairs/feature/resume/model/resume_model.dart';
import 'package:stairs/loom/loom_package.dart' hide Row;

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

      // 経歴書 スキル取得
      final skillResponse = await db.tResumeSkillDao
          .getResumeSkill(accountId: accountResponse.accountId);
      // 経歴書 プロジェクト取得
      final projectResponse = await db.tResumeProjectDao
          .getResumeProject(accountId: accountResponse.accountId);

      return _convertResumeToModel(
          accountData: accountResponse,
          countryCodeData: countryCodeResponse,
          skillData: skillResponse,
          projectData: projectResponse);
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
  required List<TResumeSkillData> skillData,
  required List<TResumeProjectData> projectData,
}) {
  // スキルリスト key: SkillColumnType, value: Map<表示順, 値 >
  Map<SkillColumnType, Map<int, String>> skillMap = {};

  // プロジェクトMap key: 行番号, value: Map<ProjectColumnType, Map<表示順, 値>>
  Map<String, Map<ProjectColumnType, Map<int, String>>> projectMap = {};

  for (final item in skillData) {
    final skillColumnType = getSkillColumnTypeWithCol(item.columnCode);
    skillMap[skillColumnType]![item.orderNo] =
        item.editContent.isNotEmpty ? item.editContent : item.content;
  }

  for (final item in projectData) {
    final projectColumnType = getSkillColumnTypeWithCol(item.columnCode);
    projectMap[item.projectId]![projectColumnType]![item.orderNo] =
        item.editContent.isNotEmpty ? item.editContent : item.content;
  }

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
    skillMap: skillMap,
    projectMap: projectMap,
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
