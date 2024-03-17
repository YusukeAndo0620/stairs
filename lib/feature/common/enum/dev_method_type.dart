enum DevMethodType {
  waterFall(0, 'ウォーターフォール'),
  agile(1, 'アジャイル');

  final int typeValue;
  final String name;
  const DevMethodType(this.typeValue, this.name);
}

/// 値からPlanTypeを取得
DevMethodType getDevMethodType(int value) =>
    DevMethodType.values.firstWhere((e) => e.typeValue == value);
