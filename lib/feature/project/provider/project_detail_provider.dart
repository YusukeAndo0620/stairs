import 'package:stairs/db/constant/color_list.dart';
import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/provider/account_provider.dart';
import 'package:stairs/feature/common/provider/view/toast_msg_provider.dart';
import 'package:stairs/feature/common/repository/common_repository.dart';
import 'package:stairs/feature/project/enum/project_update_param.dart';
import 'package:stairs/feature/project/model/project_detail_model.dart';
import 'package:stairs/feature/project/repository/project_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_detail_provider.g.dart';

ProjectDetailModel? _initialProjectDetailModel;

@riverpod
class ProjectDetail extends _$ProjectDetail {
  final _logger = stairsLogger(name: 'project_detail_provider');

  @override
  FutureOr<ProjectDetailModel?> build({required String projectId}) async {
    _logger.d('ビルド実施 projectId: $projectId');
    if (projectId.isEmpty) {
      if (_initialProjectDetailModel == null) {
        await _setInitialProjectDetailModel();
      }
      return _initialProjectDetailModel;
    }
    return getDetail(
      projectId: projectId,
    );
  }

  // プロジェクトモデルの初期値を設定する
  Future<void> _setInitialProjectDetailModel() async {
    // タグリストを取得し初期値に追加
    final database = ref.watch(databaseProvider);
    final commonRepository = Provider((ref) => CommonRepository(db: database));
    final account = ref.watch(accountProvider(db: database));
    final repository = ref.read(commonRepository);
    final tagList =
        await repository.getDefaultTagList(accountId: account.value!.accountId);

    const uuid = Uuid();
    DateTime now = DateTime.now();

    _initialProjectDetailModel = ProjectDetailModel(
      projectId: uuid.v4(),
      projectName: '',
      themeColorModel: ColorModel(
          id: 1, color: getColorFromCode(code: colorList[0].colorCodeId.value)),
      industry: '',
      devMethodType: DevMethodType.waterFall,
      devSize: 50,
      displayCount: 0,
      tableCount: 0,
      startDate: DateTime(now.year, now.month, 1),
      endDate:
          DateTime(now.year, now.month + 7, 1).add(const Duration(days: -1)),
      devLanguageList: const [],
      toolIdList: [],
      devProgressIdList: [],
      tagList: tagList!,
    );
  }

  Future<ProjectDetailModel?> getDetail({required String projectId}) async {
    _logger.d('プロジェクト取得 projectId: $projectId');
    final database = ref.watch(databaseProvider);
    // Repository(APIの取得)の状態を管理する
    final projectRepositoryProvider =
        Provider((ref) => ProjectRepository(db: database));
    if (projectId.isEmpty) {
      return _initialProjectDetailModel;
    } else {
      // API通信開始
      final repository = ref.read(projectRepositoryProvider);
      ProjectDetailModel? detail;
      try {
        detail = await repository.getProjectDetail(projectId: projectId);
      } catch (e) {
        _logger.e(e);
      }
      return detail;
    }
  }

  Future<void> createProject() async {
    _logger.d('プロジェクト作成 開始');
    // トーストプロバイダー
    final toastMsgNotifier = ref.watch(toastMsgProvider.notifier);

    if (state.value == null) {
      _logger.d('stateに値がないため処理終了');
      await toastMsgNotifier.showToast(
          type: MessageType.error, msg: msgList['err001']);
      return;
    }
    _logger.d('projectId: ${state.value!.projectId}');
    final database = ref.watch(databaseProvider);

    final projectRepositoryProvider =
        Provider((ref) => ProjectRepository(db: database));

    // API通信開始
    final repository = ref.read(projectRepositoryProvider);
    try {
      await repository.createProject(detailModel: state.value!);
      await toastMsgNotifier.showToast(
          type: MessageType.success, msg: msgList['scc001']);
    } catch (e) {
      await toastMsgNotifier.showToast(
          type: MessageType.error, msg: msgList['err001']);
    } finally {
      _logger.d('プロジェクト作成 終了');
      _setInitialProjectDetailModel();
    }
  }

  Future<void> updateProject(
      {required List<ProjectUpdateParam> updateParamList}) async {
    _logger.d('プロジェクト更新 開始');
    if (state.value == null) {
      _logger.d('stateに値がないため処理終了');
      return;
    }
    if (updateParamList.isEmpty) {
      _logger.d('更新対象がないため処理終了');
      return;
    }
    _logger.d('projectId: ${state.value!.projectId}');
    final database = ref.watch(databaseProvider);

    final projectRepositoryProvider =
        Provider((ref) => ProjectRepository(db: database));
    // トーストプロバイダー
    final toastMsgNotifier = ref.watch(toastMsgProvider.notifier);
    // API通信開始
    final repository = ref.read(projectRepositoryProvider);
    try {
      await repository.updateProject(
          detailModel: state.value!, updateTargetList: updateParamList);
      await toastMsgNotifier.showToast(
          type: MessageType.success, msg: msgList['scc002']);
    } catch (e) {
      await toastMsgNotifier.showToast(
          type: MessageType.error, msg: msgList['err001']);
    } finally {
      _logger.d('プロジェクト更新 終了');
    }
  }

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

  void changeThemeColor({required ColorModel colorModel}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(themeColorModel: colorModel);
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

  void changeDevMethodType({required int typeValue}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data =
            data!.copyWith(devMethodType: getDevMethodType(typeValue));
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

  void changeTableCount({required int tableCount}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(tableCount: tableCount);
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

  void changeOs({required List<String> osIdList}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(osIdList: osIdList);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeDb({required List<String> dbIdList}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(dbIdList: dbIdList);
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

  void changeToolList({required List<String> toolIdList}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(toolIdList: toolIdList);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeDevProgressList({required List<String> devProgressIdList}) {
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(devProgressIdList: devProgressIdList);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  void changeTagList({required List<ColorLabelModel> tagList}) {
    final targetList = tagList
        .map((item) => item.labelName.isNotEmpty ? item : null)
        .toList()
        .whereType<ColorLabelModel>()
        .toList();
    update(
      (data) {
        state = const AsyncLoading();
        return data = data!.copyWith(tagList: targetList);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }
}
