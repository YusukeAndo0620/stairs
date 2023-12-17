import 'package:stairs/db/old/table_model.dart';

const List<TableModel> colorLabelTableModelList = [
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
  TableModel(
    columName: 'color_id',
    type: SqliteDataType.text,
    isPrime: false,
    isNotNull: true,
  ),
  TableModel(
    columName: 'dev_lang_id',
    type: SqliteDataType.text,
    isPrime: false,
    isNotNull: false,
    foreignKeyModel: ForeignKeyModel(
      targetTableName: 'id',
      targetColumnName: 't_dev_language',
    ),
  ),
];
