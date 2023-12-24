import 'dart:math';
import 'package:collection/collection.dart';
import 'package:stairs/loom/loom_package.dart';

const _kEllipsisTxt = '...';
const _kBorderWidth = 1.0;
const _kTitleMaxLine = 2;
const _kTitleAndLabelSpace = 24.0;
const kDraggedItemHeight = 120.0;

const _kContentPadding = EdgeInsets.all(8.0);
const _kLabelContentPadding = EdgeInsets.only(right: 8.0, bottom: 8.0);
const _kContentMargin = EdgeInsets.symmetric(vertical: 4.0);

///ワークボードのカード内リストアイテム（ドラッグ可能）
class TaskListItem extends StatefulWidget {
  const TaskListItem({
    super.key,
    required this.id,
    required this.title,
    required this.themeColor,
    required this.dueDate,
    required this.labelList,
    required this.onTap,
    required this.onDragStarted,
    required this.onDragUpdate,
    required this.onDraggableCanceled,
    required this.onDragCompleted,
  });
  final String id;
  final String title;
  final DateTime dueDate;
  final Color themeColor;
  final List<ColorLabelModel> labelList;
  final VoidCallback onTap;
  final VoidCallback onDragStarted;
  final Function(DragUpdateDetails) onDragUpdate;
  final Function(Velocity, Offset) onDraggableCanceled;
  final VoidCallback onDragCompleted;

  @override
  State<StatefulWidget> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  final itemKey = GlobalKey<_TaskListItemState>();

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
    // context
    //     .read<BoardPositionBloc>()
    //     .add(BoardSetCardItemPosition(taskItemId: widget.id, key: itemKey));

    final theme = LoomTheme.of(context);
    return Draggable<String>(
      key: ValueKey(widget.id),
      data: widget.id,
      onDragStarted: widget.onDragStarted,
      onDragUpdate: (detail) => widget.onDragUpdate(detail),
      onDragCompleted: () => widget.onDragCompleted,
      onDraggableCanceled: (velocity, offset) =>
          widget.onDraggableCanceled(velocity, offset),
      feedback: _DraggingListItem(
        key: ValueKey(widget.id),
        title: widget.title,
        themeColor: widget.themeColor,
        dueDate: widget.dueDate,
        labelList: widget.labelList,
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
        onTap: widget.onTap,
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: theme.textStyleBody,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(
              height: _kTitleAndLabelSpace,
            ),
            _LabelArea(
              key: ValueKey(widget.id),
              themeColor: widget.themeColor,
              dueDate: widget.dueDate,
              labelList: widget.labelList,
            )
          ],
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
  });

  final String title;
  final DateTime dueDate;
  final Color themeColor;
  final List<ColorLabelModel> labelList;

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
            Text(
              title,
              style: theme.textStyleBody,
              overflow: TextOverflow.ellipsis,
              maxLines: _kTitleMaxLine,
            ),
            const SizedBox(
              height: _kTitleAndLabelSpace,
            ),
            _LabelArea(
              key: key,
              themeColor: themeColor,
              dueDate: dueDate,
              labelList: labelList,
              maxLength: 3,
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
    required this.dueDate,
    required this.labelList,
    this.maxLength = 4,
  });

  final Color themeColor;
  final DateTime dueDate;
  final List<ColorLabelModel> labelList;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    final isEllipsis = labelList.length >= maxLength;
    final displayLabelList = isEllipsis
        ? labelList.whereIndexed((index, element) => index < maxLength).toList()
        : labelList;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Padding(
          padding: _kLabelContentPadding,
          child: LabelTip(
            type: LabelTipType.square,
            label: _getFormattedDate(dueDate),
            textColor: dueDate.difference(DateTime.now()).inDays < 3
                ? theme.colorDangerBgDefault
                : theme.colorFgDefault,
            themeColor: theme.colorDisabled,
            iconData: Icons.date_range,
          ),
        ),
        for (final label in displayLabelList)
          Padding(
            padding: _kLabelContentPadding,
            child: LabelTip(
              label: label.labelName,
              themeColor: label.colorModel.color,
            ),
          ),
        if (isEllipsis)
          Text(
            _kEllipsisTxt,
            textAlign: TextAlign.center,
            style:
                theme.textStyleFootnote.copyWith(color: theme.colorFgDefault),
          )
      ],
    );
  }
}

String _getFormattedDate(DateTime date) =>
    '${date.year}/${date.month}/${date.day}';
