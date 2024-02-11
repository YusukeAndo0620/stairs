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
  final _logger = stairsLogger(name: 'board_provider');

  @override
  FutureOr<List<BoardModel>> build(
      {required String projectId, required StairsDatabase database}) async {
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
    _logger.d('ボード一覧取得 projectId: $projectId');
    // Repository(APIの取得)の状態を管理する
    final boardRepositoryProvider =
        Provider((ref) => BoardRepository(db: database));

    // API通信開始
    final repository = ref.read(boardRepositoryProvider);
    List<BoardModel> list = [];
    try {
      list = await repository.getBoardList(projectId: projectId);
      _logger.d('取得データ: $list');
    } catch (e) {
      _logger.e(e);
    }
    return list;
  }

  Future<void> addBoard({
    required String projectId,
    required String title,
  }) async {
    const uuid = Uuid();
    final emitList = _getCopiedList();
    final orderNo = emitList.length+1;

    emitList.add(
      BoardModel(
        projectId: projectId,
        boardId: uuid.v4(),
        title: title,
        orderNo: orderNo,
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
            devLangId: '',
            startDate: DateTime.now(),
            dueDate: dueDate,
            orderNo: emitList[targetBoardIndex].taskItemList.length + 1,
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
    required String devLangId,
    required int orderNo,
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
      orderNo: emitList[targetBoardIndex].orderNo,
      taskItemList: emitList[targetBoardIndex].taskItemList,
    );
    final replaceTaskItem = TaskItemModel(
      boardId: boardId,
      taskItemId: taskItemId,
      title: title,
      description: description,
      devLangId: devLangId,
      orderNo: orderNo,
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
    required int orderNo,
  }) async {
    final boardIndex = getBoardIndex(boardId: boardId);
    if (boardIndex == -1) return;
    final emitList = _getCopiedList();
    final taskItemIndex = getTaskItemIndex(
      boardId: boardId,
      taskItemId: taskItemId,
    );
    emitList[boardIndex].taskItemList[taskItemIndex] =
        getShrinkItem(boardId: boardId, orderNo: orderNo);
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
    _logger.d("[ShrinkItem置換]");
    _logger.d("対象board id: $insertingBoardId");
    _logger.d("タスクアイテム挿入位置: $insertingTaskIndex");

    // ShrinkItemを追加する対象のBoard
    final boardIndex = getBoardIndex(boardId: insertingBoardId);
    if (boardIndex == -1) {
      _logger.d("追加対象のボードが存在しません。");
      return;
    }
    // ボードリスト
    var targetList = _getCopiedList();

    // 1. 全てのボード内タスクリストからShrinkItemを削除する
    for (final item in targetList) {
      if (hasShrinkItem(item.boardId)) {
        final delTargetIndex =
            getTaskItemIndex(boardId: item.boardId, taskItemId: kShrinkId);
        item.taskItemList.removeAt(delTargetIndex);
      }
    }

    // 2. 対象のタスクリストにShrinkItemを追加する
    // 修正対象のボード
    final targetBoard = targetList[boardIndex];
    // 追加するShrinkItem
    final shrinkItem = getShrinkItem(
        boardId: insertingBoardId, orderNo: insertingTaskIndex + 1);

    // ShrinkItem追加
    targetBoard.taskItemList.add(shrinkItem);

    // 3. 移動前、後のボードに登録されているタスクリストの表示順を修正する
    for (final item in targetList) {
      _setSortedTaskList(taskList: item.taskItemList);
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
    _logger.d("DragItem置き換え実施 {task item title: ${draggingItem.title}}");

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

    // drag完了時に別ボードカード内にShrinkItemを差しかえる
    // 表示順番号はShrinkItemのOrderNoを設定
    final orderNo = targetList[currentShrinkItemBoardIndex]
        .taskItemList[currentShrinkItemTaskItemIndex]
        .orderNo;
    targetList[currentShrinkItemBoardIndex]
        .taskItemList[currentShrinkItemTaskItemIndex] = draggingItem.copyWith(
      boardId: targetList[currentShrinkItemBoardIndex].boardId,
      orderNo: orderNo,
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

  // 表示順を修正並び替えしたリストを取得。
  List<TaskItemModel> getSortedTaskList(
      {required List<TaskItemModel> taskList}) {
    final List<TaskItemModel> targetList = [];
    final list = [...taskList];
    // ShrinkItemがある場合、ShrinkItemを上にセット
    list.sort((a, b) => a.orderNo.compareTo(b.orderNo) != 0
        ? a.orderNo.compareTo(b.orderNo)
        : a.taskItemId == kShrinkId
            ? -1
            : 1);
    for (int i = 0; i < list.length; i++) {
      final task = list[i].copyWith(orderNo: i + 1);
      targetList.add(task);
    }
    return targetList;
  }

  // 表示順を修正する。
  void _setSortedTaskList({required List<TaskItemModel> taskList}) {
    // ShrinkItemがある場合、ShrinkItemを上にセット
    taskList.sort((a, b) => a.orderNo.compareTo(b.orderNo) != 0
        ? a.orderNo.compareTo(b.orderNo)
        : a.taskItemId == kShrinkId
            ? -1
            : 1);
    for (int i = 0; i < taskList.length; i++) {
      taskList[i].copyWith(orderNo: i + 1);
    }
  }

  /// ShrinkItemを取得。
  TaskItemModel getShrinkItem({required String boardId, required int orderNo}) {
    return TaskItemModel(
      boardId: boardId,
      taskItemId: kShrinkId,
      title: '',
      description: '',
      devLangId: '',
      orderNo: orderNo,
      startDate: DateTime.now(),
      dueDate: DateTime.now(),
      labelList: [],
    );
  }
}
