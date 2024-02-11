import 'package:stairs/loom/loom_package.dart';

class ColorLabelModel {
  ColorLabelModel({
    required this.id,
    required this.labelName,
    required this.isReadOnly,
    required this.colorModel,
  });

  final String id;
  final String labelName;
  final bool isReadOnly;
  final ColorModel colorModel;

  factory ColorLabelModel.fromJson(dynamic json) {
    final id = json['id'];
    final labelName = json['name'];
    final isReadOnly = json['is_read_only'].parseBool;
    final colorModel = json['color_model'];

    final model = ColorLabelModel(
      id: id,
      labelName: labelName,
      isReadOnly: isReadOnly,
      colorModel: colorModel,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = labelName;
    data['is_read_only'] = isReadOnly.parseString;
    data['color_model'] = colorModel;

    return data;
  }

  @override
  String toString() {
    return '''

      ColorLabelModel{
        id: $id,
        name: $labelName,
        is_read_only: ${isReadOnly.parseString},
        color_model: $colorModel,
      }''';
  }
}
