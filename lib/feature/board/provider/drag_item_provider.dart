import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drag_item_provider.g.dart';

const kShrinkId = 'shrinkId';

class DraggingItemState {
  const DraggingItemState({
    required this.boardId,
    this.draggingItem,
  });

  final String boardId;
  final TaskItemModel? draggingItem;

  DraggingItemState copyWith({
    String? boardId,
    TaskItemModel? draggingItem,
  }) =>
      DraggingItemState(
        boardId: boardId ?? this.boardId,
        draggingItem: draggingItem ?? this.draggingItem,
      );
}

@riverpod
class DragItem extends _$DragItem {
  @override
  DraggingItemState build() => const DraggingItemState(
        boardId: '',
        draggingItem: null,
      );

  void init() {
    state = const DraggingItemState(
      boardId: '',
      draggingItem: null,
    );
  }

  void setItem({
    required String boardId,
    TaskItemModel? draggingItem,
  }) {
    state = DraggingItemState(
      boardId: boardId,
      draggingItem:
          draggingItem ?? state.draggingItem?.copyWith(boardId: boardId),
    );
  }
}


