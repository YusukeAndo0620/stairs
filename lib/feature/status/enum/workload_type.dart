enum WorkloadType {
  weekly,
  monthly,
  all,
}

extension WorkloadTypeExtension on WorkloadType {
  String get typeValue {
    switch (this) {
      case WorkloadType.all:
        return '全期間';
      case WorkloadType.monthly:
        return '直近1ヶ月';
      case WorkloadType.weekly:
        return '直近1週間';
    }
  }
}
