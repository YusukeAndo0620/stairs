import 'package:stairs/db/database.dart';
import 'package:drift/drift.dart';

List<TProjectCompanion> dummyProjectDetailList = [
  const TProjectCompanion(
    projectId: Value('1'),
    name: Value('某生命保険リプレース案件'),
    colorId: Value(1),
    industry: Value('保険業'),
    displayCount: Value(60),
    startDate: Value('2011-09-01 00:00:00'),
    endDate: Value('2011-12-01 00:00:00'),
    description: Value('某生命保険の社内管理システムリプレース案件に従事しました。'),
    devSize: Value(50),
    accountId: Value('1'),
  ),
  const TProjectCompanion(
    projectId: Value('2'),
    name: Value('某小売業顧客管理システムリニューアル案件'),
    colorId: Value(3),
    industry: Value('小売業'),
    displayCount: Value(134),
    startDate: Value('2011-09-01 00:00:00'),
    endDate: Value('2011-12-01 00:00:00'),
    description: Value('某生命保険の社内管理システムリプレース案件に従事しました。'),
    devSize: Value(120),
    accountId: Value('1'),
  ),
];
List<TDevLanguageRelCompanion> dummyProjectDevLangRelList = [
  // Java
  const TDevLanguageRelCompanion(
    projectId: Value('1'),
    devLangId: Value('1e399688-9d4c-4b8e-98d7-6e02af716ab8'),
  )
];
