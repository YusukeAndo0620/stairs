import 'dart:math';
import 'package:collection/collection.dart';
import 'package:stairs/feature/board/component/provider/board_position_provider.dart';
import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:stairs/feature/board/provider/task_item_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kEllipsisTxt = '...';
const _kBorderWidth = 1.0;
const _kTitleMaxLine = 2;
const _kTitleAndLabelSpace = 5.0;
const kDraggedItemHeight = 100.0;

const _kContentPadding = EdgeInsets.all(8.0);
const _kLabelContentPadding = EdgeInsets.only(right: 8.0);
const _kContentMargin = EdgeInsets.symmetric(vertical: 4.0);

final _logger = stairsLogger(name: 'task_list_item');

///ワークボードのカード内リストアイテム（ドラッグ可能）
class TaskListItem extends ConsumerStatefulWidget {
  const TaskListItem({
    super.key,
    required this.boardId,
    required this.taskItemId,
    required this.themeColor,
    required this.title,
    required this.startDate,
    required this.dueDate,
    required this.labelList,
    required this.isReadOnly,
    required this.onTap,
    required this.onDragStarted,
    required this.onDragUpdate,
    required this.onDraggableCanceled,
    required this.onDragCompleted,
    required this.onDragEnd,
  });
  final String boardId;
  final String taskItemId;
  final Color themeColor;
  final String title;
  final DateTime startDate;
  final DateTime dueDate;
  final List<ColorLabelModel> labelList;
  final bool isReadOnly;
  final Function(TaskItemModel) onTap;
  final VoidCallback onDragStarted;
  final Function(DragUpdateDetails) onDragUpdate;
  final Function(Velocity, Offset) onDraggableCanceled;
  final VoidCallback onDragCompleted;
  final Function(DraggableDetails) onDragEnd;
  @override
  ConsumerState<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends ConsumerState<TaskListItem> {
  final itemKey = GlobalKey<_TaskListItemState>();
  final labelListController = ScrollController();

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
    _logger.d('ビルド開始 {task_title:$widget.title}');

    final taskItemState = ref.watch(
      TaskItemProvider(
        taskItemId: widget.taskItemId,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ポジション
      final positionNotifier = ref.read(boardPositionProvider.notifier);
      positionNotifier.setTaskItemPosition(
        taskItemId: widget.taskItemId,
        key: itemKey,
      );
      if (taskItemState.title.isEmpty) {
        final taskItemNotifier = ref.read(TaskItemProvider(
          taskItemId: widget.taskItemId,
        ).notifier);
        taskItemNotifier.setItem(
          boardId: widget.boardId,
          title: widget.title,
          startDate: widget.startDate,
          dueDate: widget.dueDate,
          labelList: widget.labelList,
        );
      }
    });

    final theme = LoomTheme.of(context);
    return AbsorbPointer(
      absorbing: widget.isReadOnly,
      child: Draggable<String>(
        key: ValueKey(taskItemState.taskItemId),
        data: taskItemState.taskItemId,
        onDragStarted: widget.onDragStarted,
        onDragUpdate: (detail) => widget.onDragUpdate(detail),
        onDragCompleted: () => widget.onDragCompleted,
        onDragEnd: (details) => widget.onDragEnd,
        onDraggableCanceled: (velocity, offset) =>
            widget.onDraggableCanceled(velocity, offset),
        feedback: _DraggingListItem(
          key: ValueKey(taskItemState.taskItemId),
          title: taskItemState.title,
          themeColor: widget.themeColor,
          dueDate: taskItemState.dueDate,
          labelList: taskItemState.labelList,
          labelListController: labelListController,
        ).testSelector('task_list_item_drag_item'),
        child: TapAction(
          key: itemKey,
          width: double.infinity,
          tappedColor: widget.themeColor.withOpacity(0.7),
          margin: _kContentMargin,
          padding: _kContentPadding,
          border: Border.all(
            color: widget.themeColor,
            width: _kBorderWidth,
          ),
          borderRadius: BorderRadius.circular(5.0),
          onTap: () => widget.onTap(taskItemState),
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      taskItemState.title,
                      style: theme.textStyleBody,
                      overflow: TextOverflow.ellipsis,
                      maxLines: _kTitleMaxLine,
                    ),
                  ),
                  _DueDateLabel(
                    key: widget.key,
                    dueDate: widget.dueDate,
                  ),
                ],
              ),
              const SizedBox(
                height: _kTitleAndLabelSpace,
              ),
              _LabelArea(
                key: ValueKey(taskItemState.taskItemId),
                themeColor: widget.themeColor,
                labelList: taskItemState.labelList,
                labelListController: labelListController,
              )
            ],
          ),
        ),
      ).testSelector('task_list_item_list_item'),
    ).testSelector('task_list_item');
  }
}

///ドラッグ時の表示画面
class _DraggingListItem extends StatelessWidget {
  const _DraggingListItem({
    super.key,
    required this.title,
    required this.themeColor,
    required this.dueDate,
    required this.labelList,
    required this.labelListController,
  });

  final String title;
  final DateTime dueDate;
  final Color themeColor;
  final List<ColorLabelModel> labelList;
  final ScrollController labelListController;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Transform.rotate(
      angle: 5 * pi / 180,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: kDraggedItemHeight,
        padding: _kContentPadding,
        margin: _kContentMargin,
        decoration: BoxDecoration(
          color: theme.colorBgLayer1,
          border: Border.all(
            color: themeColor,
            width: _kBorderWidth,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    title,
                    style: theme.textStyleBody,
                    overflow: TextOverflow.ellipsis,
                    maxLines: _kTitleMaxLine,
                  ),
                ),
                _DueDateLabel(
                  key: key,
                  dueDate: dueDate,
                ),
              ],
            ),
            const SizedBox(
              height: _kTitleAndLabelSpace,
            ),
            _LabelArea(
              key: key,
              themeColor: themeColor,
              labelList: labelList,
              labelListController: labelListController,
              isEllipsis: true,
            )
          ],
        ),
      ),
    );
  }
}

///ラベル表示エリア
class _LabelArea extends StatelessWidget {
  const _LabelArea({
    super.key,
    required this.themeColor,
    required this.labelList,
    required this.labelListController,
    this.isEllipsis = false,
  });

  final Color themeColor;
  final List<ColorLabelModel> labelList;
  final ScrollController labelListController;
  final bool isEllipsis;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    final displayLabelList = isEllipsis
        ? labelList.whereIndexed((index, element) => index < 3).toList()
        : labelList;
    return SingleChildScrollView(
      controller: labelListController,
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (final label in displayLabelList)
            Padding(
              padding: _kLabelContentPadding,
              child: LabelTip(
                label: label.labelName,
                themeColor: label.colorModel.color,
              ),
            ),
          if (isEllipsis && labelList.isNotEmpty)
            Text(
              _kEllipsisTxt,
              textAlign: TextAlign.center,
              style:
                  theme.textStyleFootnote.copyWith(color: theme.colorFgDefault),
            )
        ],
      ),
    );
  }
}

///期日ラベル
class _DueDateLabel extends StatelessWidget {
  const _DueDateLabel({
    super.key,
    required this.dueDate,
  });

  final DateTime dueDate;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return LabelTip(
      type: LabelTipType.square,
      label: getFormattedDate(dueDate),
      textColor: dueDate.difference(DateTime.now()).inDays < 3
          ? theme.colorDangerBgDefault
          : theme.colorFgDefault,
      themeColor: theme.colorDisabled,
      iconData: Icons.date_range,
    );
  }
}
