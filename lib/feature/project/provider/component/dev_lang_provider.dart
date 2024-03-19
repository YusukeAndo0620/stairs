import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/provider/account_provider.dart';
import 'package:stairs/feature/common/repository/common_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dev_lang_provider.g.dart';

@riverpod
class DevLang extends _$DevLang {
  final _logger = stairsLogger(name: 'dev_lang');

  @override
  FutureOr<List<LabelModel>> build() async {
    return await getDevLanguageList();
  }

  /// データの取得メソッド
  Future<List<LabelModel>> getDevLanguageList() async {
    _logger.d('getDevLanguageList: プログラミング言語取得');
    // DBプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));

    // API通信開始
    final repository = ref.read(commonRepositoryProvider);
    final accountState = ref.read(accountProvider(db: db));
    final list = await repository.getDevLanguageList(
            accountId: accountState.value!.accountId) ??
        [];
    return list;
  }
}
