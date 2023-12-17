import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stairs/feature/project/repository/project_repository.dart';
part 'dev_lang_provider.g.dart';

@riverpod
class DevLang extends _$DevLang {
  final _logger = stairsLogger(name: 'dev_lang');
  final projectRepositoryProvider = Provider((ref) => ProjectRepository());

  @override
  FutureOr<List<LabelModel>> build() async {
    return await getDevLanguageList();
  }

  /// データの取得メソッド
  Future<List<LabelModel>> getDevLanguageList() async {
    _logger.d('getDevLanguageList: プログラミング言語取得');
    // API通信開始
    final repository = ref.read(projectRepositoryProvider);
    final list = await repository.getDevLanguageList() ?? [];
    return list;
  }
}
