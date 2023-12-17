import 'package:stairs/db/old/color_table_model.dart';
import 'package:stairs/db/old/dev_language_table_model.dart';
import 'package:stairs/db/old/label_table_model.dart';
import 'package:stairs/db/old/table_model.dart';
import 'package:stairs/db/old/project_table_model.dart';

/// key: テーブル名
final Map<String, List<TableModel>> tableMap = {
  /// カラーマスターテーブル,
  'm_color': colorTableModelList,

  /// プロジェクトテーブル
  't_project': projectTableModelList,

  /// カラーラベルテーブル,
  't_color_label': colorTableModelList,

  /// 開発言語テーブル,
  't_dev_language': devLanguageTableModelList,

  /// ラベルテーブル,
  't_label': labelTableModelList,
};
