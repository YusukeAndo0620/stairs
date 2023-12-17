class LabelWithContent {
  LabelWithContent({
    required this.id,
    required this.labelId,
    required this.labelName,
    this.content,
  });
  final String id;
  final String labelId;
  final String labelName;
  final String? content;

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
