import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';

final dummyBoardList = [
  const TBoardCompanion(
    projectId: Value("1"),
    boardId: Value("1"),
    name: Value('TODO'),
    isCompleted: Value(false),
  ),
  const TBoardCompanion(
    projectId: Value("1"),
    boardId: Value("2"),
    name: Value('作業中'),
    isCompleted: Value(false),
  ),
  const TBoardCompanion(
    projectId: Value("1"),
    boardId: Value("3"),
    name: Value('完了'),
    isCompleted: Value(true),
  ),
];
