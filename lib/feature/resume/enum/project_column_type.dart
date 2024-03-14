enum ProjectColumnType {
  // 開始日
  startDate('開始日', 0),
  // 終了日
  endDate('終了日', 1),
  // 概要
  title('概要', 2),
  // 開発手法
  devMethod('開発手法', 3),
  // 開発人数
  memberCount('開発人数', 4),
  // 担当業務・実装機能
  content('担当業務・実装機能', 5),
  // 役割
  role('役割', 6),
  // 画面数
  displayCount('画面数', 7),
  // テーブル数
  tableCount('テーブル数', 8),
  // 言語
  devLang('言語', 9),
  // フレームワーク
  framework('FW', 10),
  // OS
  os('OS', 11),
  // DB
  db('DB', 12),
  // ミドルウェアウェア
  mw('MW', 13),
  // Git管理
  git('コード管理', 14),
  // ツール
  tool('その他ツール', 15),
  // 開発工程
  devProgress('開発工程', 16);

  final String typeValue;
  final int columnCode;
  const ProjectColumnType(this.typeValue, this.columnCode);
}

/// Column値からProjectColumnTypeを取得
ProjectColumnType getProjectColumnTypeWithCol(int value) =>
    ProjectColumnType.values.firstWhere((e) => e.columnCode == value);
