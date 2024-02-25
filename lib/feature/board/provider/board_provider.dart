import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/board/model/board_model.dart';
import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:stairs/feature/board/provider/drag_item_provider.dart';
import 'package:stairs/feature/board/repository/board_repository.dart';
import 'package:stairs/feature/board/repository/task_repository.dart';
import 'package:stairs/feature/common/provider/view/toast_msg_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';

part 'board_provider.g.dart';

class BoardState extends Equatable {
  const BoardState({
    required this.projectId,
    required this.boardList,
  });

  final String projectId;
  final List<BoardModel> boardList;

  @override
  List<Object?> get props => [
        projectId,
        boardList,
      ];

  BoardState copyWith({
    String? projectId,
    List<BoardModel>? boardList,
  }) =>
      BoardState(
        projectId: projectId ?? this.projectId,
        boardList: boardList ?? this.boardList,
      );
}

@riverpod
class Board extends _$Board {
  final _logger = stairsLogger(name: 'board_provider');

  @override
  FutureOr<BoardState> build({required String projectId}) async {
    final list = await getList(projectId: projectId);
    return BoardState(projectId: projectId, boardList: list);
  }

  /// Copied state value.
  List<BoardModel> _getCopiedList() {
    if (state.value == null) return [];
    return [...state.value!.boardList];
  }

  /// ShrinkItemが対象ボードに含まれているか確認
  bool hasShrinkItem(String boardId) {
    final targetBoard = state.value!.boardList.firstWhereOrNull(
      (element) => element.boardId == boardId,
    );
    if (targetBoard == null) return false;
    return targetBoard.taskItemList
            .firstWhereOrNull((element) => element.taskItemId == kShrinkId) !=
        null;
  }

  /// ボードIDからボードのindexを取得
  int getBoardIndex({required String boardId}) {
    return state.value!.boardList.indexWhere(
      (element) => element.boardId == boardId,
    );
  }

  /// タスクアイテムIDから該当ボードのindexを取得
  int getBoardIndexByTaskId({required String taskItemId}) {
    int boardIdx = -1;
    for (final element in state.value!.boardList) {
      final taskItem = element.taskItemList
          .firstWhereOrNull((item) => item.taskItemId == taskItemId);
      if (taskItem == null) continue;
      boardIdx = getBoardIndex(boardId: element.boardId);
      break;
    }
    return boardIdx;
  }

  /// ボードIDとタスクアイテムIDから該当ボードにあるタスクのindexを取得
  int getTaskItemIndex({
    required String boardId,
    required String taskItemId,
  }) {
    if (getBoardIndex(boardId: boardId) == -1) return -1;
    return state.value!.boardList[getBoardIndex(boardId: boardId)].taskItemList
        .indexWhere((element) => element.taskItemId == taskItemId);
  }

  /// DBからボード一覧を取得し、stateに設定
  Future<void> setBoardList({required String projectId}) async {
    try {
      final list = await getList(projectId: projectId);
      update(
        (data) {
          state = const AsyncLoading();
          return data = data.copyWith(boardList: list);
        },
        onError: (error, stack) {
          state = AsyncError(error, stack);
          throw Exception(error);
        },
      );
    } catch (e) {
      _logger.e(e);
    }
  }

  // ボード一覧取得
  Future<List<BoardModel>> getList({required String projectId}) async {
    _logger.d('ボード一覧取得 projectId: $projectId');
    // DBプロバイダー
    final database = ref.watch(databaseProvider);
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
      // トーストプロバイダー
      final toastMsgNotifier = ref.watch(toastMsgProvider.notifier);
      await toastMsgNotifier.showToast(
          type: MessageType.error, msg: msgList['brd-err001']);
    }
    return list;
  }

  // 新規ボード追加
  Future<void> addBoard({
    required String projectId,
    required String title,
  }) async {
    _logger.d('ボード追加 開始');

    const uuid = Uuid();
    final orderNo = state.value!.boardList.length + 1;
    try {
      final board = BoardModel(
        projectId: projectId,
        boardId: uuid.v4(),
        title: title,
        orderNo: orderNo,
        taskItemList: const <TaskItemModel>[],
      );
      // DB更新
      // DBプロバイダー
      final database = ref.watch(databaseProvider);
      // ボードプロバイダー
      final boardRepositoryProvider =
          Provider((ref) => BoardRepository(db: database));
      //API通信用 Repository
      final repository = ref.read(boardRepositoryProvider);
      // ボード追加
      await repository.createBoard(boardModel: board);
    } catch (e) {
      _logger.e(e);
      // トーストプロバイダー
      final toastMsgNotifier = ref.watch(toastMsgProvider.notifier);
      await toastMsgNotifier.showToast(
          type: MessageType.error, msg: msgList['err001']);
    } finally {
      _logger.d('ボード追加 終了');

      // state更新
      update(
        (data) async {
          state = const AsyncLoading();
          final list = await getList(projectId: projectId);
          return data = data.copyWith(boardList: list);
        },
        onError: (error, stack) {
          state = AsyncError(error, stack);
          throw Exception(error);
        },
      );
    }
  }

  // 新規タスク追加
  Future<void> addTaskItem({
    required String boardId,
    required String title,
    required DateTime dueDate,
    required List<ColorLabelModel> labelList,
  }) async {
    _logger.d('タスク追加 開始');
    try {
      final boardList = _getCopiedList();
      final targetBoardIndex = getBoardIndex(boardId: boardId);
      if (targetBoardIndex == -1) return;

      const uuid = Uuid();
      final task = TaskItemModel(
        boardId: boardId,
        taskItemId: uuid.v4(),
        title: title,
        description: '',
        devLangId: '',
        startDate: DateTime.now(),
        dueDate: dueDate,
        orderNo: boardList[targetBoardIndex].taskItemList.length + 1,
        labelList: labelList,
      );

      // DB更新
      // DBプロバイダー
      final database = ref.watch(databaseProvider);
      // タスクプロバイダー
      final taskRepositoryProvider =
          Provider((ref) => TaskRepository(db: database));
      //API通信用 Repository
      final repository = ref.read(taskRepositoryProvider);
      // タスク追加
      await repository.addTask(taskItemModel: task);
    } catch (e) {
      _logger.e(e);
      // トーストプロバイダー
      final toastMsgNotifier = ref.watch(toastMsgProvider.notifier);
      await toastMsgNotifier.showToast(
          type: MessageType.error, msg: msgList['err001']);
    } finally {
      _logger.d('タスク追加 終了');
      update(
        (data) async {
          state = const AsyncLoading();
          final list = await getList(projectId: projectId);
          return data = data.copyWith(boardList: list);
        },
        onError: (error, stack) {
          state = AsyncError(error, stack);
          throw Exception(error);
        },
      );
    }
  }

  // タスク更新
  Future<void> updateTaskItem({
    required String boardId,
    required String taskItemId,
    required String title,
    required String description,
    required String devLangId,
    required int orderNo,
    required DateTime startDate,
    required DateTime dueDate,
    DateTime? doneDate,
    required List<ColorLabelModel> labelList,
  }) async {
    _logger.d('タスク更新 開始');

    try {
      final taskItem = TaskItemModel(
        boardId: boardId,
        taskItemId: taskItemId,
        title: title,
        description: description,
        devLangId: devLangId,
        orderNo: orderNo,
        startDate: startDate,
        dueDate: dueDate,
        doneDate: doneDate,
        labelList: labelList,
      );
      // 現在のタスクを取得
      final currentTask =
          state.value!.boardList[getBoardIndex(boardId: boardId)].taskItemList[
              getTaskItemIndex(boardId: boardId, taskItemId: taskItemId)];
      // タスクに紐づくラベルが更新されているかどうか
      final isUpdateTag = currentTask.labelList.length != labelList.length ||
          labelList
              .map((label) => !currentTask.labelList.contains(label))
              .toList()
              .isNotEmpty;

      // DB更新
      // DBプロバイダー
      final database = ref.watch(databaseProvider);
      // タスクプロバイダー
      final taskRepositoryProvider =
          Provider((ref) => TaskRepository(db: database));
      //API通信用 Repository
      final repository = ref.read(taskRepositoryProvider);
      // タスク更新
      await repository.updateTask(
          taskItemModel: taskItem, isUpdateTag: isUpdateTag);
    } catch (e) {
      _logger.e(e);
      // トーストプロバイダー
      final toastMsgNotifier = ref.watch(toastMsgProvider.notifier);
      await toastMsgNotifier.showToast(
          type: MessageType.error, msg: msgList['err001']);
    } finally {
      _logger.d('タスク更新 終了');
      // state更新
      update(
        (data) async {
          state = const AsyncLoading();
          final list = await getList(projectId: projectId);
          return data = data.copyWith(boardList: list);
        },
        onError: (error, stack) {
          state = AsyncError(error, stack);
          throw Exception(error);
        },
      );
    }
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
        return data = data.copyWith(boardList: emitList);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  // ドラッグ開始時にドラッグしたタスクをShrinkItemに変換
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
        return data = data.copyWith(boardList: emitList);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  // ドラッグごとにShrinkItemを対象位置に移動する
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
      _logger.e("追加対象のボードが存在しません。");
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
        return data = data.copyWith(boardList: targetList);
      },
      onError: (error, stack) {
        state = AsyncError(error, stack);
        throw Exception(error);
      },
    );
  }

  // ドラッグ完了時に、ShrinkItemをドラッグ要素に変換する
  Future<void> replaceDraggedItem({
    required String beforeBoardId,
    required TaskItemModel draggingItem,
  }) async {
    _logger.d("DragItem置き換え 開始 {task item title: ${draggingItem.title}}");

    try {
      var targetList = _getCopiedList();
      final currentShrinkItemBoardIndex =
          getBoardIndexByTaskId(taskItemId: kShrinkId);
      if (currentShrinkItemBoardIndex == -1) {
        _logger.e("shrink itemがボード内に存在しません。");
        throw Exception();
      }

      final currentShrinkItemTaskItemIndex = getTaskItemIndex(
        boardId: targetList[currentShrinkItemBoardIndex].boardId,
        taskItemId: kShrinkId,
      );
      if (currentShrinkItemTaskItemIndex == -1) {
        _logger.e("shrink itemのindexが取得できません。");
        throw Exception();
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
      // DB更新
      // DBプロバイダー
      final database = ref.watch(databaseProvider);
      // タスクプロバイダー
      final taskRepositoryProvider =
          Provider((ref) => TaskRepository(db: database));
      //API通信用 Repository
      final repository = ref.read(taskRepositoryProvider);
      // ドラッグ前とドラッグ後のボードのタスクリスト
      final updateTaskList = [
        ...targetList[getBoardIndex(boardId: beforeBoardId)].taskItemList,
        ...targetList[currentShrinkItemBoardIndex].taskItemList
      ];
      // タスクの番号順更新
      await repository.updateTaskOrderNo(taskItemModelList: updateTaskList);
    } catch (e) {
      _logger.e(e);
      // トーストプロバイダー
      final toastMsgNotifier = ref.watch(toastMsgProvider.notifier);
      await toastMsgNotifier.showToast(
          type: MessageType.error, msg: msgList['brd-err002']);
    } finally {
      _logger.d('DragItem置き換え 終了');
      // state更新
      update(
        (data) async {
          state = const AsyncLoading();
          final list = await getList(projectId: projectId);
          return data = data.copyWith(boardList: list);
        },
        onError: (error, stack) {
          state = AsyncError(error, stack);
          throw Exception(error);
        },
      );
    }
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
