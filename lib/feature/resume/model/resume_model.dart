import 'package:stairs/feature/resume/model/resume_project_model.dart';
import 'package:stairs/feature/resume/model/skill_label_model.dart';
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
    required this.qualification,
    required this.skillDevLangList,
    required this.dbList,
    required this.skillOsIdList,
    required this.skillMwIdList,
    required this.skillGitIdList,
    required this.skillDevEnvIdList,
    required this.projectList,
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
        qualification,
        skillDevLangList,
        dbList,
        skillOsIdList,
        skillMwIdList,
        skillGitIdList,
        skillDevEnvIdList,
        projectList,
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

  /// 資格
  final String qualification;

  /// スキル 開発言語・フレームワーク
  final List<SkillLabelModel> skillDevLangList;

  /// スキル DB
  final List<SkillLabelModel> dbList;

  /// スキル OS
  final List<String> skillOsIdList;

  /// スキル MW
  final List<String> skillMwIdList;

  /// スキル Git
  final List<String> skillGitIdList;

  /// スキル 開発環境
  final List<String> skillDevEnvIdList;

  /// プロジェクト情報
  final List<ResumeProjectModel> projectList;

  ResumeModel copyWith({
    String? name,
    SexType? sexType,
    String? countryName,
    int? age,
    String? academicBackground,
    String? strongTech,
    String? strongPoint,
    String? qualification,
    List<SkillLabelModel>? skillDevLangList,
    List<SkillLabelModel>? dbList,
    List<String>? skillOsIdList,
    List<String>? skillMwIdList,
    List<String>? skillGitIdList,
    List<String>? skillDevEnvIdList,
    List<ResumeProjectModel>? projectList,
  }) =>
      ResumeModel(
        name: name ?? this.name,
        sexType: sexType ?? this.sexType,
        countryName: countryName ?? this.countryName,
        age: age ?? this.age,
        academicBackground: academicBackground ?? this.academicBackground,
        strongTech: strongTech ?? this.strongTech,
        strongPoint: strongPoint ?? this.strongPoint,
        qualification: qualification ?? this.qualification,
        skillDevLangList: skillDevLangList ?? this.skillDevLangList,
        dbList: dbList ?? this.dbList,
        skillOsIdList: skillOsIdList ?? this.skillOsIdList,
        skillMwIdList: skillMwIdList ?? this.skillMwIdList,
        skillGitIdList: skillGitIdList ?? this.skillGitIdList,
        skillDevEnvIdList: skillDevEnvIdList ?? this.skillDevEnvIdList,
        projectList: projectList ?? this.projectList,
      );
}
