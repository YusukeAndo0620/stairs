import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/provider/account_provider.dart';
import 'package:stairs/feature/project/model/project_list_item_model.dart';
import 'package:stairs/feature/project/repository/project_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_list_provider.g.dart';

@riverpod
class ProjectList extends _$ProjectList {
  final _logger = stairsLogger(name: 'project_list_provider');

  @override
  FutureOr<List<ProjectListItemModel>> build() async {
    return getProjectList();
  }

  /// データセット
  Future<void> setProjectList() async {
    _logger.d('getProjectList: プロジェクト一覧セット');

    final list = await getProjectList();

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
  Future<List<ProjectListItemModel>> getProjectList() async {
    _logger.d('getProjectList: プロジェクト一覧取得');
    final database = ref.watch(databaseProvider);

    final projectRepositoryProvider =
        Provider((ref) => ProjectRepository(db: database));
    // API通信開始
    final repository = ref.read(projectRepositoryProvider);
    List<ProjectListItemModel> list = [];
    try {
      final account = ref.watch(accountProvider(db: database));
      if (account.value == null) {
        _logger.d('アカウント情報が取得できていません。');
        return list;
      }
      list = await repository.getProjectList(
              accountId: account.value!.accountId) ??
          [];
    } catch (e) {
      _logger.e(e);
    }
    return list;
  }
}
