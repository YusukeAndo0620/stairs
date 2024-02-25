import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drag_item_provider.g.dart';

const kShrinkId = 'shrinkId';

class DraggingItemState {
  const DraggingItemState({
    required this.beforeBoardId,
    required this.currentBoardId,
    this.draggingItem,
  });

  final String beforeBoardId;
  final String currentBoardId;
  final TaskItemModel? draggingItem;

  DraggingItemState copyWith({
    String? beforeBoardId,
    String? currentBoardId,
    TaskItemModel? draggingItem,
  }) =>
      DraggingItemState(
        beforeBoardId: beforeBoardId ?? this.beforeBoardId,
        currentBoardId: currentBoardId ?? this.currentBoardId,
        draggingItem: draggingItem ?? this.draggingItem,
      );
}

@riverpod
class DragItem extends _$DragItem {
  @override
  DraggingItemState build() => const DraggingItemState(
        beforeBoardId: '',
        currentBoardId: '',
        draggingItem: null,
      );

  void init() {
    state = const DraggingItemState(
      beforeBoardId: '',
      currentBoardId: '',
      draggingItem: null,
    );
  }

  void setItem({
    String? beforeBoardId,
    required String currentBoardId,
    TaskItemModel? draggingItem,
  }) {
    state = DraggingItemState(
      beforeBoardId: beforeBoardId ?? state.beforeBoardId,
      currentBoardId: currentBoardId,
      draggingItem:
          draggingItem ?? state.draggingItem?.copyWith(boardId: currentBoardId),
    );
  }
}
