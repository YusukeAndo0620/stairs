import 'package:stairs/loom/loom_package.dart';

/// カンマ区切り
String getFormattedCommaSeparated({required int value}) {
  final formatter = NumberFormat("#,###");
  return formatter.format(value);
}

/// yyyy/mm/dd 形式に変換
String getFormattedDate(DateTime date) {
  final formatter = DateFormat('yyyy/MM/dd');
  return formatter.format(date);
}

/// yyyy/mm/dd hh:mm 形式に変換
String getFormattedDateTime(DateTime date) {
  final formatter = DateFormat('yyyy/MM/dd hh:mm');
  return formatter.format(date);
}

/// mm/dd 形式に変換
String getFormattedMonthDate(DateTime date) {
  final formatter = DateFormat('MM/dd');
  return formatter.format(date);
}

/// yyyy/mm 形式に変換
String getFormattedYearMonthDate(DateTime date) {
  final formatter = DateFormat('yyyy/MM');
  return formatter.format(date);
}

// 対象日付が指定した範囲内の日付に存在するかどうか
bool isDateBetweenRange({
  required DateTime start,
  required DateTime end,
  required DateTime target,
}) {
  return start == target || (start.isBefore(target) && end.isAfter(target));
}

// 対象日付週の月曜日の日付を取得
DateTime getWeeklyInitialDate({required DateTime date}) {
  return date
      .subtract(
        Duration(days: date.weekday),
      )
      .add(const Duration(days: 1));
}

// 対象日付間で、土日を除いた時間(h)を取得
double getWeekdaysDifferenceInHours({
  required DateTime startDate,
  required DateTime endDate,
  required int startHour, // 開始日と終了日が一致した際の基準時刻（時間）
  required int addingHour, // 差分1日ごとに追加する時間
}) {
  double hour = 0;
  final targetEndDate = DateTime(endDate.year, endDate.month, endDate.day);
  for (DateTime date = startDate;
      date.isBefore(endDate);
      date = date.add(const Duration(days: 1))) {
    final targetStartDate = DateTime(date.year, date.month, date.day);
    // 終了日と同じ日付の場合、処理終了
    if (targetStartDate == targetEndDate) {
      // 9:00を始業日と扱う
      // 9:00以前にタスクが完了していた場合は0hとする。
      hour += endDate.hour - startHour <= 0
          ? 0
          : (DateTime(endDate.year, endDate.month, endDate.day, endDate.hour,
                  endDate.minute))
              .difference(date)
              .inHours;
      return hour;
    }
    if (date.weekday != DateTime.saturday && date.weekday != DateTime.sunday) {
      hour += addingHour;
    }
  }
  return hour;
}

/// %付与
String getFormattedPercent({required int percent}) => '$percent%';

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
  bool get parseBool => this == "1";
}
