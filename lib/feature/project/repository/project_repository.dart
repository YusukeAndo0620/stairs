import 'package:flutter/services.dart';
import 'package:stairs/feature/project/model/project_detail_model.dart';
import 'package:stairs/feature/project/model/project_list_item_model.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:collection/collection.dart';

class ProjectRepository {
  ProjectRepository();

  final _logger = stairsLogger(name: 'project_repository');

  /// プロジェクト一覧取得
  Future<List<ProjectListItemModel>?> getProjectList() async {
    // final Dio dio = Dio();
    // const url = 'https://xxxxxxx';
    // API通信結果
    // final response = await dio.get(url);
    // if (response.statusCode == 200) {
    try {
      _logger.i('getProjectList 通信開始');
      // final responseData = response.data;
      //TODO: 仮データで上書き

      // final responseData = await rootBundle.loadString('json/list_dummy.json');
      // _logger.i('取得データ：$responseData');
      // final jsonResponse = json.decode(responseData)["projectList"];
      // final List<dynamic> dataList = jsonResponse.toList();
      // final List<ProjectListItemModel> brandList = [];
      // for (final data in dataList) {
      //   final model = ProjectListItemModel.fromJson(data);
      //   brandList.add(model);
      // }
      // return brandList;
      final responseData = dummyProjectList;
      _logger.i('取得データ：$responseData');
      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getProjectList 通信終了');
    }
    // }
  }

  /// プロジェクト詳細取得
  Future<ProjectDetailModel?> getProjectDetail({
    required String projectId,
  }) async {
    // final Dio dio = Dio();
    // const url = 'https://xxxxxxx';
    // API通信結果
    // final response = await dio.get(url);
    // if (response.statusCode == 200) {
    try {
      _logger.i('getProjectDetail 通信開始');
      // final responseData = response.data;
      //TODO: 仮データで上書き

      // final responseData =
      //     await rootBundle.loadString('json/detail_dummy.json');
      // final jsonResponse = json.decode(responseData)["projectList"];
      // final List<dynamic> dataList = jsonResponse.toList();
      // final targetData =
      //     dataList.firstWhere((item) => item["projectId"] == projectId);
      // return ProjectDetailModel.fromJson(targetData);

      final responseData = dummyProjectDetailList
          .firstWhereOrNull((item) => item.projectId == projectId);
      _logger.i('取得データ：$responseData');
      return responseData;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getProjectDetail 通信終了');
    }
    // }
  }

  /// プログラミング言語一覧取得
  Future<List<LabelModel>?> getDevLanguageList() async {
    try {
      _logger.i('getDevLanguageList 通信開始');
      final responseData =
          await rootBundle.loadString('json/dev_language_list.json');
      _logger.i('取得データ：$responseData');
      final jsonResponse = json.decode(responseData)["dev_language_list"];
      final List<dynamic> dataList = jsonResponse.toList();

      final List<LabelModel> devLangList = [];
      for (final data in dataList) {
        final model = LabelModel.fromJson(data);
        devLangList.add(model);
      }
      _logger.d('devLangList：$devLangList');
      return devLangList;
    } on Exception catch (exception) {
      _logger.e(exception);
      rethrow;
    } finally {
      _logger.i('getDevLanguageList 通信終了');
    }
  }
}
