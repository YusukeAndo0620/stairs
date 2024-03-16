import 'package:stairs/feature/resume/enum/project_column_type.dart';
import 'package:stairs/feature/resume/enum/skill_column_type.dart';

import 'package:stairs/loom/loom_package.dart';

class ResumeModel extends Equatable {
  const ResumeModel({
    required this.name,
    required this.sexType,
    required this.countryName,
    required this.age,
    required this.academicBackground,
    required this.strongTech,
    required this.strongPoint,
    required this.skillMap,
    required this.projectMap,
  });

  @override
  List<Object?> get props => [
        name,
        sexType,
        countryName,
        age,
        academicBackground,
        strongTech,
        strongPoint,
        skillMap,
        projectMap,
      ];

  /// 氏名
  final String name;

  /// 性別
  final SexType sexType;

  /// 国籍
  final String countryName;

  /// 年齢
  final int age;

  /// 学歴
  final String academicBackground;

  /// 得意技術
  final String strongTech;

  /// 自己PR
  final String strongPoint;

  /// スキルリスト key: SkillColumnType, value: Map<カラムインデックス, 値 >
  final Map<SkillColumnType, Map<int, String>> skillMap;

  /// プロジェクトMap key: プロジェクトID, value: Map<ProjectColumnType, Map<カラムインデックス, 値>>
  final Map<String, Map<ProjectColumnType, Map<int, String>>> projectMap;

  ResumeModel copyWith({
    String? name,
    SexType? sexType,
    String? countryName,
    int? age,
    String? academicBackground,
    String? strongTech,
    String? strongPoint,
    Map<SkillColumnType, Map<int, String>>? skillMap,
    Map<String, Map<ProjectColumnType, Map<int, String>>>? projectMap,
  }) =>
      ResumeModel(
        name: name ?? this.name,
        sexType: sexType ?? this.sexType,
        countryName: countryName ?? this.countryName,
        age: age ?? this.age,
        academicBackground: academicBackground ?? this.academicBackground,
        strongTech: strongTech ?? this.strongTech,
        strongPoint: strongPoint ?? this.strongPoint,
        skillMap: skillMap ?? this.skillMap,
        projectMap: projectMap ?? this.projectMap,
      );
}
