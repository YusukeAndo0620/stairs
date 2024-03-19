import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/repository/common_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_color_provider.g.dart';

@riverpod
class CustomColor extends _$CustomColor {
  @override
  FutureOr<List<ColorModel>?> build() => getColorList();

  Future<List<ColorModel>?> getColorList() async {
    // DBプロバイダー
    final db = ref.watch(databaseProvider);
    final commonRepositoryProvider =
        Provider((ref) => CommonRepository(db: db));
    // API通信開始
    final repository = ref.read(commonRepositoryProvider);
    final colorList = await repository.getColorList();
    return colorList;
  }
}
