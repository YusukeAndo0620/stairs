import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';

final dummyTaskList = [
  const TTaskCompanion(
    boardId: Value("1"),
    taskId: Value("1"),
    name: Value("アカウント作成画面実装"),
    description: Value("アカウント作成画面のFE実装。"),
    orderNo: Value(1),
    startDate: Value("2023-12-01 00:00:00"),
    dueDate: Value("2024-02-01 00:00:00"),
    endDate: Value.absent(),
  ),
  const TTaskCompanion(
    boardId: Value("1"),
    taskId: Value("2"),
    name: Value("商品一覧API設計"),
    description: Value("商品一覧のAPI設計"),
    orderNo: Value(2),
    startDate: Value("2023-12-21 00:00:00"),
    dueDate: Value("2024-03-05 00:00:00"),
    endDate: Value.absent(),
  ),
  const TTaskCompanion(
    boardId: Value("2"),
    taskId: Value("3"),
    name: Value("保険明細書帳票設計"),
    description: Value("保険明細書帳票設計"),
    orderNo: Value(1),
    startDate: Value("2024-01-01 00:00:00"),
    dueDate: Value("2024-02-23 00:00:00"),
    endDate: Value.absent(),
  ),
  const TTaskCompanion(
    boardId: Value("3"),
    taskId: Value("4"),
    name: Value("商品詳細BE実装"),
    description: Value("商品詳細画面の取得API実装"),
    orderNo: Value(1),
    startDate: Value("2024-01-21 00:00:00"),
    dueDate: Value("2024-02-10 00:00:00"),
    endDate: Value("2024-02-11 00:00:00"),
  ),
  const TTaskCompanion(
    boardId: Value("3"),
    taskId: Value("5"),
    name: Value("管理者登録画面に禁則文字バリデーション追加"),
    description: Value("管理者登録画面に禁則文字バリデーション追加"),
    orderNo: Value(2),
    startDate: Value("2023-11-26 00:00:00"),
    dueDate: Value("2023-12-30 00:00:00"),
    endDate: Value("2024-01-11 00:00:00"),
  ),
];

final dummyTaskTagList = [
  const TTaskTagCompanion(
    taskId: Value("1"),
    tagRelId: Value(1),
  ),
  const TTaskTagCompanion(
    taskId: Value("1"),
    tagRelId: Value(2),
  ),
  const TTaskTagCompanion(
    taskId: Value("1"),
    tagRelId: Value(3),
  ),
  const TTaskTagCompanion(
    taskId: Value("2"),
    tagRelId: Value(1),
  ),
  const TTaskTagCompanion(
    taskId: Value("2"),
    tagRelId: Value(4),
  ),
  const TTaskTagCompanion(
    taskId: Value("2"),
    tagRelId: Value(11),
  ),
  const TTaskTagCompanion(
    taskId: Value("3"),
    tagRelId: Value(5),
  ),
  const TTaskTagCompanion(
    taskId: Value("4"),
    tagRelId: Value(5),
  ),
  const TTaskTagCompanion(
    taskId: Value("4"),
    tagRelId: Value(7),
  ),
  const TTaskTagCompanion(
    taskId: Value("4"),
    tagRelId: Value(9),
  ),
];
final dummyTaskDevList = [
  const TTaskDevCompanion(
    taskId: Value("1"),
    devLangId: Value("1e399688-9d4c-4b8e-98d7-6e02af716ab8"),
  ),
  const TTaskDevCompanion(
    taskId: Value("2"),
    devLangId: Value(""),
  ),
  const TTaskDevCompanion(
    taskId: Value("3"),
    devLangId: Value("1e399688-9d4c-4b8e-98d7-6e02af716ab8"),
  ),
  const TTaskDevCompanion(
    taskId: Value("4"),
    devLangId: Value(""),
  ),
  const TTaskDevCompanion(
    taskId: Value("5"),
    devLangId: Value("1e399688-9d4c-4b8e-98d7-6e02af716ab8"),
  ),
];
