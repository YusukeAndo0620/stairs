import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';
part 'select_label_provider.g.dart';

class CheckedLabelModel extends LabelModel {
  CheckedLabelModel({
    required super.id,
    required super.labelName,
    required this.checked,
  });

  final bool checked;
}

@riverpod
class SelectLabel extends _$SelectLabel {
  @override
  List<CheckedLabelModel> build(
      {required List<LabelModel> labelList,
      required List<LabelModel> selectedLabelList}) {
    // ダミーデータ
    final checkList = labelList
        .map(
          (item) => CheckedLabelModel(
            id: item.id,
            labelName: item.labelName,
            checked: selectedLabelList.firstWhereOrNull(
                  (element) => element.id == item.id,
                ) !=
                null,
          ),
        )
        .toList();
    return checkList;
  }

  void changeCheckedItem({required String id}) {
    final targetList = [...state];
    final targetIndex = state.indexWhere((element) => element.id == id);
    final targetItem = state[targetIndex];

    final editTarget = CheckedLabelModel(
        id: targetItem.id,
        labelName: targetItem.labelName,
        checked: !targetItem.checked);

    targetList.replaceRange(targetIndex, targetIndex + 1, [editTarget]);
    state = targetList;
  }

  // チェックリストで、選択された要素のリストを取得
  List<LabelModel> get selectedList {
    final selectedList =
        state.map((item) => item.checked ? item : null).toList();
    selectedList.removeWhere((element) => element == null);
    return selectedList.whereType<LabelModel>().toList();
  }
}
