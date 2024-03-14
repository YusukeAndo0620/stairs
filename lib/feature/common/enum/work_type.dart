enum WorkType {
  // PM
  pm('PM'),
  // PL
  pl('PL'),
  // SM
  sm('SM'),
  // TL
  tl('TL'),
  // SL
  sl('SL'),
  // 開発
  dev('開発'),
  // テスター
  tester('テスター');

  final String typeValue;
  const WorkType(this.typeValue);
}
