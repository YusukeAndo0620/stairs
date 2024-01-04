import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_item_provider.g.dart';

@riverpod
class TaskItem extends _$TaskItem {
  @override
  TaskItemModel build({
    required String taskItemId,
  }) =>
      TaskItemModel(
        boardId: '',
        taskItemId: taskItemId,
        title: '',
        description: '',
        startDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 7)),
        labelList: [],
      );

  void init() {
    state = TaskItemModel(
      boardId: '',
      taskItemId: '',
      title: '',
      description: '',
      startDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 7)),
      labelList: [],
    );
  }

  void setItem({
    String? boardId,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? dueDate,
    List<ColorLabelModel>? labelList,
  }) {
    state = state.copyWith(
      boardId: boardId,
      title: title,
      description: description,
      startDate: startDate,
      dueDate: dueDate,
      labelList: labelList,
    );
  }

  void updateTitle({required String title}) {
    state = state.copyWith(title: title);
  }

  void updateDescription({required String description}) {
    state = state.copyWith(description: description);
  }

  void updateStartDate({required DateTime startDate}) {
    state = state.copyWith(startDate: startDate);
  }

  void updateDueDate({required DateTime dueDate}) {
    state = state.copyWith(dueDate: dueDate);
  }

  void updateDoneDate({required DateTime doneDate}) {
    state = state.copyWith(doneDate: doneDate);
  }

  void updateLabelList({required List<ColorLabelModel> labelList}) {
    state = state.copyWith(labelList: labelList);
  }
}
