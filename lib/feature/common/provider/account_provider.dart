import 'package:stairs/db/database.dart';
import 'package:stairs/feature/common/repository/common_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'account_provider.g.dart';

@Riverpod(keepAlive: true)
class Account extends _$Account {
  final _logger = stairsLogger(name: 'account_provider');

  @override
  FutureOr<AccountModel?> build({required StairsDatabase db}) async {
    return getAccount(db: db);
  }

  /// アカウント取得
  Future<AccountModel?> getAccount({required StairsDatabase db}) async {
    _logger.d('getAccount: アカウント取得');
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));

    // API通信開始
    final repository = ref.read(commonRepositoryProvider);
    final account = await repository.getAccount();
    return account;
  }
}
