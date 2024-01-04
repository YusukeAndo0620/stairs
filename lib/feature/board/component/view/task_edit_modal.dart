import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:stairs/feature/board/provider/task_item_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kBottomSpaceHeight = 30.0;
const _kTaskItemTitleHintTxt = 'タスク名を入力';
const _kTaskItemDescriptionTxt = '説明';
const _kTaskItemDescriptionHintTxt = '説明を入力';
const _kTaskItemStartDateTxt = '開始日';
const _kTaskItemStartDateHintTxt = '開始日を入力';
const _kTaskItemEndDateTxt = '期日';
const _kTaskItemEndDateHintTxt = '期日を入力';
const _kLabelTxt = 'ラベル';
const _kLabelHintTxt = 'ラベルを設定';

/// タスク編集モーダル
class TaskEditModal extends ConsumerWidget {
  const TaskEditModal({
    super.key,
    required this.themeColor,
    required this.taskItem,
    required this.labelList,
    required this.onChangeTaskItem,
  });

  final Color themeColor;
  final TaskItemModel taskItem;
  final List<ColorLabelModel> labelList;
  final Function(TaskItemModel) onChangeTaskItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskItemState =
        ref.watch(taskItemProvider(taskItemId: taskItem.taskItemId));
    final taskItemNotifier =
        ref.watch(taskItemProvider(taskItemId: taskItem.taskItemId).notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (taskItemState.title.isEmpty) {
        taskItemNotifier.setItem(
          boardId: taskItem.boardId,
          title: taskItem.title,
          description: taskItem.description,
          startDate: taskItem.startDate,
          dueDate: taskItem.dueDate,
          labelList: taskItem.labelList,
        );
      }
    });

    final theme = LoomTheme.of(context);
    final titleTxtController = TextEditingController(text: taskItemState.title);

    return Modal(
      onClose: onChangeTaskItem(taskItemState),
      buildMainContent: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // タスク名
          TextInput(
            textController: titleTxtController,
            hintText: _kTaskItemTitleHintTxt,
            autoFocus: false,
            onSubmitted: (value) {
              taskItemNotifier.updateTitle(title: value);
            },
          ),
          // 説明
          CardLstItem.input(
              label: _kTaskItemDescriptionTxt,
              iconData: theme.icons.trash,
              iconColor: themeColor,
              inputValue: taskItemState.description,
              hintText: _kTaskItemDescriptionHintTxt,
              onSubmitted: (value) =>
                  taskItemNotifier.updateDescription(description: value)),
          //開始日
          CardLstItem.labeWithIcon(
            label: _kTaskItemStartDateTxt,
            iconColor: themeColor,
            iconData: theme.icons.calender,
            hintText: _kTaskItemStartDateHintTxt,
            itemList: [
              Text(
                _getFormattedDate(taskItemState.startDate),
                style: theme.textStyleBody,
              )
            ],
            onTap: () async {
              DateTime? targetDate = await showDatePicker(
                context: context,
                initialDate: taskItemState.startDate,
                firstDate: DateTime(1990, 1, 1),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                initialEntryMode: DatePickerEntryMode.calendar,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: themeColor, // ヘッダー背景色
                        onPrimary:
                            LoomTheme.of(context).colorBgLayer1, // ヘッダーテキストカラー
                        onSurface: LoomTheme.of(context)
                            .colorFgDefault, // カレンダーのテキストカラー
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (targetDate != null) {
                taskItemNotifier.updateStartDate(startDate: targetDate);
              }
            },
          ),
          // 期日
          CardLstItem.labeWithIcon(
            label: _kTaskItemEndDateTxt,
            iconColor: themeColor,
            iconData: theme.icons.calender,
            hintText: _kTaskItemEndDateHintTxt,
            itemList: [
              Text(
                _getFormattedDate(taskItemState.dueDate),
                style: theme.textStyleBody,
              )
            ],
            onTap: () async {
              DateTime? targetDate = await showDatePicker(
                context: context,
                initialDate: taskItemState.doneDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                initialEntryMode: DatePickerEntryMode.calendar,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: themeColor, // ヘッダー背景色
                        onPrimary:
                            LoomTheme.of(context).colorBgLayer1, // ヘッダーテキストカラー
                        onSurface: LoomTheme.of(context)
                            .colorFgDefault, // カレンダーのテキストカラー
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (targetDate != null) {
                taskItemNotifier.updateDueDate(dueDate: targetDate);
              }
            },
          ),
          // ラベル
          CardLstItem.labeWithIcon(
            label: _kLabelTxt,
            iconColor: themeColor,
            iconData: Icons.label,
            hintText: _kLabelHintTxt,
            itemList: [
              for (final item in taskItemState.labelList)
                LabelTip(
                  label: item.labelName,
                  themeColor: item.colorModel.color,
                )
            ],
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
                    onTapListItem: (linkLabelList) => taskItemNotifier
                        .updateLabelList(labelList: linkLabelList));
              },
            ),
          ),
          const SizedBox(
            height: _kBottomSpaceHeight,
          ),
        ],
      ),
    );
  }
}

String _getFormattedDate(DateTime date) =>
    '${date.year}/${date.month}/${date.day}';
