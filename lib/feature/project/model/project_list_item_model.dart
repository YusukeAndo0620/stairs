import 'package:stairs/loom/loom_package.dart';

class ProjectListItemModel {
  ProjectListItemModel({
    required this.projectId,
    required this.projectName,
    required this.themeColor,
  });

  final String projectId;
  final String projectName;
  final Color themeColor;

  factory ProjectListItemModel.fromJson(dynamic json) {
    final projectId = json['projectId'];
    final projectName = json['projectName'];
    final themeColor = getColorFromCode(code: json['themeColor']);

    final model = ProjectListItemModel(
      projectId: projectId,
      projectName: projectName,
      themeColor: themeColor,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['projectId'] = projectId;
    data['projectName'] = projectName;
    data['themeColor'] = themeColor.getColorId;

    return data;
  }

  @override
  String toString() {
    return '''
      ProjectListItemModel{
        projectId: $projectId, 
        projectName: $projectName, 
        themeColor: ${themeColor.getColorId},
      }
    ''';
  }
}
