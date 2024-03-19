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
  List<CheckedLabelModel> build({
    required List<LabelModel> labelList,
    required List<String> checkedIdList,
  }) {
    final checkList = labelList
        .map(
          (item) => CheckedLabelModel(
            id: item.id,
            labelName: item.labelName,
            checked: checkedIdList.firstWhereOrNull(
                  (id) => id == item.id,
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
  List<String> get selectedIdList {
    final selectedIdList = state
        .map((item) => item.checked ? item.id : null)
        .whereType<String>()
        .toList();
    return selectedIdList;
  }
}
