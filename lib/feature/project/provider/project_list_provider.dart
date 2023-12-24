import 'package:stairs/db/database.dart';
import 'package:stairs/feature/project/model/project_list_item_model.dart';
import 'package:stairs/feature/project/repository/project_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_list_provider.g.dart';

@riverpod
class ProjectList extends _$ProjectList {
  final _logger = stairsLogger(name: 'project_list');

  @override
  FutureOr<List<ProjectListItemModel>> build(
      {required StairsDatabase database}) async {
    return getProjectList(database: database);
  }

  /// データセット
  Future<void> setProjectList({required StairsDatabase database}) async {
    _logger.d('getProjectList: プロジェクト一覧セット');

    final list = await getProjectList(database: database);

    update(
      (data) {
        state = const AsyncLoading();
        return data = list;
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  /// データの取得
  Future<List<ProjectListItemModel>> getProjectList(
      {required StairsDatabase database}) async {
    _logger.d('getProjectList: プロジェクト一覧取得');
    final projectRepositoryProvider =
        Provider((ref) => ProjectRepository(db: database));
    // API通信開始
    final repository = ref.read(projectRepositoryProvider);
    final list = await repository.getProjectList() ?? [];
    _logger.d('list: $list');
    return list;
  }
}
