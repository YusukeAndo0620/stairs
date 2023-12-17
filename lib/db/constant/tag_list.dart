import 'package:stairs/loom/loom_package.dart';
import '../constant/color_list.dart';

const _uuid = Uuid();

final dummyTagList = [
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '要件定義',
    colorModel: colorList[0],
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '基本設計',
    colorModel: colorList[1],
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '詳細設計',
    colorModel: colorList[2],
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '画面設計書作成',
    colorModel: colorList[3],
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: 'API設計書作成',
    colorModel: colorList[4],
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '画面設計書修正',
    colorModel: colorList[5],
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: 'API設計書修正',
    colorModel: colorList[6],
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '新規実装',
    colorModel: colorList[7],
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: '実装修正',
    colorModel: colorList[8],
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: 'バグ対応',
    colorModel: colorList[9],
  ),
  ColorLabelModel(
    id: _uuid.v4(),
    labelName: 'レビュー',
    colorModel: colorList[10],
  ),
];
