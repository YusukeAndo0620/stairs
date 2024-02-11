import 'package:stairs/loom/loom_package.dart';

class ColorModel {
  ColorModel({
    required this.id,
    required this.color,
  });

  final int id;
  final Color color;

  factory ColorModel.fromJson(dynamic json) {
    final id = json['id'];
    final color = getColorFromCode(code: json['color_id']);

    final model = ColorModel(
      id: id,
      color: color,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['color_id'] = color.getColorId;

    return data;
  }

  @override
  String toString() {
    return '''

      ColorModel {
        id: $id,
        color_id: ${color.getColorId},
      }''';
  }
}
