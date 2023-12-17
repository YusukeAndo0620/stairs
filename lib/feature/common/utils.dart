import 'package:stairs/loom/loom_package.dart';

/// カンマ区切り
String getFormattedCommaSeparated({required int value}) {
  final formatter = NumberFormat("#,###");
  return formatter.format(value);
}

int getIdByColor({required List<ColorModel> colorList, required Color color}) {
  if (colorList.isEmpty) return 1;
  return colorList
      .firstWhere((item) => item.color.value == color.value,
          orElse: () => colorList[0])
      .id;
}

ColorModel getColorModelById(
    {required List<ColorModel> colorList, required int id}) {
  return colorList.firstWhere((item) => item.id == id,
      orElse: () => colorList[0]);
}

// 文字列のカラーコードからColorを取得
Color getColorFromCode({required String code}) {
  return Color(int.parse(code, radix: 16));
}

extension ColorExtension on Color {
  /// カラーコード取得
  String get getColorId => value.toRadixString(16);
}

extension BoolExtension on bool {
  /// 0: 無効（false）、1: 有効（true）
  String get parseString => this ? "1" : "0";
}

extension StringExtension on String {
  /// 0: 無効（false）、1: 有効（true）
  bool get parseBool => this == "1" ? true : false;
}
