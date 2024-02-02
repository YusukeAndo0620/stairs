import 'package:stairs/feature/board/component/view/shrink_list_item.dart';
import 'package:stairs/feature/board/model/board_model.dart';
import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:stairs/feature/board/provider/drag_item_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'dart:math';

final _logger = stairsLogger(name: 'status_screen');

final _list = [
  BoardModel(
    projectId: "0",
    boardId: "0",
    title: "1",
    taskItemList: [
      TaskItemModel(
        boardId: '0',
        taskItemId: '1',
        title: '001',
        description: '',
        startDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 7)),
        labelList: [],
      ),
      TaskItemModel(
        boardId: '0',
        taskItemId: '2',
        title: '002',
        description: '',
        startDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 7)),
        labelList: [],
      ),
      TaskItemModel(
        boardId: '0',
        taskItemId: '3',
        title: '003',
        description: '',
        startDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 7)),
        labelList: [],
      ),
    ],
  ),
  BoardModel(
    projectId: "0",
    boardId: "1",
    title: "2",
    taskItemList: [
      TaskItemModel(
        boardId: '1',
        taskItemId: '4',
        title: '004',
        description: '',
        startDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 7)),
        labelList: [],
      ),
    ],
  ),
  BoardModel(
    projectId: "0",
    boardId: "2",
    title: "3",
    taskItemList: [
      TaskItemModel(
        boardId: '2',
        taskItemId: '5',
        title: '005',
        description: '',
        startDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 7)),
        labelList: [],
      ),
    ],
  ),
];

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});
  @override
  State<StatefulWidget> createState() => _StatusScreen();
}

class _StatusScreen extends State<StatusScreen> {
  List<BoardModel> targetList = _list;
  final horizontalController = ScrollController();
  TaskItemModel? dragItem;

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
    _logger.d('ビルド開始');
    final theme = LoomTheme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: horizontalController,
      child: Row(
        children: [
          for (final item in targetList) ...[
            DragTarget<String>(
              onMove: (details) {
                _logger.d('details.offset.dx: ${details.offset.dx}');
                final criteria = MediaQuery.of(context).size.width / 2;
                _logger.d('criteria: $criteria');
                if (dragItem == null) return;
                setState(() {
                  if (dragItem!.boardId == item.boardId) {
                    if (item.taskItemList.indexWhere(
                            (element) => element.taskItemId == kShrinkId) ==
                        -1) {
                      final boardIndex = targetList.indexWhere(
                          (element) => element.boardId == item.boardId);
                      targetList[boardIndex].taskItemList.add(
                            TaskItemModel(
                              boardId: item.boardId,
                              taskItemId: kShrinkId,
                              title: '',
                              description: '',
                              startDate: DateTime.now(),
                              dueDate: DateTime.now(),
                              labelList: [],
                            ),
                          );
                    }
                  }
                });

                // if (details.offset.dx - criteria < 0) {
                //   horizontalController.animateTo(
                //       horizontalController.position.pixels + 10,
                //       duration: const Duration(milliseconds: 1),
                //       curve: Curves.linear);
                // } else {
                //   horizontalController.animateTo(
                //       horizontalController.position.pixels - 10,
                //       duration: const Duration(milliseconds: 1),
                //       curve: Curves.linear);
                // }
              },
              onLeave: (data) {
                setState(() {
                  if (dragItem == null) return;
                  final boardIndex = targetList
                      .indexWhere((element) => element.boardId == item.boardId);
                  final itemIndex = item.taskItemList
                      .indexWhere((element) => element.taskItemId == kShrinkId);
                  targetList[boardIndex].taskItemList.removeAt(itemIndex);
                });
              },
              onWillAcceptWithDetails: (details) {
                _logger.d('drag受付');
                setState(() {
                  if (dragItem == null) return;
                  dragItem = dragItem!.copyWith(boardId: item.boardId);
                });
                return true;
              },
              builder: (context, accepted, rejected) {
                return Container(
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                    color: theme.colorFgDefaultWhite,
                    border: Border.all(
                      color: theme.colorFgDisabled,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (final taskItem in item.taskItemList)
                          if (taskItem.taskItemId == kShrinkId)
                            ShrinkTaskListItem(
                              key: widget.key,
                              taskItemId: kShrinkId,
                            )
                          else
                            DragItem(
                              boardId: item.boardId,
                              taskItemId: taskItem.taskItemId,
                              title: taskItem.title,
                              onDragStarted: () {
                                _logger.d('drag開始');
                                final boardIndex = targetList.indexWhere(
                                    (element) =>
                                        element.boardId == item.boardId);
                                final itemIndex = item.taskItemList.indexWhere(
                                    (element) =>
                                        element.taskItemId ==
                                        taskItem.taskItemId);
                                setState(() {
                                  dragItem = taskItem;
                                  final tempList = targetList;

                                  tempList[boardIndex]
                                      .taskItemList
                                      .removeAt(itemIndex);
                                  targetList = tempList;
                                });
                              },
                              onDragUpdate: (p0) {
                                _logger.d('drag更新');
                              },
                              onDragCompleted: () {
                                _logger.d('drag完了');
                                setState(() {
                                  final boardIndex = targetList.indexWhere(
                                      (element) =>
                                          element.boardId == dragItem!.boardId);
                                  targetList[boardIndex]
                                      .taskItemList
                                      .add(dragItem!);
                                  dragItem = null;
                                });
                              },
                              onDraggableCanceled: (p0, p1) {
                                _logger.d('dragキャンセル');
                                setState(() {
                                  final boardIndex = targetList.indexWhere(
                                      (element) =>
                                          element.boardId == dragItem!.boardId);
                                  targetList[boardIndex]
                                      .taskItemList
                                      .add(dragItem!);
                                  dragItem = null;
                                });
                              },
                              onDragEnd: (p0) {
                                _logger.d('drag end');
                              },
                            ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

class DragItem extends StatelessWidget {
  const DragItem({
    super.key,
    required this.boardId,
    required this.taskItemId,
    required this.title,
    required this.onDragStarted,
    required this.onDragUpdate,
    required this.onDraggableCanceled,
    required this.onDragCompleted,
    required this.onDragEnd,
  });

  final String boardId;
  final String taskItemId;
  final String title;

  final VoidCallback onDragStarted;
  final Function(DragUpdateDetails) onDragUpdate;
  final Function(Velocity, Offset) onDraggableCanceled;
  final VoidCallback onDragCompleted;
  final Function(DraggableDetails) onDragEnd;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Draggable<String>(
      key: ValueKey(taskItemId),
      data: taskItemId,
      onDragStarted: onDragStarted,
      onDragUpdate: (details) => onDragUpdate(details),
      onDragCompleted: onDragCompleted,
      onDraggableCanceled: (velocity, offset) =>
          onDraggableCanceled(velocity, offset),
      onDragEnd: (details) => onDragEnd,
      feedback: _DraggingListItem(
        title: title,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: TapAction(
          width: double.infinity,
          tappedColor: theme.colorPrimary.withOpacity(0.7),
          border: Border.all(
            color: theme.colorDangerBgDefault,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5.0),
          onTap: () {},
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textStyleBody,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//ドラッグ時の表示画面
class _DraggingListItem extends StatelessWidget {
  const _DraggingListItem({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Transform.rotate(
      angle: 5 * pi / 180,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 120,
        decoration: BoxDecoration(
          color: theme.colorBgLayer1,
          border: Border.all(
            color: theme.colorFgDisabled,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textStyleBody,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
