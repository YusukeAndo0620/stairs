import 'package:stairs/loom/loom_package.dart';

const _kBorderWidth = 1.0;
const _kLabelTxt = 'ラベル';
const _kTaskHintTxt = 'タスク名を入力';
const _kTaskMaxLength = 100;
const _kLabelIconSize = 32.0;
const _kTitleAndLabelSpace = 24.0;

const _kContentPadding = EdgeInsets.all(8.0);
const _kDateContentPadding = EdgeInsets.only(right: 24.0);
const _kContentMargin = EdgeInsets.symmetric(vertical: 4.0);

/// 新規タスク入力アイテム
class NewTaskItem extends StatefulWidget {
  const NewTaskItem({
    super.key,
    required this.boardId,
    required this.themeColor,
    required this.title,
    required this.dueDate,
    required this.selectedLabelList,
    required this.labelList,
    required this.updateTitle,
    required this.updateDueDate,
    required this.updateLabelList,
  });
  final String boardId;
  final Color themeColor;
  final String title;
  final DateTime dueDate;
  final List<ColorLabelModel> selectedLabelList;
  final List<ColorLabelModel> labelList;
  final Function(String) updateTitle;
  final Function(DateTime) updateDueDate;
  final Function(List<ColorLabelModel>) updateLabelList;

  @override
  State<StatefulWidget> createState() => _NewTaskItemState();
}

class _NewTaskItemState extends State<NewTaskItem> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.title);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Container(
      width: double.infinity,
      padding: _kContentPadding,
      margin: _kContentMargin,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorFgDisabled,
          width: _kBorderWidth,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInput(
            textController: textController,
            hintText: _kTaskHintTxt,
            maxLength: _kTaskMaxLength,
            autoFocus: true,
            onSubmitted: (value) => widget.updateTitle(value),
            onChanged: (value) => widget.updateTitle(value),
          ),
          const SizedBox(
            height: _kTitleAndLabelSpace,
          ),
          Row(
            children: [
              Padding(
                padding: _kDateContentPadding,
                child: TapAction(
                  widget: LabelTip(
                    type: LabelTipType.square,
                    label: getFormattedDate(widget.dueDate),
                    textColor:
                        widget.dueDate.difference(DateTime.now()).inDays <= 0
                            ? theme.colorDangerBgDefault
                            : theme.colorFgDefault,
                    themeColor: theme.colorDisabled,
                    iconData: Icons.date_range,
                  ),
                  tappedColor: widget.themeColor,
                  onTap: () async {
                    DateTime? targetDate = await showDatePicker(
                      context: context,
                      initialDate: widget.dueDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      initialEntryMode: DatePickerEntryMode.calendar,
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: widget.themeColor, // ヘッダー背景色
                              onPrimary: LoomTheme.of(context)
                                  .colorBgLayer1, // ヘッダーテキストカラー
                              onSurface: LoomTheme.of(context)
                                  .colorFgDefault, // カレンダーのテキストカラー
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (targetDate != null) {
                      widget.updateDueDate(targetDate);
                    }
                  },
                ),
              ),
              IconBadge(
                icon: Icon(
                  Icons.label,
                  size: _kLabelIconSize,
                  color: widget.themeColor.withOpacity(0.6),
                ),
                badgeColor: widget.themeColor,
                tappedColor: widget.themeColor,
                count: widget.selectedLabelList.length,
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return SelectItemModal(
                      type: DisplayType.tile,
                      title: _kLabelTxt,
                      height: MediaQuery.of(context).size.height * 0.7,
                      labelList: widget.labelList,
                      selectedLabelList: widget.selectedLabelList,
                      onTapListItem: (labelList) =>
                          widget.updateLabelList(labelList),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
