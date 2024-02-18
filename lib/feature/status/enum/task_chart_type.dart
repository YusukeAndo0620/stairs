enum TaskChartType {
  threeMonth,
  monthly,
  weekly,
}

extension TaskChartTypeExtension on TaskChartType {
  String get typeValue {
    switch (this) {
      case TaskChartType.threeMonth:
        return '3ヶ月';
      case TaskChartType.monthly:
        return '1ヶ月';
      case TaskChartType.weekly:
        return '1週間';
    }
  }
}
