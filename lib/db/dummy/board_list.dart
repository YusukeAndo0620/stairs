import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';

final dummyBoardList = [
  const TBoardCompanion(
    projectId: Value("1"),
    boardId: Value("1"),
    name: Value('TODO'),
    orderNo: Value(1),
    isCompleted: Value(false),
  ),
  const TBoardCompanion(
    projectId: Value("1"),
    boardId: Value("2"),
    name: Value('作業中'),
    orderNo: Value(2),
    isCompleted: Value(false),
  ),
  const TBoardCompanion(
    projectId: Value("1"),
    boardId: Value("3"),
    name: Value('完了'),
    orderNo: Value(999),
    isCompleted: Value(true),
  ),
  const TBoardCompanion(
    projectId: Value("2"),
    boardId: Value("4"),
    name: Value('作業中'),
    orderNo: Value(1),
    isCompleted: Value(false),
  ),
  const TBoardCompanion(
    projectId: Value("2"),
    boardId: Value("5"),
    name: Value('完了'),
    orderNo: Value(999),
    isCompleted: Value(true),
  ),
];
