import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/board/component/provider/board_position_provider.dart';
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
  left: 20.0,
  right: 20.0,
);
final _logger = stairsLogger(name: 'board_card');

///ボードカード
class BoardCard extends ConsumerStatefulWidget {
  const BoardCard({
    super.key,
    required this.projectId,
    required this.boardId,
    required this.title,
    required this.themeColor,
    required this.devLangList,
    required this.labelList,
    required this.taskItemList,
    required this.onPageChanged,
  });
  final String projectId;
  final String boardId;
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
  // 新規タスクアイテム入力のカード表示状態
  bool _isNewTaskShown = false;

  // タスクが追加された後、リストの最下部まで移動するかどうか
  bool _isMovingLast = false;

  // ドラッグできる状態かどうかを管理
  bool _isMovingReady = false;

  final _scrollController = ScrollController();
  final boardCardKey = GlobalKey<_BoardCardState>();

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
    _logger.d('===================================');
    _logger.d('ビルド開始 {board_title:${widget.title}}');

    final theme = LoomTheme.of(context);
    // 新規タスク
    final taskItemState = ref.watch(taskItemProvider(taskItemId: ''));
    // ドラッグアイテム
    final dragItemState = ref.watch(dragItemProvider);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        // positionを更新
        final positionNotifier = ref.read(boardPositionProvider.notifier);
        positionNotifier.setBoardPosition(
            boardId: widget.boardId, key: boardCardKey);

        // taskItemStateを初期化
        if (taskItemState.boardId.isEmpty) {
          final taskItemNotifier =
              ref.read(taskItemProvider(taskItemId: '').notifier);
          taskItemNotifier.setItem(boardId: widget.boardId);
        }
        if (_isNewTaskShown) {
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
      onMove: (details) {
        _logger.d('[event] onMove {board id:${widget.boardId}}');
        if (!_isMovingReady) {
          _logger.d('ドラッグの準備が完了していません。');
          return;
        }

        // ポジション
        final positionState = ref.watch(boardPositionProvider);
        final boardNotifier = ref.read(boardProvider(
                projectId: widget.projectId,
                database: ref.watch(databaseProvider))
            .notifier);
        const previousCriteria = -10.0;
        const nextCriteria = 200.0;

        // カード内移動
        if (details.offset.dx < nextCriteria &&
            previousCriteria < details.offset.dx) {
          _logger.d('縦スクロール移動');
          onMoveVertical(
            boardCardKey: boardCardKey,
            dy: details.offset.dy,
            positionState: positionState,
            boardNotifier: boardNotifier,
          );
        } else {
          _logger.d('横ページ移動');
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
        _logger
            .d('[event] onAcceptWithDetails {対象のboard title:${widget.title}}');
        if (dragItemState.draggingItem != null) {
          final boardNotifier = ref.read(boardProvider(
                  projectId: widget.projectId,
                  database: ref.watch(databaseProvider))
              .notifier);
          final dragItemNotifier = ref.read(dragItemProvider.notifier);
          boardNotifier.replaceDraggedItem(
              draggingItem: dragItemState.draggingItem!);

          dragItemNotifier.init();
        }
        setState(() {
          _isMovingReady = false;
        });
      },
      onLeave: (data) {
        setState(() {
          _isMovingReady = false;
        });
      },
      onWillAccept: (data) {
        if (dragItemState.boardId != widget.boardId) {
          final dragItemNotifier = ref.read(dragItemProvider.notifier);
          dragItemNotifier.setItem(
            boardId: widget.boardId,
          );
        }
        if (!_isMovingReady) {
          setState(() {
            _isMovingReady = true;
          });
        }
        return true;
      },
      builder: (context, accepted, rejected) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.7,
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
                            themeColor: widget.themeColor,
                            title: item.title,
                            startDate: item.startDate,
                            dueDate: item.dueDate,
                            labelList: item.labelList,
                            isReadOnly: _isNewTaskShown,
                            onTap: (taskItem) async {
                              final result = await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return TaskEditModal(
                                    themeColor: widget.themeColor,
                                    taskItem: item,
                                    devLangList: widget.devLangList,
                                    labelList: widget.labelList,
                                    onChangeTaskItem: (taskItemVal) {},
                                  );
                                },
                              );
                              if (result == null) {
                                final boardNotifier = ref.read(boardProvider(
                                        projectId: widget.projectId,
                                        database: ref.watch(databaseProvider))
                                    .notifier);
                                final taskItemState = ref.watch(
                                    taskItemProvider(
                                        taskItemId: taskItem.taskItemId));
                                boardNotifier.updateTaskItem(
                                  boardId: taskItemState.boardId,
                                  taskItemId: taskItemState.taskItemId,
                                  title: taskItemState.title,
                                  description: taskItemState.description,
                                  devLangId: taskItemState.devLangId,
                                  orderNo: taskItemState.orderNo,
                                  startDate: taskItemState.startDate,
                                  dueDate: taskItemState.dueDate,
                                  labelList: taskItemState.labelList,
                                );
                              }
                            },
                            onDragStarted: () {
                              _logger.d(
                                  '[event] onDragStarted {board_title:${widget.title}}');
                              final dragItemNotifier =
                                  ref.read(dragItemProvider.notifier);
                              final boardNotifier = ref.read(boardProvider(
                                      projectId: widget.projectId,
                                      database: ref.watch(databaseProvider))
                                  .notifier);

                              dragItemNotifier.setItem(
                                boardId: item.boardId,
                                draggingItem: item,
                              );

                              boardNotifier.replaceShrinkItem(
                                boardId: widget.boardId,
                                taskItemId: item.taskItemId,
                                orderNo: item.orderNo,
                              );
                            },
                            onDragUpdate: (detail) async {},
                            onDragCompleted: () {
                              _logger.d(
                                  '[event] onDragCompleted {board_title:${widget.title}}');
                            },
                            onDragEnd: (_) {
                              _logger.d(
                                  '[event] onDragEnd {board_title:${widget.title}}');
                            },
                            onDraggableCanceled: (velocity, offset) {
                              _logger.d(
                                  '[event] onDraggableCanceled {board_title:${widget.title}}');
                              if (dragItemState.draggingItem == null) {
                                _logger.d('draggingItemがありません。');
                                return;
                              }
                              final dragItemNotifier =
                                  ref.read(dragItemProvider.notifier);
                              final boardNotifier = ref.read(boardProvider(
                                      projectId: widget.projectId,
                                      database: ref.watch(databaseProvider))
                                  .notifier);

                              boardNotifier.replaceDraggedItem(
                                  draggingItem: dragItemState.draggingItem!);

                              dragItemNotifier.init();
                              setState(() {
                                _isMovingReady = false;
                              });
                            },
                          ),
                      ],
                      if (_isNewTaskShown) ...[
                        NewTaskItem(
                          boardId: widget.boardId,
                          themeColor: widget.themeColor,
                          title: taskItemState.title,
                          dueDate: taskItemState.dueDate,
                          selectedLabelList: taskItemState.labelList,
                          labelList: widget.labelList,
                          updateTitle: (value) {
                            final taskItemNotifier = ref.read(
                                taskItemProvider(taskItemId: '').notifier);
                            taskItemNotifier.updateTitle(title: value);
                          },
                          updateDueDate: (dueDate) {
                            final taskItemNotifier = ref.read(
                                taskItemProvider(taskItemId: '').notifier);
                            taskItemNotifier.updateDueDate(dueDate: dueDate);
                          },
                          updateLabelList: (labelList) {
                            final taskItemNotifier = ref.read(
                                taskItemProvider(taskItemId: '').notifier);
                            taskItemNotifier.updateLabelList(
                                labelList: labelList);
                          },
                        ),
                      ]
                    ],
                  ),
                ),
              ),
              if (_isNewTaskShown) ...[
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
                          _isNewTaskShown = false;
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
                              _isNewTaskShown = false;
                              _isMovingLast = true;
                            },
                          );
                          final boardNotifier = ref.read(boardProvider(
                                  projectId: widget.projectId,
                                  database: ref.watch(databaseProvider))
                              .notifier);
                          final taskItemNotifier = ref
                              .read(taskItemProvider(taskItemId: '').notifier);

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
              if (!_isNewTaskShown)
                _AddingItemButton(
                  key: widget.key,
                  themeColor: widget.themeColor,
                  onTapAddingBtn: () => setState(
                    () {
                      _isNewTaskShown = true;
                    },
                  ),
                )
            ],
          ),
        );
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
      _logger.d('ShrinkItemのpositionが登録されていません。');
      return;
    }
    //下に移動
    if (_scrollController.offset < _scrollController.position.maxScrollExtent &&
        boardCardKey.currentContext!.size!.height / 2 + 125 < dy) {
      _logger.d('下方向にスクロール');
      _scrollController.animateTo(
        _scrollController.offset + _kMovingDownHeight,
        duration: _kAnimatedDuration,
        curve: Curves.linear,
      );
      //上に移動
    } else if (_scrollController.offset > 0 &&
        boardCardKey.currentContext!.size!.height / 2 - 100 > dy) {
      _logger.d('上方向にスクロール');
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
      _logger.d('次ページ移動');
      widget.onPageChanged(PageAction.next);
    } else if (dx < criteriaMovingNext) {
      _logger.d('前ページ移動');
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
    if (positionState.taskItemPositionMap[kShrinkId] == null) return;
    final shrinkItemDy = positionState.taskItemPositionMap[kShrinkId]!.dy;
    if (shrinkItemDy - (kDraggedItemHeight / 2) < currentDraggingItemDy &&
        currentDraggingItemDy < shrinkItemDy + (kDraggedItemHeight / 2)) {
      return;
    }

    for (final item in widget.taskItemList) {
      if (positionState.taskItemPositionMap[item.taskItemId] == null) {
        continue;
      }
      if (positionState.taskItemPositionMap[item.taskItemId]!.dy >=
          currentDraggingItemDy) {
        final insertingShrinkItemIndex = widget.taskItemList
            .indexWhere((element) => element.taskItemId == item.taskItemId);
        boardNotifier.deleteAndAddShrinkItem(
            insertingBoardId: widget.boardId,
            insertingTaskIndex: insertingShrinkItemIndex);

        return;
      }
    }
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
