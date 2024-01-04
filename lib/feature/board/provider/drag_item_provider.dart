import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drag_item_provider.g.dart';

const kShrinkId = 'shrinkId';

class DraggingItemState {
  const DraggingItemState({
    required this.boardId,
    this.draggingItem,
    this.shrinkItem,
  });

  final String boardId;
  final TaskItemModel? draggingItem;
  final TaskItemModel? shrinkItem;

  DraggingItemState copyWith({
    String? boardId,
    TaskItemModel? draggingItem,
    TaskItemModel? shrinkItem,
  }) =>
      DraggingItemState(
        boardId: boardId ?? this.boardId,
        draggingItem: draggingItem ?? this.draggingItem,
        shrinkItem: shrinkItem ?? this.shrinkItem,
      );
}

@riverpod
class DragItem extends _$DragItem {
  @override
  DraggingItemState build() => const DraggingItemState(
        boardId: '',
        draggingItem: null,
        shrinkItem: null,
      );

  void init() {
    state = const DraggingItemState(
      boardId: '',
      draggingItem: null,
      shrinkItem: null,
    );
  }

  void setItem({required String boardId,  TaskItemModel? draggingItem}) {
    state = DraggingItemState(
      boardId: boardId,
      draggingItem: draggingItem?? state.draggingItem!.copyWith(boardId: boardId),
      shrinkItem: getShrinkItem(
        boardId: boardId,
      ),
    );
  }
}

/// shrink itemを生成。取得。
TaskItemModel getShrinkItem({required String boardId}) {
  return TaskItemModel(
    boardId: boardId,
    taskItemId: kShrinkId,
    title: '',
    description: '',
    startDate: DateTime.now(),
    dueDate: DateTime.now(),
    labelList: [],
  );
}
