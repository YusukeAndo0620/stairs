import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/repository/common_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:stairs/feature/common/provider/account_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'git_provider.g.dart';

@riverpod
class Git extends _$Git {
  final _logger = stairsLogger(name: 'git_provider');

  @override
  FutureOr<List<LabelModel>> build() async {
    return await getGitList();
  }

  /// Git一覧取得しStateにセット
  Future<void> setGitList() async {
    final list = await getGitList();
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

  /// Git一覧取得
  Future<List<LabelModel>> getGitList() async {
    _logger.d('getGitList: Git一覧取得');
    // Gitプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));

    // API通信開始
    final repository = ref.read(commonRepositoryProvider);
    final accountState = ref.read(accountProvider(db: db));

    final list =
        await repository.getGitList(accountId: accountState.value!.accountId) ??
            [];
    return list;
  }

  /// Git作成
  Future<void> createGit({required LabelModel labelModel}) async {
    _logger.d('createGit: Git作成');
    // Gitプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.createGit(
          accountId: accountState.value!.accountId, labelModel: labelModel);
    } catch (e) {
      _logger.e(e);
    }
  }

  /// Git更新
  Future<void> updateGit({required LabelModel labelModel}) async {
    _logger.d('updateGit: Git更新');
    // Gitプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.updateGit(
          accountId: accountState.value!.accountId, labelModel: labelModel);
    } catch (e) {
      _logger.e(e);
    }
  }

  /// Git削除
  Future<void> deleteGit({required String gitId}) async {
    _logger.d('deleteGit: Git削除');
    // Gitプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.deleteGit(
          accountId: accountState.value!.accountId, gitId: gitId);
    } catch (e) {
      _logger.e(e);
    }
  }

  String getName({required String gitId}) {
    if (state.value == null) return '';
    final index = state.value!.indexWhere((element) => element.id == gitId);
    return index == -1 ? '' : state.value![index].labelName;
  }
}
