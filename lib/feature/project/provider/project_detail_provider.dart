import 'package:stairs/feature/project/model/project_detail_model.dart';
import 'package:stairs/feature/project/repository/project_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_detail_provider.g.dart';

const _uuid = Uuid();
final _initialProjectDetailModel = ProjectDetailModel(
  projectId: _uuid.v4(),
  projectName: '',
  themeColor: const  Color.fromARGB(255, 255, 31, 31),
  industry: '',
  displayCount: 145,
  startDate: DateTime(2010, 1, 1),
  endDate: DateTime.now(),
  devLanguageList: const [],
  toolList: [],
  devProgressList: [],
  devSize: 100,
  tagList: [],
);

@riverpod
class ProjectDetail extends _$ProjectDetail {
  // Repository(APIの取得)の状態を管理する
  final brandDetailRepositoryProvider = Provider((ref) => ProjectRepository());
  final _logger = stairsLogger(name: 'project_detail');

  @override
  FutureOr<ProjectDetailModel?> build({required String projectId}) async {
    _logger.d('build実施 projectId: $projectId');
    return getDetail(projectId: projectId);
  }

  Future<ProjectDetailModel?> getDetail({required String projectId}) async {
    _logger.d('getProjectDetail: プロジェクト取得 projectId: $projectId');

    if (projectId.isEmpty) {
      return _initialProjectDetailModel;
    } else {
      // API通信開始
      final repository = ref.read(brandDetailRepositoryProvider);
      final detail = await repository.getProjectDetail(projectId: projectId);
      return detail;
    }
  }

  Future<void> setDetail({required String projectId}) async {
    _logger.d('setDetail: プロジェクト取得 projectId: $projectId');
    final detail = await getDetail(projectId: projectId);
    update(
      (data) {
        state = const AsyncLoading();
        return data = detail;
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  Future<void> updateDetail() async {}

  // state change event
  void changeProjectName({required String projectName}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(projectName: projectName);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeThemeColor({required Color colorInfo}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(themeColor: colorInfo);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeIndustry({required String industry}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(industry: industry);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeDisplayCount({required int displayCount}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(displayCount: displayCount);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeDueDate({required DateTime startDate, required DateTime endDate}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(startDate: startDate, endDate: endDate);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeDescription({required String description}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(description: description);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeOs({required List<LabelModel> osList}) {
    final targetOsList =
        osList.where((item) => item.labelName.isNotEmpty).toList();
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(osList: targetOsList);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeDb({required List<LabelModel> dbList}) {
    final targetDbList =
        dbList.where((item) => item.labelName.isNotEmpty).toList();
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(dbList: targetDbList);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeDevLanguageList(
      {required List<LabelWithContent> devLanguageList}) {
    final targetDevLangList =
        devLanguageList.where((item) => item.labelId.isNotEmpty).toList();
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(devLanguageList: targetDevLangList);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeToolList({required List<LabelModel> toolList}) {
    final targetToolList =
        toolList.where((item) => item.labelName.isNotEmpty).toList();
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(toolList: targetToolList);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeDevProgressList({required List<LabelModel> devProgressList}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(devProgressList: devProgressList);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeDevSize({required int devSize}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(devSize: devSize);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeTagList({required List<ColorLabelModel> tagList}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(tagList: tagList);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

// ボードで設定したラベル（開発言語＋タグ）リスト取得
  // List<ColorLabelModel> getLabelList({required String projectId}) {
  //   //TODO: API使用予定
  //   final projectDetail = dummyProjectDetailList
  //       .firstWhere((element) => element.projectId == projectId);
  //   return projectDetail.allLabelList;
  // }
}