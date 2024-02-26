import 'package:stairs/feature/board/model/task_item_model.dart';
import 'package:stairs/loom/loom_package.dart';

@immutable
class BoardModel extends Equatable {
  const BoardModel({
    required this.projectId,
    required this.boardId,
    required this.title,
    required this.orderNo,
    this.isCompleted = false,
    required this.taskItemList,
  });

  final String projectId;
  final String boardId;
  final String title;
  final int orderNo;
  final bool isCompleted;
  final List<TaskItemModel> taskItemList;

  @override
  List<Object?> get props => [
        projectId,
        boardId,
        title,
        orderNo,
        isCompleted,
        taskItemList,
      ];

  BoardModel copyWith({
    String? projectId,
    String? boardId,
    String? title,
    int? orderNo,
    bool? isCompleted,
    List<TaskItemModel>? taskItemList,
  }) =>
      BoardModel(
        projectId: projectId ?? this.projectId,
        boardId: boardId ?? this.boardId,
        title: title ?? this.title,
        orderNo: orderNo ?? this.orderNo,
        isCompleted: isCompleted ?? this.isCompleted,
        taskItemList: taskItemList ?? this.taskItemList,
      );

  factory BoardModel.fromJson(dynamic json) {
    final projectId = json['project_id'];
    final boardId = json['board_id'];
    final title = json['title'];
    final orderNo = json['order_no'];
    final isCompleted = json['is_completed'];
    final taskItemList = json['task_item_list'];

    final model = BoardModel(
      boardId: boardId,
      projectId: projectId,
      title: title,
      orderNo: orderNo,
      isCompleted: isCompleted,
      taskItemList: taskItemList,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['project_id'] = projectId;
    data['board_id'] = boardId;
    data['title'] = title;
    data['order_no'] = orderNo;
    data['is_completed'] = isCompleted;
    data['task_item_list'] = taskItemList.map((e) => e.toJson()).toList();

    return data;
  }

  @override
  String toString() {
    return '''

      BoardModel {
        project_id: $projectId,
        board_id: $boardId,
        title: $title,
        orderNo: $orderNo,
        isCompleted: $isCompleted,
        task_item_list: ${taskItemList.map((e) => e.toJson()).toList()},
      }''';
  }
}
