import 'package:drift/drift.dart';

/// アカウント
@TableIndex(name: 'account_id', columns: {#accountId})
class MAccount extends Table {
  TextColumn get accountId => text().withLength(min: 1, max: 50)();
  TextColumn get address => text().withLength(min: 1, max: 50)();
  TextColumn get planType =>
      text().withLength(min: 1, max: 1).withDefault(const Constant('0'))();
  TextColumn get createAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updateAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {accountId};
}
