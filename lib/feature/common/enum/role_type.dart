enum RoleType {
  // PM
  pm('PM', 1),
  // PL
  pl('PL', 2),
  // SM
  sm('SM', 3),
  // TL
  tl('TL', 4),
  // SL
  sl('SL', 5),
  // 開発
  dev('開発', 6),
  // テスター
  tester('テスター', 7);

  final String typeValue;
  final int code;
  const RoleType(this.typeValue, this.code);
}

/// 値からRoleTypeを取得
RoleType getRoleType(int code) =>
    RoleType.values.firstWhere((e) => e.code == code);
