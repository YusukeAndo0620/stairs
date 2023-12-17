import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drumroll_with_content_provider.g.dart';

const _uuid = Uuid();

class SelectItemListModel {
  SelectItemListModel({
    required this.labeList,
    required this.selectedList,
  });

  final List<LabelModel> labeList;
  final List<LabelWithContent> selectedList;

  SelectItemListModel copyWith({
    List<LabelModel>? labeList,
    List<LabelWithContent>? selectedList,
  }) =>
      SelectItemListModel(
        labeList: labeList ?? this.labeList,
        selectedList: selectedList ?? this.selectedList,
      );
}

@riverpod
class DrumrollWithContent extends _$DrumrollWithContent {
  @override
  SelectItemListModel build(
          {required List<LabelModel> labeList,
          required List<LabelWithContent> selectedList}) =>
      SelectItemListModel(labeList: labeList, selectedList: selectedList);

  void addSelectedLabel() {
    final targetList = [...state.selectedList];

    targetList.add(
      LabelWithContent(
        id: _uuid.v4(),
        labelId: state.labeList[0].id,
        labelName: state.labeList[0].labelName,
        content: '',
      ),
    );
    state = state.copyWith(selectedList: targetList);
  }

  void updateSelectedLabel({
    required String id,
    required String labelId,
  }) {
    final targetList = _getReplacedList(
      targetId: id,
      labelId: labelId,
    );
    state = state.copyWith(selectedList: targetList);
  }

  void updateInputValue({required String id, required String inputValue}) {
    final targetList = _getReplacedList(
      targetId: id,
      inputValue: inputValue,
    );
    state = state.copyWith(selectedList: targetList);
  }

  void deleteSelectedLabel({required String id}) async {
    final targetList = [...state.selectedList];
    state = state.copyWith(
      selectedList: targetList
          .map((item) => item.id != id ? item : null)
          .toList()
          .whereType<LabelWithContent>()
          .toList(),
    );
  }

  void moveLast({required ScrollController scrollController}) {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  List<LabelWithContent> _getReplacedList({
    required String targetId,
    String? labelId,
    String? inputValue,
  }) {
    final targetIndex =
        state.selectedList.indexWhere((element) => element.id == targetId);

    if (targetIndex == -1) return state.selectedList;

    final replacedList = [...state.selectedList];

    LabelWithContent editTarget;

    if (labelId != null) {
      final targetLabelIndex =
          state.labeList.indexWhere((element) => element.id == labelId);
      if (targetLabelIndex == -1) return state.selectedList;
      editTarget = state.selectedList[targetIndex].copyWith(
        labelId: labelId,
        labelName: state.labeList[targetLabelIndex].labelName,
      );
    } else {
      editTarget = state.selectedList[targetIndex].copyWith(
        content: inputValue,
      );
    }

    replacedList.replaceRange(targetIndex, targetIndex + 1, [editTarget]);
    return replacedList;
  }
}
