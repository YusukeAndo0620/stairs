import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_item_provider.g.dart';

@riverpod
class TaskItem extends _$TaskItem {
  @override
  TaskItemModel build({
    required String boardId,
    required String taskItemId,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    List<ColorLabelModel>? labelList,
  }) =>
      TaskItemModel(
        boardId: boardId,
        taskItemId: taskItemId,
        title: title ?? '',
        description: description ?? '',
        startDate: startDate ?? DateTime.now(),
        endDate: endDate ?? DateTime.now().add(const Duration(days: 7)),
        labelList: labelList ?? [],
      );

  void updateTitle({required String title}) {
    state = state.copyWith(title: title);
  }

  void updateDescription({required String description}) {
    state = state.copyWith(description: description);
  }

  void updateStartDate({required DateTime startDate}) {
    state = state.copyWith(startDate: startDate);
  }

  void updateEndDate({required DateTime endDate}) {
    state = state.copyWith(endDate: endDate);
  }

  void updateDoneDate({required DateTime doneDate}) {
    state = state.copyWith(doneDate: doneDate);
  }

  void updateLabelList({required List<ColorLabelModel> labelList}) {
    state = state.copyWith(labelList: labelList);
  }
}
