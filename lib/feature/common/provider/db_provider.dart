import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/repository/common_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:stairs/feature/common/provider/account_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'db_provider.g.dart';

@riverpod
class Db extends _$Db {
  final _logger = stairsLogger(name: 'db_provider');

  @override
  FutureOr<List<LabelModel>> build() async {
    return await getDbList();
  }

  /// DB一覧取得
  Future<List<LabelModel>> getDbList() async {
    _logger.d('getDbList: DB一覧取得');
    // DBプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));

    // API通信開始
    final repository = ref.read(commonRepositoryProvider);
    final accountState = ref.read(accountProvider(db: db));

    final list =
        await repository.getDbList(accountId: accountState.value!.accountId) ??
            [];
    return list;
  }

  /// DB作成
  Future<void> createDb({required LabelModel labelModel}) async {
    _logger.d('createDb: DB作成');
    // DBプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.createDb(
          accountId: accountState.value!.accountId, labelModel: labelModel);
    } catch (e) {
      _logger.e(e);
    }
  }

  /// DB更新
  Future<void> updateDb({required LabelModel labelModel}) async {
    _logger.d('updateDb: DB更新');
    // DBプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.updateDb(
          accountId: accountState.value!.accountId, labelModel: labelModel);
    } catch (e) {
      _logger.e(e);
    }
  }

  /// DB削除
  Future<void> deleteDb({required String dbId}) async {
    _logger.d('deleteDb: DB削除');
    // DBプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.deleteDb(
          accountId: accountState.value!.accountId, dbId: dbId);
    } catch (e) {
      _logger.e(e);
    }
  }

  String getName({required String dbId}) {
    return state.value == null
        ? ''
        : state.value!.firstWhere((element) => element.id == dbId).labelName;
  }
}
