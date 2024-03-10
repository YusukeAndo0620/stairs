import 'package:stairs/loom/loom_package.dart';

class ProjectDetailModel {
  ProjectDetailModel({
    required this.projectId,
    required this.projectName,
    required this.themeColorModel,
    required this.industry,
    this.displayCount = 0,
    this.tableCount = 0,
    required this.startDate,
    required this.endDate,
    this.description = '',
    this.osList = const [],
    this.dbList = const [],
    this.devLanguageList = const [],
    this.toolList = const [],
    this.devProgressList = const [],
    this.devSize = 0,
    this.tagList = const [],
  });

  /// プロジェクトID
  final String projectId;

  /// プロジェクト名
  final String projectName;

  /// カラー
  final ColorModel themeColorModel;

  /// 業種
  final String industry;

  /// 画面数
  final int displayCount;

  /// 画面数
  final int tableCount;

  /// 開始日
  final DateTime startDate;

  /// 終了日
  final DateTime endDate;

  /// 説明
  final String description;

  /// OS
  final List<LabelModel> osList;

  /// DB
  final List<LabelModel> dbList;

  /// 開発言語
  final List<LabelWithContent> devLanguageList;

  /// 開発ツールリスト
  final List<LabelModel> toolList;

  /// 開発工程リスト
  final List<LabelModel> devProgressList;

  /// 開発人数
  final int devSize;

  /// タグリスト
  final List<ColorLabelModel> tagList;

  ProjectDetailModel copyWith({
    String? projectId,
    String? projectName,
    ColorModel? themeColorModel,
    String? industry,
    int? displayCount,
    int? tableCount,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    List<LabelModel>? osList,
    List<LabelModel>? dbList,
    List<LabelWithContent>? devLanguageList,
    List<LabelModel>? toolList,
    List<LabelModel>? devProgressList,
    int? devSize,
    List<ColorLabelModel>? tagList,
  }) =>
      ProjectDetailModel(
        projectId: projectId ?? this.projectId,
        projectName: projectName ?? this.projectName,
        themeColorModel: themeColorModel ?? this.themeColorModel,
        industry: industry ?? this.industry,
        displayCount: displayCount ?? this.displayCount,
        tableCount: tableCount ?? this.tableCount,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        description: description ?? this.description,
        osList: osList ?? this.osList,
        dbList: dbList ?? this.dbList,
        devLanguageList: devLanguageList ?? this.devLanguageList,
        toolList: toolList ?? this.toolList,
        devProgressList: devProgressList ?? this.devProgressList,
        devSize: devSize ?? this.devSize,
        tagList: tagList ?? this.tagList,
      );

  // factory ProjectDetailModel.fromJson(dynamic json) {
  //   final projectId = json['project_id'];
  //   final projectName = json['project_name'];
  //   final themeColor = getColorFromCode(code: json['color_id']);
  //   final industry = json['industry'];
  //   final displayCount = json['display_count'];
  //   final startDate = DateTime.parse(json['start_date']);
  //   final endDate = DateTime.parse(json['end_date']);
  //   final description = json['description'];
  //   final os = json['os'];
  //   final db = json['db'];

  //   // 開発言語
  //   final List<LinkTagModel> devLanguageList = [];
  //   for (final item in json["dev_language_list"]) {
  //     final linkTagModel = LinkTagModel.fromJson(item);
  //     devLanguageList.add(linkTagModel);
  //   }
  //   // 開発ツールリスト
  //   final List<LabelModel> toolList = [];
  //   for (final item in json["tool_list"]) {
  //     final labelModel = LabelModel.fromJson(item);
  //     toolList.add(labelModel);
  //   }
  //   // 開発工程リスト
  //   final List<LabelModel> devProgressList = [];
  //   for (final item in json["dev_progress_list"]) {
  //     final labelModel = LabelModel.fromJson(item);
  //     devProgressList.add(labelModel);
  //   }

  //   // 開発人数
  //   final devSize = json['dev_size'];

  //   // タグリスト
  //   final List<ColorLabelModel> tagList = [];
  //   for (final item in json["tag_list"]) {
  //     final colorLabelModel = ColorLabelModel.fromJson(item);
  //     tagList.add(colorLabelModel);
  //   }

  //   final model = ProjectDetailModel(
  //     projectId: projectId,
  //     projectName: projectName,
  //     themeColor: themeColor,
  //     industry: industry,
  //     displayCount: displayCount,
  //     startDate: startDate,
  //     endDate: endDate,
  //     description: description,
  //     os: os,
  //     db: db,
  //     devLanguageList: devLanguageList,
  //     toolList: toolList,
  //     devProgressList: devProgressList,
  //     devSize: devSize,
  //     tagList: tagList,
  //   );

  //   return model;
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = {};
  //   data['project_id'] = projectId;
  //   data['project_name'] = projectName;
  //   data['color_id'] = themeColor.getColorId;
  //   data['industry'] = industry;
  //   data['display_count'] = displayCount;
  //   data['start_date'] = startDate.toString();
  //   data['end_date'] = endDate.toString();
  //   data['description'] = description;
  //   data['os'] = os;
  //   data['db'] = db;

  //   // 開発言語
  //   final targetDevLanguageList = [];
  //   for (final item in devLanguageList) {
  //     final linkTagModel = item.toJson();
  //     targetDevLanguageList.add(linkTagModel);
  //   }
  //   data['dev_language_list'] = targetDevLanguageList;

  //   // 開発ツールリスト
  //   final targetToolList = [];
  //   for (final item in toolList) {
  //     final labelModel = item.toJson();
  //     targetToolList.add(labelModel);
  //   }
  //   data['tool_list'] = targetToolList;

  //   // 開発工程リスト
  //   final targetDevProgressList = [];
  //   for (final item in devProgressList) {
  //     final labelModel = item.toJson();
  //     targetDevProgressList.add(labelModel);
  //   }
  //   data['dev_progress_list'] = targetDevProgressList;

  //   // 開発人数
  //   data['dev_size'] = devSize;

  //   // タグリスト
  //   final targetTagList = [];
  //   for (final item in tagList) {
  //     final colorLabelModel = item.toJson();
  //     targetTagList.add(colorLabelModel);
  //   }
  //   data['tool_list'] = targetTagList;

  //   return data;
  // }

  // @override
  // String toString() {
  //   // 開発言語
  //   final targetDevLanguageList = [];
  //   for (final item in devLanguageList) {
  //     final linkTagModel = item.toJson();
  //     targetDevLanguageList.add(linkTagModel);
  //   }
  //   // 開発ツールリスト
  //   final targetToolList = [];
  //   for (final item in toolList) {
  //     final labelModel = item.toJson();
  //     targetToolList.add(labelModel);
  //   }

  //   // 開発工程リスト
  //   final targetDevProgressList = [];
  //   for (final item in devProgressList) {
  //     final labelModel = item.toJson();
  //     targetDevProgressList.add(labelModel);
  //   }
  //   // タグリスト
  //   final targetTagList = [];
  //   for (final item in tagList) {
  //     final colorLabelModel = item.toJson();
  //     targetTagList.add(colorLabelModel);
  //   }

  //   return '''
  //     ProjectDetailModel{
  //       project_id: $projectId,
  //       project_name: $projectName,
  //       color_id: ${themeColor.getColorId};,
  //       industry: $industry,
  //       display_count: $displayCount,
  //       start_date: ${startDate.toString()},
  //       end_date: ${endDate.toString()},
  //       description: $description,
  //       os: $os,
  //       db: $db,
  //       devLanguageList: $targetDevLanguageList,
  //       toolList: $targetToolList,
  //       devProgressList: $targetDevProgressList,
  //       dev_size: $devSize,
  //       tool_list: $targetTagList
  //     },
  //   ''';
  // }
}
