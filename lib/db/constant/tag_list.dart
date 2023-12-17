import 'package:stairs/loom/loom_package.dart';
import '../constant/color_list.dart';

const _uuid = Uuid();

final dummyTagList = [
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '要件定義',
    color: colorList[0].color,
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '基本設計',
    color: colorList[1].color,
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '詳細設計',
    color: colorList[2].color,
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '画面設計書作成',
    color: colorList[3].color,
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: 'API設計書作成',
    color: colorList[4].color,
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '画面設計書修正',
    color: colorList[5].color,
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: 'API設計書修正',
    color: colorList[6].color,
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '新規実装',
    color: colorList[7].color,
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '実装修正',
    color: colorList[8].color,
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: 'バグ対応',
    color: colorList[9].color,
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: 'レビュー',
    color: colorList[10].color,
  ),
];
