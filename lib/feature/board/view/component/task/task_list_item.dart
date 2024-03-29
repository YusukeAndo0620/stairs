import 'dart:math';
import 'package:collection/collection.dart';
import 'package:stairs/feature/board/provider/board_position_provider.dart';
import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:stairs/feature/board/provider/task_item_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kEllipsisTxt = '...';
const _kBorderWidth = 1.0;
const _kTitleMaxLine = 2;
const _kTitleAndLabelSpace = 5.0;
const kDraggedItemHeight = 90.0;

const _kContentPadding = EdgeInsets.all(8.0);
const _kLabelContentPadding = EdgeInsets.only(right: 8.0);
const _kContentMargin = EdgeInsets.symmetric(vertical: 4.0);

const _kIconAndContentsSpace = 4.0;
const _kIconSize = 16.0;

final _logger = stairsLogger(name: 'task_list_item');

///ワークボードのカード内リストアイテム（ドラッグ可能）
class TaskListItem extends ConsumerStatefulWidget {
  const TaskListItem({
    super.key,
    required this.themeColor,
    required this.boardId,
    required this.taskItemId,
    required this.title,
    required this.description,
    required this.devLangId,
    required this.orderNo,
    required this.startDate,
    required this.dueDate,
    this.doneDate,
    required this.labelList,
    required this.isReadOnly,
    required this.onTap,
    required this.onOccurError,
    required this.onDragStarted,
    required this.onDragUpdate,
    required this.onDraggableCanceled,
    required this.onDragCompleted,
    required this.onDragEnd,
  });
  final Color themeColor;
  // タスク要素 Start
  final String boardId;
  final String taskItemId;
  final String title;
  final String description;
  final String devLangId;
  final int orderNo;
  final DateTime startDate;
  final DateTime dueDate;
  final DateTime? doneDate;
  final List<ColorLabelModel> labelList;
  // タスク要素 End
  final bool isReadOnly;
  final Function(TaskItemModel) onTap;
  final VoidCallback onOccurError;
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
    final taskItemState = ref.watch(
      TaskItemProvider(
        taskItemId: widget.taskItemId,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        // ポジション
        final positionNotifier = ref.watch(boardPositionProvider.notifier);
        positionNotifier.setTaskItemPosition(
          taskItemId: widget.taskItemId,
          key: itemKey,
        );
        if (taskItemState.title.isEmpty) {
          final taskItemNotifier = ref.watch(TaskItemProvider(
            taskItemId: widget.taskItemId,
          ).notifier);
          taskItemNotifier.setItem(
            boardId: widget.boardId,
            title: widget.title,
            description: widget.description,
            devLangId: widget.devLangId,
            orderNo: widget.orderNo,
            startDate: widget.startDate,
            dueDate: widget.dueDate,
            doneDate: widget.doneDate,
            labelList: widget.labelList,
          );
        }
      } on Exception catch (exception) {
        _logger.e(exception);
        // ボード一覧際取得
        widget.onOccurError();
      }
    });

    final taskTitleWidth = MediaQuery.of(context).size.width * 0.55;

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
          taskTitleWidth: taskTitleWidth,
          themeColor: widget.themeColor,
          dueDate: taskItemState.dueDate,
          doneDate: taskItemState.doneDate,
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
              _TaskItemHeader(
                title: taskItemState.title,
                taskTitleWidth: taskTitleWidth,
                dueDate: taskItemState.dueDate,
                doneDate: taskItemState.doneDate,
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
    required this.taskTitleWidth,
    required this.themeColor,
    required this.dueDate,
    this.doneDate,
    required this.labelList,
    required this.labelListController,
  });

  final String title;
  final double taskTitleWidth;
  final DateTime dueDate;
  final DateTime? doneDate;
  final Color themeColor;
  final List<ColorLabelModel> labelList;
  final ScrollController labelListController;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Transform.rotate(
      angle: 5 * pi / 180,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
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
                _TaskItemHeader(
                  title: title,
                  taskTitleWidth: taskTitleWidth,
                  dueDate: dueDate,
                  doneDate: doneDate,
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

///タスクアイテム ヘッダーエリア
class _TaskItemHeader extends StatelessWidget {
  const _TaskItemHeader({
    required this.title,
    required this.taskTitleWidth,
    required this.dueDate,
    this.doneDate,
  });

  final String title;
  final double taskTitleWidth;
  final DateTime dueDate;
  final DateTime? doneDate;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: taskTitleWidth,
          child: Text(
            title,
            style: theme.textStyleBody,
            overflow: TextOverflow.ellipsis,
            maxLines: _kTitleMaxLine,
          ),
        ),
        _DueDateLabel(
          dueDate: dueDate,
          doneDate: doneDate,
        ),
      ],
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
    required this.dueDate,
    this.doneDate,
  });

  final DateTime dueDate;
  final DateTime? doneDate;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    final color =
        doneDate == null && dueDate.difference(DateTime.now()).inDays <= 0
            ? theme.colorDangerBgDefault
            : theme.colorFgDefault;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.date_range,
          size: _kIconSize,
          color: color,
        ),
        const SizedBox(
          width: _kIconAndContentsSpace,
        ),
        Text(
          getFormattedDate(dueDate),
          style: theme.textStyleFootnote.copyWith(color: color),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
