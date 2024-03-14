enum SkillColumnType {
  // 言語
  devLang('言語', 0),
  // フレームワーク
  framework('FW', 1),
  // DB
  db('DB', 2),
  // git
  git('Git', 3),
  // 開発環境
  devEnv('開発環境', 4),
  // ツール
  tool('その他ツール', 5),
  // 資格
  qualification('資格', 6);

  final String typeValue;
  final int columnCode;
  const SkillColumnType(this.typeValue, this.columnCode);
}

/// Column値からSkillColumnTypeを取得
SkillColumnType getSkillColumnTypeWithCol(int value) =>
    SkillColumnType.values.firstWhere((e) => e.columnCode == value);
