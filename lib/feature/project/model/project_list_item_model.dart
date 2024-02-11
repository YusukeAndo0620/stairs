import 'package:stairs/loom/loom_package.dart';

class ProjectListItemModel {
  ProjectListItemModel({
    required this.projectId,
    required this.projectName,
    required this.themeColorModel,
  });

  final String projectId;
  final String projectName;
  final ColorModel themeColorModel;

  factory ProjectListItemModel.fromJson(dynamic json) {
    final projectId = json['project_id'];
    final projectName = json['project_name'];
    final themeColorModel = json['theme_color_model'];

    final model = ProjectListItemModel(
      projectId: projectId,
      projectName: projectName,
      themeColorModel: themeColorModel,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['project_id'] = projectId;
    data['project_name'] = projectName;
    data['theme_color_model'] = themeColorModel;
    return data;
  }

  @override
  String toString() {
    return '''

      ProjectListItemModel {
        project_id: $projectId, 
        project_name: $projectName, 
        theme_color_model: $themeColorModel,
      }''';
  }
}
