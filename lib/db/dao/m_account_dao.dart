import 'package:drift/drift.dart';
import 'package:stairs/db/db_package.dart';
import '../database.dart';

part 'm_account_dao.g.dart';

@DriftAccessor(tables: [MAccount])
class MAccountDao extends DatabaseAccessor<StairsDatabase>
    with _$MAccountDaoMixin {
  MAccountDao(StairsDatabase db) : super(db);
}
