import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/board/component/provider/board_position_provider.dart';
import 'package:stairs/feature/board/component/provider/carousel_provider.dart';
import 'package:stairs/feature/board/component/view/new_task_item.dart';
import 'package:stairs/feature/board/component/view/shrink_list_item.dart';
import 'package:stairs/feature/board/component/view/task_edit_modal.dart';
import 'package:stairs/feature/board/component/view/task_list_item.dart';
import 'package:stairs/feature/board/model/board_position_model.dart';
import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:stairs/feature/board/provider/board_provider.dart';
import 'package:stairs/feature/board/provider/drag_item_provider.dart';
import 'package:stairs/feature/board/provider/task_item_provider.dart';
import 'package:stairs/feature/board/view/board_screen.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kBorderWidth = 1.0;
const _kBoardAddBtnSpace = 16.0;
const _kListAndAddBtnSpace = 16.0;
const _kMovingDownHeight = 150.0;
const _kPageStorageKeyPrefixTxt = 'PageStorageKey_';
const _kBoardAddBtnTxt = 'タスクを追加';
const _kCancelBtnTxt = 'キャンセル';
const _kAddBtnTxt = '追加';

const _kAnimatedDuration = Duration(milliseconds: 300);

const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
const _kContentMargin = EdgeInsets.only(
  top: 24,
  bottom: 48.0,
  left: 16.0,
  right: 40.0,
);

///ボードカード
class BoardCard extends ConsumerStatefulWidget {
  const BoardCard({
    super.key,
    required this.projectId,
    required this.boardId,
    required this.displayedBoardId,
    required this.title,
    required this.themeColor,
    required this.devLangList,
    required this.labelList,
    required this.taskItemList,
    required this.onPageChanged,
  });
  final String projectId;
  final String boardId;
  final String displayedBoardId;
  final String title;
  final Color themeColor;
  final List<LabelWithContent> devLangList;
  final List<ColorLabelModel> labelList;
  final List<TaskItemModel> taskItemList;
  final Function(PageAction) onPageChanged;

  @override
  ConsumerState<BoardCard> createState() => _BoardCardState();
}

class _BoardCardState extends ConsumerState<BoardCard> {
  bool _isAddedNewTask = false;
  bool _isMovingLast = false;
  final _scrollController = ScrollController();
  final boardCardKey = GlobalKey<_BoardCardState>();
  final _logger = stairsLogger(name: 'board_card');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    // ボード
    final boardNotifier = ref.watch(boardProvider(
            projectId: widget.projectId, database: ref.watch(databaseProvider))
        .notifier);

    // 新規タスク
    final taskItemState = ref.watch(taskItemProvider(taskItemId: ''));
    final taskItemNotifier =
        ref.watch(taskItemProvider(taskItemId: '').notifier);

    // ドラッグアイテム
    final dragItemNotifier = ref.watch(dragItemProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (taskItemState.boardId.isEmpty) {
          taskItemNotifier.setItem(boardId: widget.boardId);
        }
        if (_isAddedNewTask) {
          await Future.delayed(const Duration(milliseconds: 50)).then(
            (value) => _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: _kAnimatedDuration,
              curve: Curves.easeIn,
            ),
          );
        }
        if (_isMovingLast) {
          await Future.delayed(const Duration(milliseconds: 50)).then(
            (value) => _scrollController.jumpTo(
              _scrollController.position.maxScrollExtent,
            ),
          );
          _isMovingLast = false;
        }
      },
    );

    return DragTarget<String>(
      key: ValueKey(widget.boardId),
      builder: (context, accepted, rejected) {
        return Container(
          padding: _kContentPadding,
          margin: _kContentMargin,
          decoration: BoxDecoration(
            color: theme.colorFgDefaultWhite,
            border: Border.all(
              color: theme.colorFgDisabled,
              width: _kBorderWidth,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Header(
                key: widget.key,
                title: widget.title,
                listSize: widget.taskItemList.length,
              ),
              Expanded(
                key: boardCardKey,
                child: SingleChildScrollView(
                  key: PageStorageKey(
                      _kPageStorageKeyPrefixTxt + widget.boardId),
                  controller: _scrollController,
                  child: Column(
                    children: [
                      for (final item in widget.taskItemList) ...[
                        if (item.taskItemId == kShrinkId)
                          ShrinkTaskListItem(
                            key: widget.key,
                            taskItemId: kShrinkId,
                          )
                        else
                          TaskListItem(
                            boardId: widget.boardId,
                            taskItemId: item.taskItemId,
                            title: item.title,
                            dueDate: item.dueDate,
                            themeColor: widget.themeColor,
                            labelList: item.labelList,
                            onTap: (taskItem) async {
                              final result = await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return TaskEditModal(
                                    themeColor: widget.themeColor,
                                    taskItem: item,
                                    labelList: widget.labelList,
                                    onChangeTaskItem: (taskItemVal) {},
                                  );
                                },
                              );
                              if (result == null) {
                                boardNotifier.updateTaskItem(
                                  boardId: taskItem.boardId,
                                  taskItemId: taskItem.taskItemId,
                                  title: taskItem.title,
                                  description: taskItem.description,
                                  startDate: taskItem.startDate,
                                  dueDate: taskItem.dueDate,
                                  labelList: taskItem.labelList,
                                );
                              }
                            },
                            onDragStarted: () {
                              dragItemNotifier.setItem(
                                  boardId: item.boardId, draggingItem: item);

                              boardNotifier.replaceShrinkItem(
                                boardId: widget.boardId,
                                taskItemId: item.taskItemId,
                              );

                              // positionNotifier.setTaskItemPosition(
                              //     taskItemId: kShrinkId, key: boardCardKey);
                            },
                            onDragUpdate: (detail) async {},
                            onDragCompleted: () {},
                            onDraggableCanceled: (velocity, offset) {
                              // ドラッグアイテム
                              final dragItemState = ref.watch(dragItemProvider);
                              boardNotifier.replaceDraggedItem(
                                  draggingItem: dragItemState.draggingItem!);

                              dragItemNotifier.init();
                            },
                          ),
                      ],
                      if (_isAddedNewTask) ...[
                        NewTaskItem(
                          boardId: widget.boardId,
                          themeColor: widget.themeColor,
                          title: taskItemState.title,
                          dueDate: taskItemState.dueDate,
                          selectedLabelList: taskItemState.labelList,
                          labelList: widget.labelList,
                          updateTitle: (value) =>
                              taskItemNotifier.updateTitle(title: value),
                          updateDueDate: (dueDate) =>
                              taskItemNotifier.updateDueDate(dueDate: dueDate),
                          updateLabelList: (labelList) => taskItemNotifier
                              .updateLabelList(labelList: labelList),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
              if (_isAddedNewTask) ...[
                const SizedBox(
                  height: _kListAndAddBtnSpace,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextButton(
                      title: _kCancelBtnTxt,
                      themeColor: widget.themeColor,
                      onTap: () => setState(
                        () {
                          _isAddedNewTask = false;
                        },
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: taskItemState.title.isEmpty,
                      child: CustomTextButton(
                        title: _kAddBtnTxt,
                        themeColor: widget.themeColor,
                        disabled: taskItemState.title.isEmpty,
                        onTap: () {
                          setState(
                            () {
                              _isAddedNewTask = false;
                              _isMovingLast = true;
                            },
                          );

                          boardNotifier.addTaskItem(
                              boardId: widget.boardId,
                              title: taskItemState.title,
                              dueDate: taskItemState.dueDate,
                              labelList: taskItemState.labelList);

                          taskItemNotifier.init();
                        },
                      ),
                    ),
                  ],
                ),
              ],
              if (!_isAddedNewTask)
                _AddingItemButton(
                  key: widget.key,
                  themeColor: widget.themeColor,
                  onTapAddingBtn: () => setState(
                    () {
                      _isAddedNewTask = true;
                    },
                  ),
                )
            ],
          ),
        );
      },
      onMove: (details) {
        final carouselDisplayState = ref.watch(carouselProvider);
        // ポジション
        final positionState = ref.watch(boardPositionProvider);
        final positionNotifier = ref.watch(boardPositionProvider.notifier);

        if (!carouselDisplayState.isReady) return;
        _logger.i('====Drag開始 {board id:${widget.boardId}}====');
        final cardWidth = boardCardKey.currentContext!.size!.width;
        const previousCriteria = 60.0;
        final nextCriteria = cardWidth * 0.4;

        // positionを更新
        positionNotifier.setBoardPosition(
            boardId: widget.boardId, key: boardCardKey);

        _logger.d("ドラッグアイテム dx:${details.offset.dx}");
        _logger.d("次ページ遷移基準 dx:$nextCriteria");
        _logger.d("前ページ遷移基準 dx:$previousCriteria");
        // カード内移動
        if (details.offset.dx < nextCriteria &&
            previousCriteria < details.offset.dx) {
          _logger.i('=縦スクロール移動=');
          onMoveVertical(
            boardCardKey: boardCardKey,
            dy: details.offset.dy,
            positionState: positionState,
            boardNotifier: boardNotifier,
          );
        } else {
          _logger.i('=横ページ移動=');
          // 横ページ移動
          onMoveHorizontal(
            dx: details.offset.dx,
            dy: details.offset.dy,
            criteriaMovingNext: nextCriteria,
            positionState: positionState,
            boardNotifier: boardNotifier,
          );
        }
      },
      onAcceptWithDetails: (details) {
        // ドラッグアイテム
        final dragItemState = ref.watch(dragItemProvider);

        boardNotifier.replaceDraggedItem(
            draggingItem: dragItemState.draggingItem!);
        dragItemNotifier.init();
      },
      onLeave: (data) {},
      onWillAccept: (data) {
        return false;
      },
    );
  }

  // カード内移動
  Future<void> onMoveVertical({
    required GlobalKey boardCardKey,
    required double dy,
    required BoardPositionModel positionState,
    required Board boardNotifier,
  }) async {
    if (positionState.taskItemPositionMap[kShrinkId] == null) {
      return;
    }
    final boardPosition = positionState.boardPositionMap[widget.boardId];

    if (boardPosition == null) return;
    // カード内移動
    // 縦スクロール
    //下に移動
    if (_scrollController.offset < _scrollController.position.maxScrollExtent &&
        boardCardKey.currentContext!.size!.height / 2 + 125 < dy) {
      _scrollController.animateTo(
        _scrollController.offset + _kMovingDownHeight,
        duration: _kAnimatedDuration,
        curve: Curves.linear,
      );
      //上に移動
    } else if (_scrollController.offset > 0 &&
        boardCardKey.currentContext!.size!.height / 2 - 100 > dy) {
      _scrollController.animateTo(
        _scrollController.offset - _kMovingDownHeight,
        duration: _kAnimatedDuration,
        curve: Curves.linear,
      );
    }
    replaceShrinkItem(
      positionState: positionState,
      currentDraggingItemDy: dy,
      boardNotifier: boardNotifier,
    );
  }

  // ページ移動
  Future<void> onMoveHorizontal({
    required double dx,
    required double dy,
    required double criteriaMovingNext,
    required BoardPositionModel positionState,
    required Board boardNotifier,
  }) async {
    if (criteriaMovingNext < dx) {
      _logger.i('=次ページ移動=');
      widget.onPageChanged(PageAction.next);
    } else if (dx < criteriaMovingNext) {
      _logger.i('=前ページ移動=');
      widget.onPageChanged(PageAction.previous);
    }
    replaceShrinkItem(
      positionState: positionState,
      currentDraggingItemDy: dy,
      boardNotifier: boardNotifier,
    );
  }

  void replaceShrinkItem({
    required BoardPositionModel positionState,
    required double currentDraggingItemDy,
    required Board boardNotifier,
  }) {
    _logger.d('shrink item 置換開始');
    if (positionState.taskItemPositionMap[kShrinkId] == null) return;
    final shrinkItemDy = positionState.taskItemPositionMap[kShrinkId]!.dy;
    if (shrinkItemDy - (kDraggedItemHeight / 2) < currentDraggingItemDy &&
        currentDraggingItemDy < shrinkItemDy + (kDraggedItemHeight / 2)) {
      _logger.d('shrink itemの位置に変化なし');
      return;
    }

    for (final item in widget.taskItemList) {
      if (positionState.taskItemPositionMap[item.taskItemId] == null) {
        continue;
      }
      if (positionState.taskItemPositionMap[item.taskItemId]!.dy >=
          currentDraggingItemDy) {
        _logger.d('shrink item 差し替え');
        final insertingShrinkItemIndex = widget.taskItemList
            .indexWhere((element) => element.taskItemId == item.taskItemId);
        _logger.d('shrink item 挿入するindex: $insertingShrinkItemIndex');
        boardNotifier.deleteAndAddShrinkItem(
            insertingBoardId: widget.boardId,
            insertingTaskIndex: insertingShrinkItemIndex);

        return;
      }
    }
    _logger.d('shrink item 末尾に挿入');
    boardNotifier.deleteAndAddShrinkItem(
        insertingBoardId: widget.boardId,
        insertingTaskIndex: widget.taskItemList.length);
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
    required this.title,
    required this.listSize,
  });
  final String title;
  final int listSize;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Container(
      padding: _kContentPadding,
      decoration: BoxDecoration(
        color: theme.colorFgDefaultWhite,
        border: Border(
          bottom: BorderSide(
            color: theme.colorFgDisabled,
            width: _kBorderWidth,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                theme.textStyleSubHeading.copyWith(color: theme.colorFgDefault),
          ),
          Text('${listSize.toString()} 件'),
        ],
      ),
    );
  }
}

class _AddingItemButton extends StatelessWidget {
  const _AddingItemButton({
    super.key,
    required this.themeColor,
    required this.onTapAddingBtn,
  });
  final Color themeColor;
  final VoidCallback onTapAddingBtn;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return TapAction(
      key: key,
      tappedColor: themeColor,
      padding: _kContentPadding,
      border: Border.all(
        color: themeColor,
        width: _kBorderWidth,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      onTap: onTapAddingBtn,
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            theme.icons.add,
            color: themeColor,
          ),
          const SizedBox(
            width: _kBoardAddBtnSpace,
          ),
          Text(
            _kBoardAddBtnTxt,
            style: theme.textStyleBody,
          ),
        ],
      ),
    );
  }
}
