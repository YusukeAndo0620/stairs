import 'package:stairs/feature/project/model/project_detail_model.dart';
import 'package:stairs/loom/loom_package.dart';

const _uuid = Uuid();

List<ProjectDetailModel> dummyProjectDetailList = [
  ProjectDetailModel(
    projectId: '1',
    projectName: '某生命保険リプレース案件',
    themeColor: const Color.fromARGB(255, 255, 31, 31),
    industry: '保険業',
    displayCount: 60,
    startDate: DateTime.parse('2011-09-01 00:00:00'),
    endDate: DateTime.parse('2011-12-01 00:00:00'),
    description: '某生命保険の社内管理システムリプレース案件に従事しました。',
    osList: [LabelModel(id: _uuid.v4(), labelName: 'Windows10')],
    dbList: [LabelModel(id: _uuid.v4(), labelName: 'MySQL')],
    devLanguageList: [],
    toolList: [],
    devProgressList: [],
    devSize: 50,
    tagList: [],
  ),
  ProjectDetailModel(
    projectId: '2',
    projectName: '某小売業顧客管理システムリニューアル案件',
    themeColor: Color.fromARGB(255, 11, 255, 3),
    industry: '小売業',
    displayCount: 134,
    startDate: DateTime.parse('2017-06-01 00:00:00'),
    endDate: DateTime.parse('2019-12-01 00:00:00'),
    description: '某小売業顧客管理システムリニューアル案件に従事しました。',
    osList: [],
    dbList: [],
    devLanguageList: [],
    toolList: [],
    devProgressList: [],
    devSize: 120,
    tagList: [],
  ),
];
