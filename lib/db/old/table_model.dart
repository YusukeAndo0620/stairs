// SQLiteのデータ型
enum SqliteDataType {
  integer,
  text,
  real,
  blob,
}

extension SqliteDataTypeExtension on SqliteDataType {
  String get text {
    switch (this) {
      case SqliteDataType.integer:
        return 'INTEGER';
      case SqliteDataType.text:
        return 'TEXT';
      case SqliteDataType.real:
        return 'REAL';
      case SqliteDataType.blob:
        return 'BLOB';
    }
  }
}

class ForeignKeyModel {
  const ForeignKeyModel({
    required this.targetTableName,
    required this.targetColumnName,
  });

  final String targetTableName;
  final String targetColumnName;
}

class TableModel {
  const TableModel({
    required this.columName,
    required this.type,
    this.isPrime = false,
    this.isNotNull = true,
    this.foreignKeyModel,
  });

  final String columName;
  final SqliteDataType type;
  final bool isPrime;
  final bool isNotNull;
  final ForeignKeyModel? foreignKeyModel;
}
