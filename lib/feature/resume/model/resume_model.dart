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

  ResumeModel copyWith({
    String? name,
    SexType? sexType,
    String? countryName,
    int? age,
    String? academicBackground,
    String? strongTech,
    String? strongPoint,
  }) =>
      ResumeModel(
        name: name ?? this.name,
        sexType: sexType ?? this.sexType,
        countryName: countryName ?? this.countryName,
        age: age ?? this.age,
        academicBackground: academicBackground ?? this.academicBackground,
        strongTech: strongTech ?? this.strongTech,
        strongPoint: strongPoint ?? this.strongPoint,
      );
}
