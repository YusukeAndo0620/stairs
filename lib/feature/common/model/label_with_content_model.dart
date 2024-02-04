import 'package:stairs/loom/loom_package.dart';

class LabelWithContent extends LabelModel {
  LabelWithContent({
    required super.id,
    required this.labelId,
    required super.labelName,
    required this.content,
  });
  final String labelId;
  final String content;

  LabelWithContent copyWith({
    String? id,
    String? labelId,
    String? labelName,
    String? content,
  }) =>
      LabelWithContent(
        id: id ?? this.id,
        labelId: labelId ?? this.labelId,
        labelName: labelName ?? this.labelName,
        content: content ?? this.content,
      );
}
