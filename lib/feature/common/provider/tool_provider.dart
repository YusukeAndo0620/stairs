import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/repository/common_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:stairs/feature/common/provider/account_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'tool_provider.g.dart';

@riverpod
class Tool extends _$Tool {
  final _logger = stairsLogger(name: 'tool_provider');

  @override
  FutureOr<List<LabelModel>> build() async {
    return await getToolList();
  }

  /// Tool一覧取得しStateにセット
  Future<void> setToolList() async {
    final list = await getToolList();
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

  /// Tool一覧取得
  Future<List<LabelModel>> getToolList() async {
    _logger.d('getToolList: Tool一覧取得');
    // Toolプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));

    // API通信開始
    final repository = ref.read(commonRepositoryProvider);
    final accountState = ref.read(accountProvider(db: db));

    final list = await repository.getToolList(
            accountId: accountState.value!.accountId) ??
        [];
    return list;
  }

  /// Tool作成
  Future<void> createTool({required LabelModel labelModel}) async {
    _logger.d('createTool: Tool作成');
    // Toolプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.createTool(
          accountId: accountState.value!.accountId, labelModel: labelModel);
    } catch (e) {
      _logger.e(e);
    }
  }

  /// Tool更新
  Future<void> updateTool({required LabelModel labelModel}) async {
    _logger.d('updateTool: Tool更新');
    // Toolプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.updateTool(
          accountId: accountState.value!.accountId, labelModel: labelModel);
    } catch (e) {
      _logger.e(e);
    }
  }

  /// Tool削除
  Future<void> deleteTool({required String toolId}) async {
    _logger.d('deleteTool: Tool削除');
    // Toolプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    try {
      // API通信開始
      final repository = ref.read(commonRepositoryProvider);
      final accountState = ref.read(accountProvider(db: db));
      await repository.deleteTool(
          accountId: accountState.value!.accountId, toolId: toolId);
    } catch (e) {
      _logger.e(e);
    }
  }

  String getName({required String toolId}) {
    if (state.value == null) return '';
    final index = state.value!.indexWhere((element) => element.id == toolId);
    return index == -1 ? '' : state.value![index].labelName;
  }
}
