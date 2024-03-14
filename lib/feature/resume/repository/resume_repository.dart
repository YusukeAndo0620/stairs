import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/feature/project/enum/project_update_param.dart';
import 'package:stairs/feature/project/model/project_detail_model.dart';
import 'package:stairs/feature/project/model/project_list_item_model.dart';
import 'package:stairs/feature/resume/model/resume_model.dart';
import 'package:stairs/loom/loom_package.dart' hide Row;

class ResumeRepository {
  ResumeRepository({required this.db});

  final StairsDatabase db;

  final _logger = stairsLogger(name: 'resume_repository');

  /// 経歴書取得
  Future<ResumeModel?> getResume({
    required String projectId,
  }) async {
    try {
      _logger.i('getResume 開始');

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

      return null;
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
      await db.transaction(() async {});
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
    skillMap: {},
    projectMap: {},
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
