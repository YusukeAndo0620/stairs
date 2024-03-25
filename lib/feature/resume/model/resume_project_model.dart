import 'package:stairs/feature/resume/model/resume_tag_model.dart';
import 'package:stairs/loom/loom_package.dart';

class ResumeProjectModel {
  ResumeProjectModel({
    required this.projectId,
    required this.projectName,
    required this.industry,
    required this.devMethodType,
    this.description = '',
    this.devSize = 0,
    this.displayCount = 0,
    this.tableCount = 0,
    required this.startDate,
    required this.endDate,
    this.roleList = const [],
    this.devLanguageList = const [],
    this.osIdList = const [],
    this.devEnvIdList = const [],
    this.dbIdList = const [],
    this.mwIdList = const [],
    this.gitIdList = const [],
    this.toolIdList = const [],
    this.devProgressIdList = const [],
    this.tagList = const [],
  });

  /// プロジェクトID
  final String projectId;

  /// プロジェクト名
  final String projectName;

  /// 業種
  final String industry;

  /// 開発手法区分
  final DevMethodType devMethodType;

  /// 説明
  final String description;

  /// 開発人数
  final int devSize;

  /// 画面数
  final int displayCount;

  /// テーブル数
  final int tableCount;

  /// 開始日
  final DateTime startDate;

  /// 終了日
  final DateTime endDate;

  /// 役割
  final List<RoleType> roleList;

  /// 開発言語
  final List<LabelWithContent> devLanguageList;

  /// OS
  final List<String> osIdList;

  /// 開発環境
  final List<String> devEnvIdList;

  /// DB
  final List<String> dbIdList;

  /// ミドルウェア
  final List<String> mwIdList;

  /// Git
  final List<String> gitIdList;

  /// 開発ツールリスト
  final List<String> toolIdList;

  /// 開発工程リスト
  final List<String> devProgressIdList;

  /// タグリスト
  final List<ResumeTagModel> tagList;

  ResumeProjectModel copyWith({
    String? projectId,
    String? projectName,
    String? industry,
    DevMethodType? devMethodType,
    String? description,
    int? devSize,
    int? displayCount,
    int? tableCount,
    DateTime? startDate,
    DateTime? endDate,
    List<RoleType>? roleList,
    List<LabelWithContent>? devLanguageList,
    List<String>? osIdList,
    List<String>? devEnvIdList,
    List<String>? dbIdList,
    List<String>? mwIdList,
    List<String>? gitIdList,
    List<String>? toolIdList,
    List<String>? devProgressIdList,
    List<ResumeTagModel>? tagList,
  }) =>
      ResumeProjectModel(
        projectId: projectId ?? this.projectId,
        projectName: projectName ?? this.projectName,
        industry: industry ?? this.industry,
        description: description ?? this.description,
        devMethodType: devMethodType ?? this.devMethodType,
        devSize: devSize ?? this.devSize,
        displayCount: displayCount ?? this.displayCount,
        tableCount: tableCount ?? this.tableCount,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        roleList: roleList ?? this.roleList,
        devLanguageList: devLanguageList ?? this.devLanguageList,
        osIdList: osIdList ?? this.osIdList,
        devEnvIdList: devEnvIdList ?? this.devEnvIdList,
        dbIdList: dbIdList ?? this.dbIdList,
        mwIdList: mwIdList ?? this.mwIdList,
        toolIdList: toolIdList ?? this.toolIdList,
        gitIdList: gitIdList ?? this.gitIdList,
        devProgressIdList: devProgressIdList ?? this.devProgressIdList,
        tagList: tagList ?? this.tagList,
      );
}
