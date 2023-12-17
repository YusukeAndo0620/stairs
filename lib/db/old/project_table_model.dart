import 'package:stairs/db/old/table_model.dart';

const List<TableModel> projectTableModelList = [
  TableModel(
    columName: 'project_id',
    type: SqliteDataType.text,
    isPrime: true,
    isNotNull: true,
  ),
  TableModel(
    columName: 'project_name',
    type: SqliteDataType.text,
    isPrime: false,
    isNotNull: true,
  ),
  TableModel(
    columName: 'color_id',
    type: SqliteDataType.text,
    isPrime: false,
    isNotNull: true,
  ),
  TableModel(
    columName: 'industry',
    type: SqliteDataType.text,
    isPrime: false,
    isNotNull: true,
  ),
  TableModel(
    columName: 'display_count',
    type: SqliteDataType.integer,
    isPrime: false,
    isNotNull: true,
  ),
  TableModel(
    columName: 'start_date',
    type: SqliteDataType.text,
    isPrime: false,
    isNotNull: true,
  ),
  TableModel(
    columName: 'end_date',
    type: SqliteDataType.text,
    isPrime: false,
    isNotNull: true,
  ),
  TableModel(
    columName: 'description',
    type: SqliteDataType.text,
    isPrime: false,
    isNotNull: true,
  ),
  TableModel(
    columName: 'os',
    type: SqliteDataType.text,
    isPrime: false,
    isNotNull: true,
  ),
  TableModel(
    columName: 'db',
    type: SqliteDataType.text,
    isPrime: false,
    isNotNull: true,
  ),
  TableModel(
    columName: 'dev_size',
    type: SqliteDataType.integer,
    isPrime: false,
    isNotNull: true,
  ),
];
