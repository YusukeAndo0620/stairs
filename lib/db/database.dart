import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stairs/feature/common/utils.dart';
import 'package:stairs/loom/stairs_logger.dart';
import 'package:uuid/uuid.dart';

import 'db_package.dart';
import 'constant/color_list.dart';
import 'constant/dev_progress_list.dart';
import 'constant/tag_list.dart';
import 'constant/dev_language_list.dart';

part 'database.g.dart';

const _uuid = Uuid();
final _logger = stairsLogger(name: 'database');

@DriftDatabase(
  tables: [
    MColor,
    MAccount,
    MDevLanguage,
    MDevProgressList,
    TDevLanguage,
    TDevLanguageRel,
    TProject,
    TDevProgressRel,
    TTag,
    TTagRel,
    TTool,
    TOs,
    TDb,
    TBoard,
    TTask,
    TTaskTag,
    TTaskDev,
  ],
  daos: [
    MAccountDao,
  ],
)
class StairsDatabase extends _$StairsDatabase {
  StairsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          _logger.i('===Database: 作成開始====');
          await m.createAll();
          // アカウント
          final accountId = _uuid.v4();
          await into(mAccount).insert(
            MAccountCompanion(
              accountId: Value(accountId),
              address: const Value('ando08620@gmail.com'),
            ),
          );
          // カラー
          for (final item in colorList) {
            await into(mColor).insert(
              MColorCompanion(
                colorCodeId: Value(item.color.getColorId),
              ),
            );
          }
          // 開発言語
          for (final item in dummyDevLangList) {
            await into(mDevLanguage).insert(
              MDevLanguageCompanion(
                devLangId: Value(_uuid.v4()),
                name: Value(item),
                isReadOnly: const Value(true),
              ),
            );
          }
          // 開発工程
          for (final item in dummyDevProgressList) {
            await into(mDevProgressList).insert(
              MDevProgressListCompanion(
                name: Value(item.labelName),
              ),
            );
          }
          // タグ
          for (var i = 0; i < dummyTagList.length; i++) {
            await into(tTag).insert(
              TTagCompanion(
                name: Value(dummyTagList[i].labelName),
                colorId: Value(i),
                isReadOnly: const Value(true),
                accountId: Value(accountId),
              ),
            );
          }
          await migrateFromUnixTimestampsToText(m);
          _logger.i('===Database: 作成終了===');
        },
        onUpgrade: (m, from, to) async {
          _logger.i('===Database: 更新開始 schemaVersion: $schemaVersion===');
          await migrateFromUnixTimestampsToText(m);

          _logger.i('===Database: 更新終了===');
        },
      );

  Future<void> migrateFromUnixTimestampsToText(Migrator m) async {
    for (final table in allTables) {
      final dateTimeColumns =
          table.$columns.where((c) => c.type == DriftSqlType.dateTime);

      if (dateTimeColumns.isNotEmpty) {
        // This table has dateTime columns which need to be migrated.
        await m.alterTable(
          TableMigration(
            table,
            columnTransformer: {
              for (final column in dateTimeColumns)
                // We assume that the column in the database is an int (unix
                // timestamp), use `fromUnixEpoch` to convert it to a date time.
                // Note that the resulting value in the database is in UTC.
                column:
                    DateTimeExpressions.fromUnixEpoch(column.dartCast<int>()),
            },
          ),
        );
      }
    }
  }
}

LazyDatabase _openConnection() {
  _logger.i('===Database: 接続===');
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    },
  );
}
