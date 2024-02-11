import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/provider/account_provider.dart';
import 'package:stairs/feature/status/model/project_status_model.dart';
import 'package:stairs/feature/status/repository/status_repository.dart';
import 'package:stairs/loom/loom_package.dart';

part 'status_provider.g.dart';

@riverpod
class Status extends _$Status {
  final _logger = stairsLogger(name: 'status_provider');

  @override
  FutureOr<List<ProjectStatusModel>> build() async {
    return getList();
  }

  Future<List<ProjectStatusModel>> getList() async {
    _logger.d('ステータス一覧取得');
    final database = ref.watch(databaseProvider);

    // Repository(APIの取得)の状態を管理する
    final statusRepositoryProvider =
        Provider((ref) => StatusRepository(db: database));

    // API通信開始
    final repository = ref.read(statusRepositoryProvider);
    List<ProjectStatusModel> list = [];
    try {
      final account = ref.watch(accountProvider(db: database));
      list =
          await repository.getStatusList(accountId: account.value!.accountId);
    } catch (e) {
      _logger.e(e);
    }
    return list;
  }
}
