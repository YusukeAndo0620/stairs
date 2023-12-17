import 'package:stairs/db/database.dart';
import 'package:stairs/feature/common/repository/common_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'm_color_provider.g.dart';

@riverpod
class MColor extends _$MColor {
  @override
  FutureOr<List<ColorModel>?> build({required StairsDatabase database}) =>
      getColorList(database: database);

  Future<List<ColorModel>?> getColorList(
      {required StairsDatabase database}) async {
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(database: database));
    // API通信開始
    final repository = ref.read(commonRepositoryProvider);
    final colorList = await repository.getColorList();
    return colorList;
  }
}
