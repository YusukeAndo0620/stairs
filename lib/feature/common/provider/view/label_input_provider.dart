import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'label_input_provider.g.dart';

const _uuid = Uuid();

@riverpod
class LabelInput extends _$LabelInput {
  @override
  List<LabelModel> build({required List<LabelModel> labelList}) => labelList;

  void updateInputValue({required String id, required String inputValue}) {
    state = _getReplacedList(
      targetId: id,
      inputValue: inputValue,
    );
  }

  void addLabel() {
    final targetLabelList = [...state];

    targetLabelList.add(LabelModel(
      id: _uuid.v4(),
      labelName: '',
    ));
    state = targetLabelList;
  }

  void deleteLabel({required String id}) async {
    final targetLabelList = [...state];
    state = targetLabelList
        .map((item) => item.id != id ? item : null)
        .toList()
        .whereType<LabelModel>()
        .toList();
  }

  void moveLast({required ScrollController scrollController}) {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  List<LabelModel> _getReplacedList(
      {required String targetId, String? inputValue}) {
    final targetIndex = state.indexWhere((element) => element.id == targetId);
    final replacedList = [...state];

    final editTarget = LabelModel(
      id: targetId,
      labelName: inputValue ?? state[targetIndex].labelName,
    );

    replacedList.replaceRange(targetIndex, targetIndex + 1, [editTarget]);
    return replacedList;
  }
}
