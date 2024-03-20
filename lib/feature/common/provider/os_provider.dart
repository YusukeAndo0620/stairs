import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/repository/common_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:stairs/feature/common/provider/account_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'os_provider.g.dart';

@riverpod
class Os extends _$Os {
  final _logger = stairsLogger(name: 'os_provider');

  @override
  FutureOr<List<LabelModel>> build() async {
    return await getOsList();
  }

  /// OS一覧取得しStateにセット
  Future<void> setOsList() async {
    final list = await getOsList();
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

  /// OS一覧取得
  Future<List<LabelModel>> getOsList() async {
    _logger.d('getOsList: OS一覧取得');
    // OSプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));

    // API通信開始
    final repository = ref.read(commonRepositoryProvider);
    final accountState = ref.read(accountProvider(db: db));

    final list =
        await repository.getOsList(accountId: accountState.value!.accountId) ??
            [];
    return list;
  }

  /// OS作成
  Future<void> createOs({required LabelModel labelModel}) async {
    _logger.d('createOs: OS作成');
    // OSプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.createOs(
          accountId: accountState.value!.accountId, labelModel: labelModel);
    } catch (e) {
      _logger.e(e);
    }
  }

  /// OS更新
  Future<void> updateOs({required LabelModel labelModel}) async {
    _logger.d('updateOs: OS更新');
    // OSプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.updateOs(
          accountId: accountState.value!.accountId, labelModel: labelModel);
    } catch (e) {
      _logger.e(e);
    }
  }

  /// OS削除
  Future<void> deleteOs({required String osId}) async {
    _logger.d('deleteOs: OS削除');
    // OSプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.deleteOs(
          accountId: accountState.value!.accountId, osId: osId);
    } catch (e) {
      _logger.e(e);
    }
  }

  String getName({required String osId}) {
    if (state.value == null) return '';
    final index = state.value!.indexWhere((element) => element.id == osId);
    return index == -1 ? '' : state.value![index].labelName;
  }
}
