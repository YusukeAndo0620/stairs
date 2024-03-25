import 'package:stairs/loom/loom_package.dart';

class LabelModel extends Equatable {
  const LabelModel({
    required this.id,
    required this.labelName,
  });

  /// ID
  final String id;

  /// 名称
  final String labelName;

  @override
  List<Object?> get props => [
        id,
        labelName,
      ];

  LabelModel copyWith({
    String? id,
    String? labelName,
  }) =>
      LabelModel(
        id: id ?? this.id,
        labelName: labelName ?? this.labelName,
      );

  factory LabelModel.fromJson(dynamic json) {
    final id = json['id'];
    final labelName = json['name'];

    final model = LabelModel(
      id: id,
      labelName: labelName,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = labelName;

    return data;
  }

  @override
  String toString() {
    return 'LabelModel{id: $id, name: $labelName}';
  }
}
