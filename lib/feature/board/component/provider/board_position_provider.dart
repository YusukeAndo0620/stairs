import 'package:stairs/feature/board/model/board_position_model.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_position_provider.g.dart';

@riverpod
class BoardPosition extends _$BoardPosition {
  @override
  BoardPositionModel build() => BoardPositionModel(
        projectId: '',
        boardPositionMap: {},
        taskItemPositionMap: {},
      );

  void init({required String projectId}) {
    state = BoardPositionModel(
      projectId: projectId,
      boardPositionMap: {},
      taskItemPositionMap: {},
    );
  }

  void setBoardPosition({
    required String boardId,
    required GlobalKey key,
  }) {
    if (key.currentContext == null) return;
    final position = key.currentContext!.findRenderObject() as RenderBox;
    final targetMap = {...state.boardPositionMap};
    final positionInfo = PositionInfo(
      height: key.currentContext!.size!.height,
      width: key.currentContext!.size!.width,
      dx: position.localToGlobal(Offset.zero).dx,
      dy: position.localToGlobal(Offset.zero).dy,
    );

    if (targetMap.containsKey(boardId)) {
      targetMap[boardId] = positionInfo;
    } else {
      targetMap.addAll(
        {boardId: positionInfo},
      );
    }
    state = state.copyWith(boardPositionMap: targetMap);
  }

  void setTaskItemPosition({
    required String taskItemId,
    required GlobalKey key,
  }) {
    if (key.currentContext == null) return;
    final position = key.currentContext!.findRenderObject() as RenderBox;
    final targetMap = {...state.taskItemPositionMap};
    final positionInfo = PositionInfo(
      height: key.currentContext!.size!.height,
      width: key.currentContext!.size!.width,
      dx: position.localToGlobal(Offset.zero).dx,
      dy: position.localToGlobal(Offset.zero).dy,
    );

    if (targetMap.containsKey(taskItemId)) {
      targetMap[taskItemId] = positionInfo;
    } else {
      targetMap.addAll(
        {taskItemId: positionInfo},
      );
    }
    state = state.copyWith(taskItemPositionMap: targetMap);
  }
}
