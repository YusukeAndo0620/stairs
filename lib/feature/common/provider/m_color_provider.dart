import 'package:stairs/db/database.dart';
import 'package:stairs/feature/common/repository/common_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'm_color_provider.g.dart';

@riverpod
class MColor extends _$MColor {
  @override
  FutureOr<List<ColorModel>?> build({required StairsDatabase db}) =>
      getColorList(db: db);

  Future<List<ColorModel>?> getColorList({required StairsDatabase db}) async {
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    // API通信開始
    final repository = ref.read(commonRepositoryProvider);
    final colorList = await repository.getColorList();
    return colorList;
  }
}
