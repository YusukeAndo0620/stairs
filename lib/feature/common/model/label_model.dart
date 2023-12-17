class LabelModel {
  LabelModel({
    required this.id,
    required this.labelName,
  });

  final String id;
  final String labelName;

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
