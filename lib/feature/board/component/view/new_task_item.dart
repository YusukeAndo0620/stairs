import 'package:stairs/feature/board/provider/task_item_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
class NewTaskItem extends ConsumerWidget {
  const NewTaskItem({
    super.key,
    required this.boardId,
    required this.themeColor,
    required this.labelList,
  });
  final String boardId;
  final Color themeColor;
  final List<ColorLabelModel> labelList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);

    final taskItemState =
        ref.watch(taskItemProvider(boardId: boardId, taskItemId: ''));
    final taskItemNotifier =
        ref.watch(taskItemProvider(boardId: boardId, taskItemId: '').notifier);

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
              textController: TextEditingController(text: taskItemState.title),
              hintText: _kTaskHintTxt,
              maxLength: _kTaskMaxLength,
              autoFocus: false,
              onSubmitted: (value) =>
                  taskItemNotifier.updateTitle(title: value)),
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
                    label: getFormattedDate(taskItemState.endDate),
                    textColor: taskItemState.endDate
                                .difference(DateTime.now())
                                .inDays <
                            3
                        ? theme.colorDangerBgDefault
                        : theme.colorFgDefault,
                    themeColor: theme.colorDisabled,
                    iconData: Icons.date_range,
                  ),
                  tappedColor: themeColor,
                  onTap: () async {
                    DateTime? targetDate = await showDatePicker(
                      context: context,
                      initialDate: taskItemState.endDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      initialEntryMode: DatePickerEntryMode.calendar,
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: themeColor, // ヘッダー背景色
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
                      taskItemNotifier.updateEndDate(endDate: targetDate);
                    }
                  },
                ),
              ),
              IconBadge(
                icon: Icon(
                  Icons.label,
                  size: _kLabelIconSize,
                  color: themeColor.withOpacity(0.6),
                ),
                badgeColor: themeColor,
                tappedColor: themeColor,
                count: taskItemState.labelList.length,
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return SelectItemModal(
                      type: DisplayType.tile,
                      title: _kLabelTxt,
                      height: MediaQuery.of(context).size.height * 0.7,
                      labelList: labelList,
                      selectedLabelList: taskItemState.labelList,
                      onTapListItem: (labelList) {
                        taskItemNotifier.updateLabelList(labelList: labelList);
                      },
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

String getFormattedDate(DateTime date) =>
    '${date.year}/${date.month}/${date.day}';
