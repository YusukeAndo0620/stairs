import 'package:stairs/db/old/table_model.dart';

const List<TableModel> labelTableModelList = [
  TableModel(
    columName: 'id',
    type: SqliteDataType.text,
    isPrime: true,
    isNotNull: true,
  ),
  TableModel(
    columName: 'name',
    type: SqliteDataType.text,
    isPrime: false,
    isNotNull: true,
  ),
];
