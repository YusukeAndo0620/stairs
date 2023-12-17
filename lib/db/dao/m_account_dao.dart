import 'package:drift/drift.dart';
import '../database.dart';
import '../model/m_account.dart';

part 'm_account_dao.g.dart';

@DriftAccessor(tables: [MAccount])
class MAccountDao extends DatabaseAccessor<StairsDatabase>
    with _$MAccountDaoMixin {
  MAccountDao(StairsDatabase db) : super(db);
}
