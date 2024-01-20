// import 'package:stairs/db/database.dart';
// import 'package:stairs/feature/common/repository/common_repository.dart';
// import 'package:stairs/loom/loom_package.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// part 'diff_check_provider.g.dart';

// @riverpod
// class DiffCheck extends _$DiffCheck {
//   final _logger = stairsLogger(name: 'dev_progress_provider');

//   @override
//   FutureOr<List<LabelModel>> build({required StairsDatabase db}) async {
//     return await getDevProgressList(db: db);
//   }

//   /// データの取得メソッド
//   Future<List<LabelModel>> getDevProgressList(
//       {required StairsDatabase db}) async {
//     _logger.d('getDevProgressList: 開発工程一覧取得');
//     final commonRepositoryProvider =
//         Provider((ref) => CommonRepository(db: db));

//     // API通信開始
//     final repository = ref.read(commonRepositoryProvider);
//     final list = await repository.getDevProgressList() ?? [];
//     return list;
//   }
// }
