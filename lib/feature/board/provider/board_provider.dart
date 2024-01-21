import 'package:stairs/db/database.dart';
import 'package:stairs/feature/board/model/board_model.dart';
import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:stairs/feature/board/provider/drag_item_provider.dart';
import 'package:stairs/feature/board/repository/board_repository.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';

part 'board_provider.g.dart';

@riverpod
class Board extends _$Board {
  final _logger = stairsLogger(name: 'board');

  @override
  FutureOr<List<BoardModel>> build(
      {required String projectId, required StairsDatabase database}) async {
    _logger.d('=== build実施 ===');
    return getList(projectId: projectId, database: database);
  }

  /// Copied state value.
  List<BoardModel> _getCopiedList() {
    if (state.value == null) return [];
    return [...state.value!];
  }

  ///Check shrink item is included in target board card list.
  bool hasShrinkItem(String boardId) {
    final targetBoard = state.value!.firstWhereOrNull(
      (element) => element.boardId == boardId,
    );
    if (targetBoard == null) return false;
    return targetBoard.taskItemList
            .firstWhereOrNull((element) => element.taskItemId == kShrinkId) !=
        null;
  }

  ///Get board index in target board card list.
  int getBoardIndex({required String boardId}) {
    return state.value!.indexWhere(
      (element) => element.boardId == boardId,
    );
  }

  ///Get board index by task item id.
  int getBoardIndexByTaskId({required String taskItemId}) {
    int boardId = -1;
    for (final element in state.value!) {
      final taskItem = element.taskItemList
          .firstWhereOrNull((item) => item.taskItemId == taskItemId);
      if (taskItem == null) continue;
      boardId = getBoardIndex(boardId: element.boardId);
      break;
    }
    return boardId;
  }

  ///Get task item index in target board card list.
  int getTaskItemIndex({
    required String boardId,
    required String taskItemId,
  }) {
    if (getBoardIndex(boardId: boardId) == -1) return -1;
    return state.value![getBoardIndex(boardId: boardId)].taskItemList
        .indexWhere((element) => element.taskItemId == taskItemId);
  }

  Future<List<BoardModel>> getList(
      {required String projectId, required StairsDatabase database}) async {
    _logger.d('=== ボード一覧取得 projectId: $projectId ===');
    // Repository(APIの取得)の状態を管理する
    final boardRepositoryProvider =
        Provider((ref) => BoardRepository(db: database));

    // API通信開始
    final repository = ref.read(boardRepositoryProvider);
    final list = await repository.getBoardList(projectId: projectId);
    return list;
  }

  Future<void> addBoard({
    required String projectId,
    required String title,
  }) async {
    const uuid = Uuid();
    final emitList = _getCopiedList();

    emitList.add(
      BoardModel(
        projectId: projectId,
        boardId: uuid.v4(),
        title: title,
        taskItemList: <TaskItemModel>[],
      ),
    );
    update(
      (data) {
        state = const AsyncLoading();
        return data = emitList;
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  Future<void> addTaskItem({
    required String boardId,
    required String title,
    required DateTime dueDate,
    required List<ColorLabelModel> labelList,
  }) async {
    final emitList = _getCopiedList();
    final targetBoardIndex = getBoardIndex(boardId: boardId);
    if (targetBoardIndex == -1) return;

    const uuid = Uuid();
    emitList[targetBoardIndex].taskItemList.add(
          TaskItemModel(
            boardId: boardId,
            taskItemId: uuid.v4(),
            title: title,
            description: '',
            startDate: DateTime.now(),
            dueDate: dueDate,
            labelList: labelList,
          ),
        );
    update(
      (data) {
        state = const AsyncLoading();
        return data = emitList;
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  Future<void> updateTaskItem({
    required String boardId,
    required String taskItemId,
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime dueDate,
    required List<ColorLabelModel> labelList,
  }) async {
    final emitList = _getCopiedList();
    final targetBoardIndex = getBoardIndex(boardId: boardId);
    if (targetBoardIndex == -1) return;
    final targetTaskItemIndex = getTaskItemIndex(
      boardId: boardId,
      taskItemId: taskItemId,
    );
    if (targetBoardIndex == -1) return;
    final replaceBoardInfo = BoardModel(
      projectId: emitList[targetBoardIndex].projectId,
      boardId: emitList[targetBoardIndex].boardId,
      title: emitList[targetBoardIndex].title,
      taskItemList: emitList[targetBoardIndex].taskItemList,
    );
    final replaceTaskItem = TaskItemModel(
      boardId: boardId,
      taskItemId: taskItemId,
      title: title,
      description: description,
      startDate: startDate,
      dueDate: dueDate,
      labelList: labelList,
    );

    replaceBoardInfo.taskItemList.replaceRange(
        targetTaskItemIndex, targetTaskItemIndex + 1, [replaceTaskItem]);
    emitList.replaceRange(
        targetBoardIndex, targetBoardIndex + 1, [replaceBoardInfo]);

    update(
      (data) {
        state = const AsyncLoading();
        return data = emitList;
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  Future<void> deleteTaskItem({
    required String boardId,
    required String taskItemId,
  }) async {
    final emitList = _getCopiedList();
    final deleteBoardIndex = getBoardIndex(boardId: boardId);
    if (deleteBoardIndex == -1) return;
    final deleteBoardItemIndex = getTaskItemIndex(
      boardId: boardId,
      taskItemId: taskItemId,
    );

    emitList[deleteBoardIndex].taskItemList.removeAt(deleteBoardItemIndex);
    update(
      (data) {
        state = const AsyncLoading();
        return data = emitList;
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  Future<void> replaceShrinkItem({
    required String boardId,
    required String taskItemId,
  }) async {
    final boardIndex = getBoardIndex(boardId: boardId);
    if (boardIndex == -1) return;
    final emitList = _getCopiedList();
    final taskItemIndex = getTaskItemIndex(
      boardId: boardId,
      taskItemId: taskItemId,
    );
    emitList[boardIndex].taskItemList[taskItemIndex] =
        getShrinkItem(boardId: boardId);
    update(
      (data) {
        state = const AsyncLoading();
        return data = emitList;
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  Future<void> deleteAndAddShrinkItem({
    required String insertingBoardId,
    required int insertingTaskIndex,
  }) async {
    _logger.d("=== deleteAndAddShrinkItem ===");
    _logger.d(
      "対象ボードID: $insertingBoardId",
    );
    _logger.d(
      "タスクアイテム挿入位置: $insertingTaskIndex",
    );
    var targetList = _getCopiedList();
    // 追加するshrink item
    final shrinkItem = getShrinkItem(boardId: insertingBoardId);

    // Shrink Itemを追加する対象のBoard
    final boardIndex = getBoardIndex(boardId: insertingBoardId);
    if (boardIndex == -1) return;
    final targetBoard = targetList[boardIndex];

    // 現在のshrink itemがあるboard indexを取得
    final currentShrinkItemBoardIndex =
        getBoardIndexByTaskId(taskItemId: kShrinkId);

    // shrink itemがない場合、そのまま追加
    if (currentShrinkItemBoardIndex == -1) {
      targetBoard.taskItemList.insert(insertingTaskIndex, shrinkItem);
      return;
    }
    // 現在のshrink task indexを取得
    final currentShrinkItemTaskItemIndex = getTaskItemIndex(
      boardId: targetList[currentShrinkItemBoardIndex].boardId,
      taskItemId: shrinkItem.taskItemId,
    );

    if (targetList[boardIndex].taskItemList.isEmpty) {
      final replaceBoard = BoardModel(
          projectId: targetBoard.projectId,
          boardId: targetBoard.boardId,
          title: targetBoard.title,
          taskItemList: [shrinkItem]);
      targetList.replaceRange(boardIndex, boardIndex + 1, [replaceBoard]);
    } else {
      targetBoard.taskItemList.insert(
          targetBoard.taskItemList.isEmpty ? 1 : insertingTaskIndex,
          shrinkItem);
    }

    // TODO: position mapに別ボードに残っているshrink itemがないため、削除できない
    // TODO: 一度ページ移動して戻ると、別ボードの要素が消されていく。
    // TODO: ページ移動していないのに、他ボードにアイテムを移動できてしまう。

    //同じワークボード内で移動した場合、それぞれのindexで削除対象を判定
    if (currentShrinkItemBoardIndex != -1 &&
        currentShrinkItemTaskItemIndex != -1 &&
        targetBoard.taskItemList.isNotEmpty) {
      if (insertingBoardId == targetList[currentShrinkItemBoardIndex].boardId) {
        targetBoard.taskItemList.removeAt(
            currentShrinkItemTaskItemIndex < insertingTaskIndex
                ? currentShrinkItemTaskItemIndex
                : currentShrinkItemTaskItemIndex + 1);
        //別ワークボード内で移動した場合
      } else {
        targetList[currentShrinkItemBoardIndex]
            .taskItemList
            .removeAt(currentShrinkItemTaskItemIndex);
      }
    }

    update(
      (data) {
        state = const AsyncLoading();
        return data = targetList;
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  // Drag completed
  Future<void> replaceDraggedItem({
    required TaskItemModel draggingItem,
  }) async {
    _logger.d("=== replaceDraggedItem ===");

    var targetList = _getCopiedList();

    final currentShrinkItemBoardIndex =
        getBoardIndexByTaskId(taskItemId: kShrinkId);
    if (currentShrinkItemBoardIndex == -1) {
      _logger.e("shrink itemがボード内に存在しません。");
      return;
    }

    final currentShrinkItemTaskItemIndex = getTaskItemIndex(
      boardId: targetList[currentShrinkItemBoardIndex].boardId,
      taskItemId: kShrinkId,
    );
    if (currentShrinkItemTaskItemIndex == -1) {
      _logger.e("shrink itemのindexが取得できません。");
      return;
    }

    // drag完了時に別ボードカード内にshrink itemがある場合
    targetList[currentShrinkItemBoardIndex]
        .taskItemList[currentShrinkItemTaskItemIndex] = draggingItem.copyWith(
      boardId: targetList[currentShrinkItemBoardIndex].boardId,
    );

    update(
      (data) {
        state = const AsyncLoading();
        return data = targetList;
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }
}
