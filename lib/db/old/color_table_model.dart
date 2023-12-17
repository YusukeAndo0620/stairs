import 'package:stairs/db/old/table_model.dart';

const List<TableModel> colorTableModelList = [
  TableModel(
    columName: 'id',
    type: SqliteDataType.text,
    isPrime: true,
    isNotNull: true,
  ),
  TableModel(
    columName: 'color_id',
    type: SqliteDataType.text,
    isPrime: false,
    isNotNull: true,
  ),
];
