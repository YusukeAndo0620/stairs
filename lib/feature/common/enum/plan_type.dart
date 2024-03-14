enum PlanType {
  free(0),
  standard(1);

  final int planValue;
  const PlanType(this.planValue);
}

/// 値からPlanTypeを取得
PlanType getPlanType(int value) =>
    PlanType.values.firstWhere((e) => e.planValue == value);
