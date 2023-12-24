import 'package:stairs/feature/board/model/task_item_model.dart';

class BoardModel {
  BoardModel({
    required this.projectId,
    required this.boardId,
    required this.title,
    required this.taskItemList,
  });

  final String projectId;
  final String boardId;
  final String title;
  final List<TaskItemModel> taskItemList;

  BoardModel copyWith({
    String? projectId,
    String? boardId,
    String? title,
    List<TaskItemModel>? taskItemList,
  }) =>
      BoardModel(
        projectId: projectId ?? this.projectId,
        boardId: boardId ?? this.boardId,
        title: title ?? this.title,
        taskItemList: taskItemList ?? this.taskItemList,
      );

  factory BoardModel.fromJson(dynamic json) {
    final projectId = json['project_id'];
    final boardId = json['board_id'];
    final title = json['title'];
    final taskItemList = json['task_item_list'];

    final model = BoardModel(
      boardId: boardId,
      projectId: projectId,
      title: title,
      taskItemList: taskItemList,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['project_id'] = projectId;
    data['board_id'] = boardId;
    data['title'] = title;
    data['task_item_list'] = taskItemList.map((e) => e.toJson()).toList();

    return data;
  }

  @override
  String toString() {
    return '''
      BoardModel{
        project_id: $projectId,
        board_id: $boardId,
        title: $title,
        task_item_list: ${taskItemList.map((e) => e.toJson()).toList()},
      }
    ''';
  }
}
