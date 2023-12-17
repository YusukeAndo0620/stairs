import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tag_provider.g.dart';

const _uuid = Uuid();

@riverpod
class Tag extends _$Tag {
  @override
  List<ColorLabelModel> build({required List<ColorLabelModel> tagList}) =>
      tagList;

  void updateInputValue({required String id, required String inputValue}) {
    state = _getReplacedList(
      targetId: id,
      inputValue: inputValue,
    );
  }

  void updateLinkColor({required String id, required Color themeColor}) {
    state = _getReplacedList(targetId: id, themeColor: themeColor);
  }

  void formatTagList() {
    final targetLinkLabelList = [...state];
    targetLinkLabelList.where((item) => item.labelName.isNotEmpty).toList();
    state = targetLinkLabelList;
  }

  void addTag() {
    final addingColorLabelInfo = ColorLabelModel(
      id: _uuid.v4(),
      labelName: '',
      color: const Color.fromARGB(255, 255, 31, 31),
    );

    final targetLinkLabelList = [...state];
    targetLinkLabelList.add(addingColorLabelInfo);
    state = targetLinkLabelList;
  }

  void deleteTag({required String id}) {
    final targeTagList = [...state];
    state = targeTagList
        .map((item) => item.id != id ? item : null)
        .toList()
        .whereType<ColorLabelModel>()
        .toList();
  }

  void moveLast({required ScrollController scrollController}) {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  List<ColorLabelModel> _getReplacedList({
    required String targetId,
    String? inputValue,
    Color? themeColor,
  }) {
    final targetIndex = state.indexWhere((element) => element.id == targetId);
    final replacedList = [...state];

    final editTarget = ColorLabelModel(
      id: targetId,
      labelName: inputValue ?? state[targetIndex].labelName,
      color: themeColor ?? state[targetIndex].color,
    );

    replacedList.replaceRange(targetIndex, targetIndex + 1, [editTarget]);
    return replacedList;
  }
}
