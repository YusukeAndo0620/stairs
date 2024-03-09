enum LabelTableType {
  devLanguage,
  task,
}

extension LabelTableTypeExtension on LabelTableType {
  String get typeValue {
    switch (this) {
      case LabelTableType.devLanguage:
        return '開発言語';
      case LabelTableType.task:
        return '全タスク';
      default:
        return '';
    }
  }
}
