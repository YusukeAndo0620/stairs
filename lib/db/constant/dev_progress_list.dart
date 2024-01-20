import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';

final dummyDevProgressList = [
  const MDevProgressListCompanion(
    name: Value('要件定義'),
  ),
  const MDevProgressListCompanion(
    name: Value('基本設計'),
  ),
  const MDevProgressListCompanion(
    name: Value('詳細設計'),
  ),
  const MDevProgressListCompanion(
    name: Value('開発・製造'),
  ),
  const MDevProgressListCompanion(
    name: Value('単体テスト'),
  ),
  const MDevProgressListCompanion(
    name: Value('結合テスト'),
  ),
  const MDevProgressListCompanion(
    name: Value('運用テスト'),
  ),
  const MDevProgressListCompanion(
    name: Value('保守・運用'),
  ),
];
