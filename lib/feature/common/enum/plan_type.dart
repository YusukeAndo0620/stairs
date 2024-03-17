enum PlanType {
  free(0),
  standard(1);

  final int typeValue;
  const PlanType(this.typeValue);
}

/// 値からPlanTypeを取得
PlanType getPlanType(int value) =>
    PlanType.values.firstWhere((e) => e.typeValue == value);
