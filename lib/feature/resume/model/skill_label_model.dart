import 'package:stairs/loom/loom_package.dart';

class SkillLabelModel extends Equatable {
  const SkillLabelModel({
    required this.id,
    required this.labelId,
    required this.month,
  });

  /// ID
  final String id;

  /// ラベルID
  final String labelId;

  /// 月数
  final int month;

  @override
  List<Object?> get props => [
        id,
        labelId,
        month,
      ];

  SkillLabelModel copyWith({
    String? id,
    String? labelId,
    int? month,
  }) =>
      SkillLabelModel(
        id: id ?? this.id,
        labelId: labelId ?? this.labelId,
        month: month ?? this.month,
      );

  factory SkillLabelModel.fromJson(dynamic json) {
    final id = json['id'];
    final labelId = json['labelId'];
    final month = json['month'];

    final model = SkillLabelModel(
      id: id,
      labelId: labelId,
      month: month,
    );

    return model;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['labelId'] = labelId;
    data['month'] = month;

    return data;
  }

  @override
  String toString() {
    return 'SkillLabelModel{id: $id, labelId: $labelId, month: $month}';
  }
}
