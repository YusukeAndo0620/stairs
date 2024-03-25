import 'package:stairs/loom/loom_package.dart';

/// 経歴書でラベルに対するタスク数やラベル名を保持するmodel
class ResumeTagModel extends Equatable {
  const ResumeTagModel({
    required this.id,
    required this.labelId,
    required this.taskCount,
    required this.devLangId,
  });

  /// ID
  final String id;

  /// ラベルID
  final String labelId;

  /// タスク数
  final int taskCount;

  /// 開発言語
  final String devLangId;

  @override
  List<Object?> get props => [
        id,
        labelId,
        taskCount,
        devLangId,
      ];

  ResumeTagModel copyWith({
    String? id,
    String? labelId,
    int? taskCount,
    String? devLangId,
  }) =>
      ResumeTagModel(
        id: id ?? this.id,
        labelId: labelId ?? this.labelId,
        taskCount: taskCount ?? this.taskCount,
        devLangId: devLangId ?? this.devLangId,
      );

  factory ResumeTagModel.fromJson(dynamic json) {
    final id = json['id'];
    final labelId = json['name'];
    final taskCount = json['taskCount'];
    final devLangId = json['devLangId'];

    final model = ResumeTagModel(
      id: id,
      labelId: labelId,
      taskCount: taskCount,
      devLangId: devLangId,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['labelId'] = labelId;
    data['taskCount'] = taskCount;
    data['devLangId'] = devLangId;

    return data;
  }

  @override
  String toString() {
    return 'ResumeTagModel{id: $id, labelId: $labelId, taskCount: $taskCount, devLangId: $devLangId}';
  }
}
