import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';
part 'select_label_provider.g.dart';

class CheckedLabelModel extends LabelModel {
  CheckedLabelModel({
    required super.id,
    required super.labelName,
    required this.checked,
    this.isEdit = false,
  });

  final bool checked;
  final bool isEdit;

  CheckedLabelModel copyWith({
    String? id,
    String? labelName,
    bool? checked,
  }) =>
      CheckedLabelModel(
        id: id ?? this.id,
        labelName: labelName ?? this.labelName,
        checked: checked ?? this.checked,
      );
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

  /// 選択状態変更
  void changeCheckedItem({required String id}) {
    final targetList = [...state];
    final targetIndex = state.indexWhere((element) => element.id == id);
    if (targetIndex == -1) return;
    final targetItem = state[targetIndex];
    final editTarget = targetItem.copyWith(checked: !targetItem.checked);

    targetList.replaceRange(targetIndex, targetIndex + 1, [editTarget]);
    state = targetList;
  }

  /// ラベル項目追加。追加したラベルIDを返却。
  String addLabel({required String name}) {
    const uuid = Uuid();
    final id = uuid.v4();
    final targetList = [...state];

    final labelModel =
        CheckedLabelModel(id: id, labelName: name, checked: true);
    targetList.add(labelModel);
    state = targetList;
    return id;
  }

  /// ラベル名変更
  void changeName({required String id, required String name}) {
    final targetList = [...state];
    final targetIndex = state.indexWhere((element) => element.id == id);
    final targetItem = state[targetIndex];
    if (targetIndex == -1) return;

    final editTarget = targetItem.copyWith(labelName: name);

    targetList.replaceRange(targetIndex, targetIndex + 1, [editTarget]);
    state = targetList;
  }

  /// 項目削除
  void deleteItem({required String id}) {
    final targetList = [...state];
    final targetIndex = state.indexWhere((element) => element.id == id);
    if (targetIndex == -1) return;

    targetList.removeAt(targetIndex);
    state = targetList;
  }

  /// チェックリストで、選択された要素のリストを取得
  List<String> get selectedIdList {
    final selectedIdList = state
        .map((item) => item.checked ? item.id : null)
        .whereType<String>()
        .toList();
    return selectedIdList;
  }
}
