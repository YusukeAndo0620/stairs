import 'package:stairs/loom/loom_package.dart';

const _uuid = Uuid();
final dummyDevProgressList = [
  LabelModel(
    id: _uuid.v4(),
    labelName: '要件定義',
  ),
  LabelModel(
    id: _uuid.v4(),
    labelName: '基本設計',
  ),
  LabelModel(
    id: _uuid.v4(),
    labelName: '詳細設計',
  ),
  LabelModel(
    id: _uuid.v4(),
    labelName: '開発・製造',
  ),
  LabelModel(
    id: _uuid.v4(),
    labelName: '単体テスト',
  ),
  LabelModel(
    id: _uuid.v4(),
    labelName: '結合テスト',
  ),
  LabelModel(
    id: _uuid.v4(),
    labelName: '運用テスト',
  ),
  LabelModel(
    id: _uuid.v4(),
    labelName: '保守・運用',
  ),
];
