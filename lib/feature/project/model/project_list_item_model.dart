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
    final projectId = json['projectId'];
    final projectName = json['projectName'];
    final themeColorModel = json['themeColorModel'];

    final model = ProjectListItemModel(
      projectId: projectId,
      projectName: projectName,
      themeColorModel: themeColorModel,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['projectId'] = projectId;
    data['projectName'] = projectName;
    data['themeColorModel'] = themeColorModel;

    return data;
  }

  @override
  String toString() {
    return '''
      ProjectListItemModel{
        projectId: $projectId, 
        projectName: $projectName, 
        themeColorModel: $themeColorModel,
      }
    ''';
  }
}
