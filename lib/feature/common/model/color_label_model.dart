import 'package:stairs/loom/loom_package.dart';

class ColorLabelModel {
  ColorLabelModel({
    required this.id,
    required this.labelName,
    required this.colorModel,
  });

  final String id;
  final String labelName;
  final ColorModel colorModel;

  factory ColorLabelModel.fromJson(dynamic json) {
    final id = json['id'];
    final labelName = json['name'];
    final colorModel = json['color_model'];

    final model = ColorLabelModel(
      id: id,
      labelName: labelName,
      colorModel: colorModel,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = labelName;
    data['color_model'] = colorModel;

    return data;
  }

  @override
  String toString() {
    return '''
      ColorLabelModel{
        id: $id,
        name: $labelName,
        color_model: $colorModel,
      }
    ''';
  }
}
