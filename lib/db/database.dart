import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stairs/db/constant/country_code_list.dart';
import 'package:stairs/db/constant/db_list.dart';
import 'package:stairs/loom/stairs_logger.dart';

import 'db_package.dart';
import 'constant/color_list.dart';
import 'constant/dev_progress_list.dart';
import 'constant/tag_list.dart';

part 'database.g.dart';

final _logger = stairsLogger(name: 'database');

@DriftDatabase(
  tables: [
    MColor,
    MAccount,
    MCountryCode,
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
    TDbRel,
    TBoard,
    TTask,
    TTaskTag,
    TTaskDev,
    TResumeProject,
    TResumeRole,
    TResumeDevLangRel,
    TResumeTag,
  ],
  daos: [
    MAccountDao,
    MCountryCodeDao,
    TProjectDao,
    TOsInfoDao,
    TDbDao,
    TDbRelDao,
    TDevLangRelDao,
    TToolDao,
    TDevProgressRelDao,
    TTagDao,
    TTagRelDao,
    TDevLangDao,
    TBoardDao,
    TTaskDao,
    TTaskTagDao,
    TTaskDevDao,
    TResumeProjectDao,
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
          try {
            await transaction(() async {
              await m.createAll();
              // アカウント
              await into(mAccount).insert(
                const MAccountCompanion(
                  accountId: Value('1'),
                  firstName: Value('安藤'),
                  lastName: Value('優介'),
                  isMale: Value(true),
                  birthDate: Value('1996-06-20 00:00:00'),
                  address: Value('ando08620@gmail.com'),
                  countryCode: Value(83),
                  academicBackground: Value('明治大学 理工学部'),
                  strongTech: Value('Java, Vue.js'),
                  strongPoint: Value(
                      '私はxxxxに自信があり、基本設計~保守運用まで一貫した経験があるため、柔軟な対応を得意としております。'),
                ),
              );
              // 国コード
              for (final item in defaultCountryCodeList) {
                await into(mCountryCode).insert(item);
              }
              // カラー
              for (final item in colorList) {
                await into(mColor).insert(item);
              }
              // 開発言語
              for (final item in defaultTDevLangList) {
                await into(tDevLanguage).insert(item);
              }
              // DB
              for (final item in defaultDbList) {
                await into(tDb).insert(item);
              }
              // 開発工程
              for (final item in defaultDevProgressList) {
                await into(mDevProgressList).insert(item);
              }
              // タグ（ラベル）
              for (final item in defaultTagList) {
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
              // プロジェクト 開発言語紐付けダミーデータ
              for (final item in dummyProjectDevLangRelList) {
                await into(tDevLanguageRel).insert(item);
              }
              // ボードダミーダータ
              for (final item in dummyBoardList) {
                await into(tBoard).insert(item);
              }
              // タスクダミーダータ
              for (final item in dummyTaskList) {
                await into(tTask).insert(item);
              }
              // タスクタグダミーダータ
              for (final item in dummyTaskTagList) {
                await into(tTaskTag).insert(item);
              }
              // タスク開発言語ダミーダータ
              for (final item in dummyTaskDevList) {
                await into(tTaskDev).insert(item);
              }
            });
          } on Exception catch (exception) {
            _logger.e(exception);
            rethrow;
          } finally {
            _logger.i('===Database: 作成終了===');
          }
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
      final file = File(join(dbFolder.path, 'stairs.sqlite'));
      return NativeDatabase(file);
    },
  );
}
