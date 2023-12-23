import 'package:stairs/db/database.dart';
import 'package:stairs/feature/common/repository/common_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dev_lang_provider.g.dart';

@riverpod
class DevLang extends _$DevLang {
  final _logger = stairsLogger(name: 'dev_lang');

  @override
  FutureOr<List<LabelModel>> build({required StairsDatabase db}) async {
    return await getDevLanguageList(db: db);
  }

  /// データの取得メソッド
  Future<List<LabelModel>> getDevLanguageList(
      {required StairsDatabase db}) async {
    _logger.d('getDevLanguageList: プログラミング言語取得');
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));

    // API通信開始
    final repository = ref.read(commonRepositoryProvider);
    final list = await repository.getDevLanguageList() ?? [];
    return list;
  }
}
