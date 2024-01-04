class PositionInfo {
  PositionInfo({
    required this.height,
    required this.width,
    required this.dx,
    required this.dy,
  });

  final double height;
  final double width;
  final double dx;
  final double dy;
}

class BoardPositionModel {
  BoardPositionModel({
    required this.projectId,
    required this.boardPositionMap,
    required this.taskItemPositionMap,
  });

  final String projectId;

  /// key: boardId
  final Map<String, PositionInfo> boardPositionMap;

  /// key: taskItemId
  final Map<String, PositionInfo> taskItemPositionMap;

  BoardPositionModel copyWith({
    String? projectId,
    Map<String, PositionInfo>? boardPositionMap,
    Map<String, PositionInfo>? taskItemPositionMap,
  }) =>
      BoardPositionModel(
        projectId: projectId ?? this.projectId,
        boardPositionMap: boardPositionMap ?? this.boardPositionMap,
        taskItemPositionMap: taskItemPositionMap ?? this.taskItemPositionMap,
      );
}
