import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/repository/common_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dev_progress_provider.g.dart';

@riverpod
class DevProgress extends _$DevProgress {
  final _logger = stairsLogger(name: 'dev_progress_provider');

  @override
  FutureOr<List<LabelModel>> build() async {
    return await getDevProgressList();
  }

  /// データの取得メソッド
  Future<List<LabelModel>> getDevProgressList() async {
    _logger.d('getDevProgressList: 開発工程一覧取得');
    // DBプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));

    // API通信開始
    final repository = ref.read(commonRepositoryProvider);
    final list = await repository.getDevProgressList() ?? [];
    return list;
  }

  String getName({required String devProgressId}) {
    if (state.value == null) return '';
    final index =
        state.value!.indexWhere((element) => element.id == devProgressId);
    return index == -1 ? '' : state.value![index].labelName;
  }
}
