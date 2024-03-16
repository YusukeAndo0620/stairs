import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/provider/account_provider.dart';
import 'package:stairs/feature/resume/model/resume_model.dart';
import 'package:stairs/feature/resume/repository/resume_repository.dart';
import 'package:stairs/loom/loom_package.dart';

part 'resume_provider.g.dart';

@riverpod
class Resume extends _$Resume {
  final _logger = stairsLogger(name: 'resume_provider');

  @override
  FutureOr<ResumeModel?> build() async {
    final list = await get();
    return list;
  }

  Future<ResumeModel?> get() async {
    _logger.d('経歴書取得');
    final database = ref.watch(databaseProvider);

    // Repository(APIの取得)の状態を管理する
    final statusRepositoryProvider =
        Provider((ref) => ResumeRepository(db: database));
    ResumeModel? resume;
    // API通信開始
    final repository = ref.read(statusRepositoryProvider);
    try {
      final account = ref.watch(accountProvider(db: database));
      resume = await repository.getResume(accountId: account.value!.accountId);
    } catch (e) {
      _logger.e(e);
    }
    return resume;
  }
}
