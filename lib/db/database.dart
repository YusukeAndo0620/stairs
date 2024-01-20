import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stairs/db/dao/m_dev_lang_dao.dart';
import 'package:stairs/db/dao/t_board_dao.dart';
import 'package:stairs/db/dao/t_db_dao.dart';
import 'package:stairs/db/dao/t_dev_lang_dao.dart';
import 'package:stairs/db/dao/t_dev_lang_rel_dao.dart';
import 'package:stairs/db/dao/t_dev_progress_rel_dao.dart';
import 'package:stairs/db/dao/t_os_info_dao.dart';
import 'package:stairs/db/dao/t_project_dao.dart';
import 'package:stairs/db/dao/t_tag_dao.dart';
import 'package:stairs/db/dao/t_tag_rel_dao.dart';
import 'package:stairs/db/dao/t_task_dao.dart';
import 'package:stairs/db/dao/t_tool_dao.dart';
import 'package:stairs/db/dummy/dummy_project_detail.dart';
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
    TOsInfo,
    TDb,
    TBoard,
    TTask,
    TTaskTag,
    TTaskDev,
  ],
  daos: [
    MAccountDao,
    MDevLangDao,
    TProjectDao,
    TOsInfoDao,
    TDbDao,
    TDevLangRelDao,
    TToolDao,
    TDevProgressRelDao,
    TTagDao,
    TTagRelDao,
    TDevLangDao,
    TBoardDao,
    TTaskDao,
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
          await into(mAccount).insert(
            const MAccountCompanion(
              accountId: Value('1'),
              address: Value('ando08620@gmail.com'),
            ),
          );
          // カラー
          for (final item in colorList) {
            await into(mColor).insert(item);
          }
          // 開発言語
          for (final item in dummyDevLangList) {
            await into(mDevLanguage).insert(item);
          }
          // 開発工程
          for (final item in dummyDevProgressList) {
            await into(mDevProgressList).insert(item);
          }
          // タグ（ラベル）
          for (final item in dummyTagList) {
            await into(tTag).insert(item);
          }
          final tagListQuery = select(tTag)
            ..where((tbl) => tbl.accountId.equals('1'));
          final tagList = await tagListQuery.get();

          // プロジェクトダミーダータ
          for (final item in dummyProjectDetailList) {
            await into(tProject).insert(item);
            for (final tagItem in tagList) {
              await into(tTagRel).insert(
                TTagRelCompanion(
                  colorId: Value(tagItem.colorId),
                  projectId: item.projectId,
                  tagId: Value(tagItem.id),
                ),
              );
            }
          }
          _logger.i('===Database: 作成終了===');
        },
        onUpgrade: (m, from, to) async {
          _logger.i('===Database: 更新開始 schemaVersion: $schemaVersion===');
          _logger.i('===Database: 更新終了===');
        },
      );
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
