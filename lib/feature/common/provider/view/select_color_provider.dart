import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_color_provider.g.dart';

class SelectColorModel {
  const SelectColorModel({
    required this.selectedColorId,
    required this.colorList,
  });
  final int selectedColorId;
  final List<ColorModel> colorList;

  SelectColorModel copyWith({
    int? selectedColorId,
    List<ColorModel>? colorList,
  }) =>
      SelectColorModel(
        selectedColorId: selectedColorId ?? this.selectedColorId,
        colorList: colorList ?? this.colorList,
      );
}

@riverpod
class SelectColor extends _$SelectColor {
  @override
  SelectColorModel build(
          {required List<ColorModel> colorList,
          required int selectedColorId}) =>
      SelectColorModel(
        selectedColorId: selectedColorId,
        colorList: colorList,
      );

  ColorModel get selectedColorInfo =>
      state.colorList.firstWhere((item) => item.id == state.selectedColorId,
          orElse: () => state.colorList[0]);

  void changeSelectedColor({required int colorId}) {
    state = state.copyWith(selectedColorId: colorId);
  }
}
