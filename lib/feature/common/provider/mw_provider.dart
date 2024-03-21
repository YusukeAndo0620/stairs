import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/repository/common_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:stairs/feature/common/provider/account_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'mw_provider.g.dart';

@riverpod
class Mw extends _$Mw {
  final _logger = stairsLogger(name: 'mw_provider');

  @override
  FutureOr<List<LabelModel>> build() async {
    return await getMwList();
  }

  /// Mw一覧取得しStateにセット
  Future<void> setMwList() async {
    final list = await getMwList();
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

  /// Mw一覧取得
  Future<List<LabelModel>> getMwList() async {
    _logger.d('getMwList: Mw一覧取得');
    // Mwプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));

    // API通信開始
    final repository = ref.read(commonRepositoryProvider);
    final accountState = ref.read(accountProvider(db: db));

    final list =
        await repository.getMwList(accountId: accountState.value!.accountId) ??
            [];
    return list;
  }

  /// Mw作成
  Future<void> createMw({required LabelModel labelModel}) async {
    _logger.d('createMw: Mw作成');
    // Mwプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.createMw(
          accountId: accountState.value!.accountId, labelModel: labelModel);
    } catch (e) {
      _logger.e(e);
    }
  }

  /// Mw更新
  Future<void> updateMw({required LabelModel labelModel}) async {
    _logger.d('updateMw: Mw更新');
    // Mwプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.updateMw(
          accountId: accountState.value!.accountId, labelModel: labelModel);
    } catch (e) {
      _logger.e(e);
    }
  }

  /// Mw削除
  Future<void> deleteMw({required String mwId}) async {
    _logger.d('deleteMw: Mw削除');
    // Mwプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.deleteMw(
          accountId: accountState.value!.accountId, mwId: mwId);
    } catch (e) {
      _logger.e(e);
    }
  }

  String getName({required String mwId}) {
    if (state.value == null) return '';
    final index = state.value!.indexWhere((element) => element.id == mwId);
    return index == -1 ? '' : state.value![index].labelName;
  }
}
