import 'package:stairs/loom/loom_package.dart';

class ColorLabelModel {
  ColorLabelModel({
    required this.id,
    required this.labelName,
    required this.color,
    this.devLangId,
  });

  final String id;
  final String labelName;
  final Color color;
  final String? devLangId;

  factory ColorLabelModel.fromJson(dynamic json) {
    final id = json['id'];
    final labelName = json['name'];
    final color = getColorFromCode(code: json['color_id']);
    final devLangId = (json['dev_lang_id']);

    final model = ColorLabelModel(
      id: id,
      labelName: labelName,
      color: color,
      devLangId: devLangId,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = labelName;
    data['color_id'] = color.getColorId;
    data['dev_lang_id'] = devLangId;

    return data;
  }

  @override
  String toString() {
    return '''
      ColorLabelModel{
        id: $id,
        name: $labelName,
        color_id: ${color.getColorId},
        dev_lang_id: $devLangId,
      }
    ''';
  }
}
