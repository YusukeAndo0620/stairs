import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';
part 'select_item_provider.g.dart';

class CheckedColorLabelInfo extends ColorLabelModel {
  CheckedColorLabelInfo({
    required super.id,
    required super.labelName,
    required super.colorModel,
    required this.checked,
  });

  final bool checked;
}

@riverpod
class SelectItem extends _$SelectItem {
  @override
  List<CheckedColorLabelInfo> build() => [];

  void init({
    required String id,
    required List<ColorLabelModel> labelList,
    required List<ColorLabelModel> selectedLabelList,
  }) {
    final checkList = labelList
        .map(
          (item) => CheckedColorLabelInfo(
            id: item.id,
            labelName: item.labelName,
            colorModel: item.colorModel,
            checked: selectedLabelList.firstWhereOrNull(
                  (element) => element.id == item.id,
                ) !=
                null,
          ),
        )
        .toList();
    state = checkList;
  }

  void changeCheckedItem({required String id}) {
    final targetList = [...state];
    final targetIndex = state.indexWhere((element) => element.id == id);
    final targetItem = state[targetIndex];

    final editTarget = CheckedColorLabelInfo(
        id: targetItem.id,
        labelName: targetItem.labelName,
        colorModel: targetItem.colorModel,
        checked: !targetItem.checked);

    targetList.replaceRange(targetIndex, targetIndex + 1, [editTarget]);
    state = targetList;
  }

  // チェックリストで、選択された要素のリストを取得
  List<CheckedColorLabelInfo> get selectedList {
    final selectedList =
        state.map((item) => item.checked ? item : null).toList();
    selectedList.removeWhere((element) => element == null);
    return selectedList.whereType<CheckedColorLabelInfo>().toList();
  }
}
